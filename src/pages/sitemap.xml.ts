/**
 * Dynamic sitemap.xml — includes every Firestore-driven project URL.
 *
 * A static sitemap integration cannot know project pages that live in
 * Firestore, so the sitemap is generated at request time from the SAME
 * data source the site uses. If Firestore is down, the static pages are
 * still listed (graceful degradation).
 */
import type { APIRoute } from 'astro';
import { getProjects } from '../lib/projects';
import { SITE_URL } from '../lib/site';

export const prerender = false;

const STATIC_ROUTES: { path: string; changefreq: string; priority: string }[] = [
  { path: '/', changefreq: 'weekly', priority: '1.0' },
  { path: '/projects', changefreq: 'weekly', priority: '0.9' },
  { path: '/about', changefreq: 'monthly', priority: '0.7' },
  { path: '/contact', changefreq: 'monthly', priority: '0.6' },
];

function urlEntry(loc: string, changefreq: string, priority: string, lastmod?: string): string {
  return [
    '  <url>',
    `    <loc>${loc}</loc>`,
    lastmod ? `    <lastmod>${lastmod}</lastmod>` : null,
    `    <changefreq>${changefreq}</changefreq>`,
    `    <priority>${priority}</priority>`,
    '  </url>',
  ]
    .filter(Boolean)
    .join('\n');
}

export const GET: APIRoute = async () => {
  const urls: string[] = [];

  for (const r of STATIC_ROUTES) {
    urls.push(urlEntry(`${SITE_URL}${r.path}`, r.changefreq, r.priority));
  }

  try {
    const projects = await getProjects();
    for (const p of projects) {
      urls.push(
        urlEntry(
          `${SITE_URL}/projects/${p.slug}`,
          'monthly',
          '0.8',
          p.createdAt.slice(0, 10), // Firestore createTime → YYYY-MM-DD
        ),
      );
    }
  } catch {
    // Static routes above remain valid even if Firestore is unreachable.
  }

  const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls.join('\n')}
</urlset>`;

  return new Response(xml, {
    headers: {
      'Content-Type': 'application/xml; charset=utf-8',
      'Cache-Control': 'public, max-age=0, s-maxage=3600, stale-while-revalidate=86400',
    },
  });
};
