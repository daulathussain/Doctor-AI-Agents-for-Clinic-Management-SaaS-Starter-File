export async function GET(
  request: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  const { id } = await params;
  if (!id) {
    return new Response('Bad Request', { status: 400 });
  }

  // Simulate a lookup
  const appointment = { id, status: 'booked', appointment_date: '2026-01-01' };

  if (appointment) {
    return new Response(JSON.stringify(appointment), {
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    });
  }

  return new Response('Not Found', { status: 404 });
}
