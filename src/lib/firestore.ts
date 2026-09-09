/**
 * Minimal Firestore REST data-access layer (server-side only).
 *
 * Why REST instead of the Firebase JS SDK?
 * - Zero client-side JS shipped for data
 * - No SDK bundle, no real-time listeners (small site, one sensible query,
 *   no unnecessary document reads)
 * - Works in the Astro server runtime with plain fetch
 *
 * Caching: an in-memory cache with a 60-second TTL keeps repeated requests
 * within the same server instance from re-hitting Firestore. Rendered pages
 * additionally benefit from Netlify's CDN caching of SSR output.
 */

import { getFirebaseConfig } from './firebase';

export interface RawDoc {
  id: string;
  fields: Record<string, unknown>;
  createTime: string;
}

export class FirestoreUnavailableError extends Error {
  readonly cause?: unknown;
  constructor(message = 'Firestore is temporarily unavailable', cause?: unknown) {
    super(message);
    this.name = 'FirestoreUnavailableError';
    this.cause = cause;
  }
}

/* ------------------------------ value decoding ----------------------------- */

type FirestoreValue = {
  stringValue?: string;
  booleanValue?: boolean;
  integerValue?: string;
  doubleValue?: number;
  timestampValue?: string;
  nullValue?: null;
  arrayValue?: { values?: FirestoreValue[] };
};

function decodeValue(v: FirestoreValue | undefined): unknown {
  if (v === undefined || v.nullValue !== undefined) return undefined;
  if (v.stringValue !== undefined) return v.stringValue;
  if (v.booleanValue !== undefined) return v.booleanValue;
  if (v.integerValue !== undefined) return Number(v.integerValue);
  if (v.doubleValue !== undefined) return v.doubleValue;
  if (v.timestampValue !== undefined) return v.timestampValue;
  if (v.arrayValue) {
    const values = v.arrayValue.values ?? [];
    return values.map(decodeValue);
  }
  return undefined;
}

export function decodeFields(raw: Record<string, FirestoreValue>): Record<string, unknown> {
  const out: Record<string, unknown> = {};
  for (const [key, value] of Object.entries(raw)) {
    out[key] = decodeValue(value);
  }
  return out;
}

/* ---------------------------------- fetch ---------------------------------- */

const CACHE_TTL_MS = 60_000;
let cache: { docs: RawDoc[]; at: number } | null = null;
let inFlight: Promise<RawDoc[]> | null = null;

async function fetchProjectDocs(): Promise<RawDoc[]> {
  const now = Date.now();
  if (cache && now - cache.at < CACHE_TTL_MS) return cache.docs;
  if (inFlight) return inFlight;

  inFlight = (async () => {
    const { apiKey, projectId } = getFirebaseConfig();
    const url =
      `https://firestore.googleapis.com/v1/projects/${projectId}` +
      `/databases/(default)/documents/projects?pageSize=100&key=${encodeURIComponent(apiKey)}`;

    let res: Response;
    try {
      res = await fetch(url, { headers: { Accept: 'application/json' } });
    } catch (cause) {
      throw new FirestoreUnavailableError('Network error while contacting Firestore', cause);
    }

    if (!res.ok) {
      throw new FirestoreUnavailableError(
        `Firestore responded with status ${res.status}`,
        await res.text().catch(() => undefined),
      );
    }

    const json = (await res.json()) as { documents?: { name: string; fields?: Record<string, FirestoreValue>; createTime?: string }[] };
    const docs: RawDoc[] = (json.documents ?? []).map((d) => ({
      id: d.name.split('/').pop() ?? d.name,
      fields: d.fields ? decodeFields(d.fields) : {},
      createTime: d.createTime ?? new Date(0).toISOString(),
    }));

    cache = { docs, at: Date.now() };
    return docs;
  })();

  try {
    return await inFlight;
  } finally {
    inFlight = null;
  }
}

export { fetchProjectDocs };
