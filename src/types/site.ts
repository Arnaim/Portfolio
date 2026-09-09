/** Static identity content migrated verbatim from the Flutter portfolio. */
export const SITE = {
  name: 'Naimur Rahman Arnab',
  nameParts: ['Naimur', 'Rahman', 'Arnab'],
  role: 'Software Developer',
  roleLong: 'Software Developer · Flutter · AI · Web',
  email: 'cookynaimur@gmail.com',
  github: 'https://github.com/Arnaim',
  githubHandle: '@Arnaim',
  linkedin: 'https://www.linkedin.com/in/naimurrahmanarnab',
  cvPath: '/Naimur_Rahman_Arnab_CV.pdf',
  domain: 'naimurrahmanportfolio.netlify.app',
  description:
    'I build Flutter apps end to end, from the data model to the interface, with AI experiments and web work on the side.',
} as const;

export const ABOUT = {
  heading: 'A developer who ships',
  paragraphs: [
    "I'm a Computer Science graduate and I build apps with Flutter. I care about clean architecture, mostly because I've had to maintain the messy kind.",
    'Day to day that means REST API integration, state management and UI work. I learn best by shipping: most of what I know came from building small projects and fixing them when they break.',
    "Right now I'm working on my thesis in machine learning. My CV has the full rundown of projects, skills and experience.",
  ],
  certs: [
    { title: 'Supervised Machine Learning: Regression & Classification', issuer: 'Coursera' },
    { title: 'Advanced Learning Algorithms', issuer: 'Coursera' },
    { title: 'App Development with Flutter', issuer: 'Ostad' },
    { title: 'ICPC Asia Dhaka Regional Contest (Contestant)', issuer: '2021' },
    { title: 'ICPC Asia Dhaka Regional Contest (Contestant)', issuer: '2023' },
    { title: 'NASA Space Apps Challenge (Participant)', issuer: '2024' },
  ],
} as const;

/** Skills migrated from the Flutter SkillsSection — grouped the same way. */
export const SKILLS: { group: string; items: string[] }[] = [
  {
    group: 'Development',
    items: [
      'Cross-Platform Mobile Apps',
      'API Integration',
      'Firebase',
      'Basic AI Model Training',
      'Digital Marketing & SEO',
    ],
  },
  {
    group: 'Languages',
    items: ['Dart', 'Python', 'Java', 'C++', 'HTML', 'CSS'],
  },
  {
    group: 'Frameworks & Tools',
    items: ['Flutter', 'Firebase', 'REST APIs', 'Google Workspace Administration'],
  },
];

/** Homepage hero lines — editorial composition (replaces the Flutter hero copy). */
export const HERO = {
  lineTop: 'Software',
  lineMid: '× Flutter × AI × Web',
  lineBottom: 'Builds things that run.',
  intro:
    'I build cross-platform apps with Flutter, hook them up to real backends, and give some of them on-device AI.',
  index: 'NRA·01',
} as const;
