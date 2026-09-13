/**
 * Project repository: raw Firestore docs → normalized Project records.
 *
 * The mapping layer is tolerant by design: every current document has exactly
 * { title, description, imageUrl, githubUrl } (verified against live data), but
 * the schema may grow. All extended fields are optional and defensive.
 */
import { fetchProjectDocs } from './firestore';
import type { Project } from '../types/project';

/** URL-safe slug from a title: "Storyloom" → "storyloom", "SDG-For-Youth" → "sdg-for-youth". */
export function slugify(input: string): string {
  return input
    .toLowerCase()
    .trim()
    .replace(/['’]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
    .slice(0, 80) || 'untitled';
}

/** Coerce an unknown value safely. */
const asString = (v: unknown): string | undefined =>
  typeof v === 'string' && v.trim() !== '' ? v.trim() : undefined;
const asStringArray = (v: unknown): string[] | undefined =>
  Array.isArray(v) ? v.filter((x): x is string => typeof x === 'string' && x.trim() !== '') : undefined;

function normalize(raw: Record<string, unknown>, id: string, createTime: string): Project {
  const title = asString(raw.title) ?? 'Untitled Project';
  const explicitSlug = asString(raw.slug);

  return {
    id,
    slug: explicitSlug ? slugify(explicitSlug) : slugify(title),
    title,
    description: asString(raw.description) ?? 'No description yet.',
    imageUrl: asString(raw.imageUrl) ?? '',
    githubUrl: asString(raw.githubUrl),
    liveUrl: asString(raw.liveUrl),
    techStack: asStringArray(raw.techStack),
    category: asString(raw.category),
    featured: typeof raw.featured === 'boolean' ? raw.featured : undefined,
    order: typeof raw.order === 'number' ? raw.order : undefined,
    year: asString(raw.year),
    status: asString(raw.status),
    role: asString(raw.role),
    problem: asString(raw.problem),
    solution: asString(raw.solution),
    features: asStringArray(raw.features),
    images: asStringArray(raw.images),
    longDescription: asString(raw.longDescription),
    challenges: asStringArray(raw.challenges),
    results: asStringArray(raw.results),
    createdAt: createTime,
  };
}

/**
 * All projects, ordered for presentation.
 *
 * Ordering strategy (spec §8):
 *  1. explicit `order` field (ascending, if present)
 *  2. explicit `featured` first (if present)
 *  3. newest first (Firestore createTime — matches the Flutter app's
 *     "recent projects" behavior without requiring an index)
 */
export async function getProjects(): Promise<Project[]> {
  const docs = await fetchProjectDocs();
  const projects = docs.map((d) => normalize(d.fields, d.id, d.createTime));

  return projects.sort((a, b) => {
    if (a.order !== undefined && b.order !== undefined && a.order !== b.order) {
      return a.order - b.order;
    }
    if (a.order !== undefined) return -1;
    if (b.order !== undefined) return 1;
    if (a.featured !== undefined && b.featured !== undefined && a.featured !== b.featured) {
      return a.featured ? -1 : 1;
    }
    if (a.featured !== undefined) return a.featured ? -1 : 1;
    if (b.featured !== undefined) return b.featured ? 1 : -1;
    return b.createdAt.localeCompare(a.createdAt);
  });
}

/** Every distinct slug → first project that owns it (dedupes collisions). */
function slugMap(projects: Project[]): Map<string, Project> {
  const map = new Map<string, Project>();
  for (const p of projects) {
    if (!map.has(p.slug)) map.set(p.slug, p);
  }
  return map;
}

export async function getProjectBySlug(slug: string): Promise<Project | undefined> {
  const map = slugMap(await getProjects());
  return map.get(slug);
}

/** URL for a project — single source of truth for project hrefs. */
export function projectHref(p: Project): string {
  return `/projects/${p.slug}`;
}
