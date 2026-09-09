/**
 * Firebase configuration resolution.
 *
 * These are PUBLIC web client configuration values (identifying, not secret —
 * the same values ship in any Firebase web app). Real access control lives in
 * Firestore Security Rules. No Admin SDK credentials are ever used here.
 */
export interface FirebaseConfig {
  apiKey: string;
  projectId: string;
}

export function getFirebaseConfig(): FirebaseConfig {
  const apiKey = import.meta.env.FIREBASE_API_KEY ?? 'AIzaSyC8Fyb9WRrlTwtLxTcS4cbiuXL01kYP4cM';
  const projectId = import.meta.env.FIREBASE_PROJECT_ID ?? 'arnab-portfolio-844d1';

  if (!apiKey || !projectId) {
    throw new Error(
      'Missing Firebase configuration. Set FIREBASE_API_KEY and FIREBASE_PROJECT_ID environment variables.',
    );
  }

  return { apiKey, projectId };
}
