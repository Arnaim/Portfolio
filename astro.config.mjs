import { defineConfig } from 'astro/config';
import netlify from '@astrojs/netlify';
import tailwindcss from '@tailwindcss/vite';

// Site URL: overridable via env so a custom domain never requires code edits.
const SITE =
  process.env.SITE_URL?.replace(/\/+$/, '') ||
  'https://naimurrahmanportfolio.netlify.app';

// Attach the Netlify adapter for production builds only.
// In `astro dev` the adapter's edge-functions emulator requires Deno and
// crashes with an unhandled rejection when it's missing. This site uses no
// edge middleware, so dev runs on Astro's built-in SSR server instead —
// same pages, same Firestore data, no Deno requirement.
// (Netlify sets NETLIFY=true in its build environment; `astro build` passes
// "build" as the CLI command.)
const isProductionBuild =
  process.argv[2] === 'build' || process.env.NETLIFY === 'true';

export default defineConfig({
  site: SITE,
  output: 'server', // SSR: Firestore content fetched on the server
  adapter: isProductionBuild ? netlify() : undefined,
  vite: {
    plugins: [tailwindcss()],
  },
});
