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
    'Naimur Rahman Arnab is a software developer working across Flutter, AI-assisted tools and web — building apps end-to-end, from data model to interface.',
} as const;

export const ABOUT = {
  heading: 'A developer who ships',
  paragraphs: [
    'I am a Computer Science graduate focused on Flutter-based application development. I build responsive, user-centric applications with attention to clean architecture and maintainable code.',
    'My work includes integrating REST APIs, managing application state, and designing intuitive user interfaces. I enjoy solving practical problems through technology and continuously improving my skills through hands-on projects.',
    'Currently conducting thesis research in machine learning, expanding my understanding of intelligent systems and data-driven solutions. My CV has the full detail — projects, skills, and experience.',
  ],
  certs: [
    { title: 'Supervised Machine Learning: Regression & Classification', issuer: 'Coursera' },
    { title: 'Advanced Learning Algorithms', issuer: 'Coursera' },
    { title: 'App Development with Flutter', issuer: 'Ostad' },
    { title: 'ICPC Asia Dhaka Regional Contest — Contestant', issuer: '2021' },
    { title: 'ICPC Asia Dhaka Regional Contest — Contestant', issuer: '2023' },
    { title: 'NASA Space Apps Challenge — Participant', issuer: '2024' },
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
    'Computer Science graduate building cross-platform apps with Flutter, wiring them to real backends, and teaching them to think with on-device AI.',
  index: 'NRA·01',
} as const;
