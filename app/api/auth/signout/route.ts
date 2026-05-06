import { cookies } from 'next/headers';

export async function POST() {
  const cookieStore = await cookies();
  const allCookies = cookieStore.getAll();

  // Clear any auth cookies (supabase uses 'sb-[project-id]-auth-token' pattern typically)
  for (const cookie of allCookies) {
    if (cookie.name.startsWith('sb-') && cookie.name.endsWith('-auth-token')) {
      cookieStore.delete(cookie.name);
    }
  }

  return new Response('Signed Out', { status: 200 });
}
