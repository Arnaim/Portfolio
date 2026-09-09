# Naimur Rahman Arnab — Astro Portfolio

Portfolio website built with **Astro (SSR)** on **Netlify**. Content is managed in **Cloud Firestore** and served as server-rendered HTML.

> The original Flutter app was removed from the repo; recoverable from git history if ever needed.

---

## 1. What was migrated

- Identity content: name, role, hero copy, About paragraphs, certificates, skills groups, email / GitHub / LinkedIn / CV links
- Assets: `Naimur_Rahman_Arnab_CV.pdf`, `profile.jpeg`, `og-image.png` (now in `public/`)
- Contact form → still writes to the same Firestore `messages` collection (via a server endpoint instead of client SDK)
- All 8 project documents render from live Firestore — nothing was duplicated into code

Not migrated: the dark navy/purple theme and the 3-column card grid (intentionally replaced — see design system).

## 2. New architecture

```
Firestore (projects, messages)
      ↓  REST (server-side fetch, no client SDK)
src/lib/  firebase.ts → config · firestore.ts → REST client + 60s cache
      ↓
src/lib/projects.ts → normalization + ordering + slugs (adapter layer)
      ↓
Astro components/pages → server-rendered HTML
      ↓
Netlify (SSR function + CDN caching)
```

- **Rendering:** `output: 'server'` — every page is HTML generated on the server. No content requires client JS.
- **Client JS:** one small script (IntersectionObserver reveal, respects `prefers-reduced-motion`) + a native `<details>` mobile menu. No frameworks shipped.
- **Data caching:** 60-second in-memory TTL + one collection query per request cycle (uses the cache, never double-fetches within a render).

## 3. Firestore schema discovered (live, verified 2026-09-08)

Collection `projects` — 8 documents, every document has exactly:

| Field | Type | Notes |
|---|---|---|
| `title` | string | e.g. "Storyloom" |
| `description` | string | 1–3 sentence summary |
| `imageUrl` | string | absolute URL (GitHub raw / Cloudinary / CDN) |
| `githubUrl` | string | repo URL |

No `techStack`, `liveUrl`, `featured`, `order`, or slug fields exist in current data. The adapter (`src/lib/projects.ts`) supports all of these as **optional** fields — add them in Firestore any time and the site picks them up (ordering priority: `order` → `featured` → newest first). Slugs are derived from titles (`Storyloom` → `/projects/storyloom`).

Collection `messages` — `{ name, email, message, createdAt }` (unchanged workflow).

## 4. Firestore integration approach

- **REST, not SDK:** the server reads `firestore.googleapis.com/v1/...` with plain `fetch` — zero KB of Firebase code in the browser bundle.
- **Normalization:** unknown/missing fields are tolerated; documents can gain new fields without code changes.
- **Project routes:** SSR per request — a project added in Firestore is live at `/projects/<slug>` within seconds (cache TTL); deleted projects 404 correctly.
- **Sitemap:** `/sitemap.xml` is generated on demand from the same data source, so Firestore projects are always discoverable by search engines.

## 5. Environment variables

| Variable | Purpose | Example |
|---|---|---|
| `FIREBASE_API_KEY` | Public Firebase web API key | `AIzaSy...` |
| `FIREBASE_PROJECT_ID` | Firebase project ID | `arnab-portfolio-844d1` |
| `SITE_URL` | Canonical origin (canonical tags, OG, sitemap, robots) | `https://naimurrahmanportfolio.netlify.app` |

These are **public web config values, not secrets** — access control belongs in Firestore Security Rules. See `.env.example`.

## 6. Routes

| Route | Description |
|---|---|
| `/` | Editorial homepage: hero → ticker → work (6) → about → skills → contact |
| `/projects` | Complete project index |
| `/projects/[slug]` | Case-study page per project (SSR) |
| `/about` | Profile + certificates + capabilities |
| `/contact` | Direct channels + message form (posts to `/api/message`) |
| `/api/message` | POST endpoint → Firestore `messages` (validated, rate-limited) |
| `/sitemap.xml`, `/robots.txt` | SEO endpoints (dynamic sitemap includes all project URLs) |
| `404` | Editorial error page (also served for invalid slugs, correct status) |

## 7. SEO features

- Unique `<title>` + meta description per page (`Storyloom — Naimur Rahman Arnab`)
- Canonical URLs, Open Graph, Twitter/X cards (site-wide, absolute URLs)
- JSON-LD: `Person`, `WebSite`, `ItemList` (homepage), `CreativeWork` (project pages), `ContactPage`
- Dynamic `sitemap.xml` (includes every Firestore project), `robots.txt` with sitemap reference
- Semantic HTML landmarks, single `<h1>` per page, ordered heading hierarchy, descriptive alt text
- Domain configurable via `SITE_URL` — no hardcoded URLs in components

## 8. Design system

**Direction:** independent digital magazine / riso-print poster — deliberately opposite to the old navy-purple developer aesthetic.

- **Palette:** warm paper `#f6f2ea`, ink `#1c1a17`, vermilion `#e2492f`, ultramarine `#2238c8` + tint surfaces (tokens in `src/styles/global.css`, WCAG-checked pairings)
- **Typography:** Archivo (display, oversized/black/uppercase), Inter (body), Space Mono (metadata labels, numbers)
- **Geometric language:** circles, dot grids, triangles, rules, oversized project numbers, hard offset shadows — every shape tied to layout, hidden from screen readers (`aria-hidden`)
- **Project showcase:** three rotating editorial compositions (visual-led / offset / horizontal rule) instead of a card grid; works with any project count
- **Motion:** CSS-only reveals, one slow ticker, `prefers-reduced-motion` fully honored

## 9. Netlify deployment

1. Push this repo; Netlify auto-detects Astro from `netlify.toml` (site lives at the repo root).
2. Build command `npm run build`, publish `dist` — already configured.
3. Set environment variables: `FIREBASE_API_KEY`, `FIREBASE_PROJECT_ID`, `SITE_URL`.
4. Deploy. The Netlify adapter emits the SSR function automatically.

Local dev: `npm install && npm run dev` (or copy `.env.example` → `.env` first).

> **Note on local dev:** the Netlify adapter is only attached for production builds (`npm run build` / on Netlify). In `astro dev`, Astro's built-in SSR server renders the same pages with the same Firestore data — this avoids the adapter's edge-functions emulator, which requires Deno locally. Production behavior is unchanged.

## 10. Firestore security rules (review — no changes required to run)

The site only **reads** `projects` and **creates** `messages` with the public web identity. Suggested minimal rules:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /projects/{doc} {
      allow read: if true;
      allow write: if false; // manage via Firebase console / admin SDK
    }
    match /messages/{doc} {
      allow create: if true;  // consider validation, e.g. request.resource.data.keys().hasAll(['name','email','message'])
      allow read, update, delete: if false;
    }
  }
}
```

## 11. Assumptions made

- **Slug source:** no slug field exists in Firestore, so slugs are derived from `title` (stable unless a title is renamed; adding an explicit `slug` field overrides it).
- **Ordering:** no order field exists; newest-first (Firestore `createTime`) matches the old "recent projects" behavior. Optional `order`/`featured` fields are supported if added later.
- **Hero copy** was rewritten (spec §15); About text and certificates were kept nearly verbatim.
- **Firestore data on display:** empty optional fields never render (no empty buttons/galleries), per spec.
- **Contact form** preserves the Firestore workflow rather than introducing a mail service.

## 12. Remaining manual steps

- [ ] Add the env vars in Netlify and deploy
- [ ] Create `og-image.png` at 1200×630 (current one was inherited from the Flutter build)
- [ ] Review/apply the Firestore rules above in the Firebase console
- [ ] Optional: self-host the three Google Fonts in `public/fonts/` for full performance independence
- [x] Archive the old Flutter app (removed from the repo; recoverable from git history)
