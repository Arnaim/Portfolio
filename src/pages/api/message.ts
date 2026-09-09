/**
 * POST /api/message — contact form endpoint (SSR, server-only).
 *
 * Writes { name, email, message, createdAt } to the SAME `messages` collection
 * the Flutter app used — preserving the existing workflow.
 *
 * No secrets involved: writes go through the public Firestore REST API, so
 * Firestore Security Rules must allow creating `messages` docs (same rules the
 * Flutter app already required). Validate + rate-limit here before writing.
 */
import type { APIRoute } from 'astro';

export const prerender = false;

const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;

// Naive per-instance rate limit: max 5 messages per minute per IP.
const hits = new Map<string, { count: number; reset: number }>();
const RATE_LIMIT = 5;
const WINDOW_MS = 60_000;

function rateLimited(ip: string): boolean {
  const now = Date.now();
  const entry = hits.get(ip);
  if (!entry || now > entry.reset) {
    hits.set(ip, { count: 1, reset: now + WINDOW_MS });
    return false;
  }
  entry.count += 1;
  return entry.count > RATE_LIMIT;
}

export const POST: APIRoute = async ({ request, clientAddress }) => {
  const ip = clientAddress ?? 'unknown';
  const json = (body: unknown, status: number) =>
    new Response(JSON.stringify(body), {
      status,
      headers: { 'Content-Type': 'application/json', 'Cache-Control': 'no-store' },
    });

  if (rateLimited(ip)) {
    return json({ ok: false, error: 'Too many messages. Please try again in a minute.' }, 429);
  }

  let payload: { name?: unknown; email?: unknown; message?: unknown };
  try {
    const contentType = request.headers.get('content-type') ?? '';
    if (contentType.includes('application/json')) {
      payload = await request.json();
    } else {
      const form = await request.formData();
      payload = {
        name: form.get('name'),
        email: form.get('email'),
        message: form.get('message'),
      };
    }
  } catch {
    return json({ ok: false, error: 'Invalid request body.' }, 400);
  }

  const name = typeof payload.name === 'string' ? payload.name.trim() : '';
  const email = typeof payload.email === 'string' ? payload.email.trim() : '';
  const message = typeof payload.message === 'string' ? payload.message.trim() : '';

  if (!name || !message || !EMAIL_RE.test(email)) {
    return json({ ok: false, error: 'Please provide a name, a valid email, and a message.' }, 422);
  }

  if (name.length > 200 || email.length > 320 || message.length > 5000) {
    return json({ ok: false, error: 'Message is too long.' }, 413);
  }

  try {
    const { getFirebaseConfig } = await import('../../lib/firebase');
    const { apiKey, projectId } = getFirebaseConfig();

    const res = await fetch(
      `https://firestore.googleapis.com/v1/projects/${projectId}/databases/(default)/documents/messages?key=${encodeURIComponent(apiKey)}`,
      {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          fields: {
            name: { stringValue: name },
            email: { stringValue: email },
            message: { stringValue: message },
            createdAt: { timestampValue: new Date().toISOString() },
          },
        }),
      },
    );

    if (!res.ok) {
      // Log details server-side; return a generic message to the visitor.
      console.error(`messages write failed: ${res.status}`, await res.text().catch(() => ''));
      return json({ ok: false, error: 'Could not send your message right now. Please email me directly.' }, 502);
    }

    return json({ ok: true }, 200);
  } catch (err) {
    console.error('contact endpoint error', err);
    return json({ ok: false, error: 'Could not send your message right now. Please email me directly.' }, 500);
  }
};
