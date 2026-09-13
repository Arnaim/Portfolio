/** Site-wide configuration resolved at request time. */
import { SITE } from '../types/site';

const rawSite = import.meta.env.SITE_URL ?? 'https://naimurrahmanportfolio.netlify.app';

export const SITE_URL = rawSite.replace(/\/+$/, '');

export function absoluteUrl(path = '/'): string {
  return `${SITE_URL}${path.startsWith('/') ? path : `/${path}`}`;
}

export const SITE_TITLE = `${SITE.name} — ${SITE.role}`;
