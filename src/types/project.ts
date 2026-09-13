/**
 * Normalized project model.
 *
 * IMPORTANT: Field names mirror the EXISTING Firestore documents exactly
 * (verified against live data on 2026-09-08): every current document has
 * `title`, `description`, `imageUrl`, `githubUrl`. Other fields are optional
 * so new documents can opt in without breaking the site.
 */
export interface Project {
  /** Firestore document ID. Stable. */
  id: string;

  /** URL-safe slug (explicit `slug` field if present, else derived from title). */
  slug: string;

  title: string;
  description: string;
  /** Absolute image URL. May be empty — UI must provide a fallback. */
  imageUrl: string;

  /** Optional extended fields (used by UI only when present). */
  githubUrl?: string;
  liveUrl?: string;
  techStack?: string[];
  category?: string;
  featured?: boolean;
  order?: number;
  year?: string;
  status?: string;
  role?: string;
  problem?: string;
  solution?: string;
  features?: string[];
  images?: string[];
  longDescription?: string;
  challenges?: string[];
  results?: string[];

  /** Firestore createTime, ISO string — used as a stable sort key. */
  createdAt: string;
}
