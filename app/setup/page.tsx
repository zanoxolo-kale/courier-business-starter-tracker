import { redirect } from 'next/navigation';
import { prisma } from '@/lib/prisma';

const platformOptions = [
  { value: 'Mr D', label: 'Mr D' },
  { value: 'Bolt', label: 'Bolt' },
  { value: 'Uber Eats', label: 'Uber Eats' },
  { value: 'Uber passengers', label: 'Uber passengers' },
];

async function saveSetup(formData: FormData) {
  'use server';

  const fullName = String(formData.get('fullName') ?? '').trim();
  const email = String(formData.get('email') ?? '').trim();
  const city = String(formData.get('city') ?? '').trim();
  const province = String(formData.get('province') ?? '').trim();
  const businessName = String(formData.get('businessName') ?? '').trim();
  const mainVehicleType = String(formData.get('mainVehicleType') ?? '').trim();
  const hasValidSaDriversLicence = formData.get('hasValidSaDriversLicence') === 'yes';
  const hasPrdpPdp = formData.get('hasPrdpPdp') === 'yes';
  const selectedPlatforms = formData.getAll('selectedPlatforms').map(String);

  if (!fullName || !email || !city || !province || !businessName || !mainVehicleType) {
    throw new Error('Please complete all required setup fields.');
  }

  const existingProfile = await prisma.businessProfile.findFirst({
    orderBy: { createdAt: 'desc' },
  });

  const data = {
    fullName,
    email,
    city,
    province,
    businessName,
    mainVehicleType,
    hasValidSaDriversLicence,
    hasPrdpPdp,
    selectedPlatforms,
  };

  if (existingProfile) {
    await prisma.businessProfile.update({
      where: { id: existingProfile.id },
      data,
    });
  } else {
    await prisma.businessProfile.create({ data });
  }

  redirect('/');
}

export default async function SetupPage() {
  const profile = await prisma.businessProfile.findFirst({
    orderBy: { createdAt: 'desc' },
  });

  const selected = profile?.selectedPlatforms ?? [];

  return (
    <section className="mx-auto max-w-4xl space-y-6">
      <div>
        <p className="text-sm font-semibold uppercase tracking-wide text-brand-700">First-time setup</p>
        <h1 className="mt-2 text-3xl font-bold tracking-tight text-slate-950">Set up your courier business profile</h1>
        <p className="mt-2 text-slate-600">
          Capture your real startup details so the tracker can move away from demo data and focus on your own readiness.
        </p>
      </div>

      <form action={saveSetup} className="space-y-6 rounded-3xl border border-slate-200 bg-white p-6 shadow-sm">
        <div className="grid gap-4 md:grid-cols-2">
          <label className="space-y-2">
            <span className="text-sm font-medium text-slate-700">Full name</span>
            <input name="fullName" required defaultValue={profile?.fullName ?? ''} className="w-full rounded-xl border border-slate-300 px-4 py-3 outline-none focus:border-brand-700" />
          </label>

          <label className="space-y-2">
            <span className="text-sm font-medium text-slate-700">Email</span>
            <input name="email" type="email" required defaultValue={profile?.email ?? ''} className="w-full rounded-xl border border-slate-300 px-4 py-3 outline-none focus:border-brand-700" />
          </label>

          <label className="space-y-2">
            <span className="text-sm font-medium text-slate-700">City</span>
            <input name="city" required defaultValue={profile?.city ?? ''} placeholder="Cape Town, Gqeberha, Johannesburg..." className="w-full rounded-xl border border-slate-300 px-4 py-3 outline-none focus:border-brand-700" />
          </label>

          <label className="space-y-2">
            <span className="text-sm font-medium text-slate-700">Province</span>
            <input name="province" required defaultValue={profile?.province ?? ''} placeholder="Western Cape, Eastern Cape..." className="w-full rounded-xl border border-slate-300 px-4 py-3 outline-none focus:border-brand-700" />
          </label>

          <label className="space-y-2">
            <span className="text-sm font-medium text-slate-700">Business or trading name</span>
            <input name="businessName" required defaultValue={profile?.businessName ?? ''} className="w-full rounded-xl border border-slate-300 px-4 py-3 outline-none focus:border-brand-700" />
          </label>

          <label className="space-y-2">
            <span className="text-sm font-medium text-slate-700">Main vehicle type</span>
            <input name="mainVehicleType" required defaultValue={profile?.mainVehicleType ?? ''} placeholder="Motorbike, hatchback, sedan, bakkie..." className="w-full rounded-xl border border-slate-300 px-4 py-3 outline-none focus:border-brand-700" />
          </label>
        </div>

        <div className="grid gap-4 md:grid-cols-2">
          <fieldset className="rounded-2xl border border-slate-200 p-4">
            <legend className="px-1 text-sm font-semibold text-slate-800">Valid SA driver licence?</legend>
            <div className="mt-3 flex gap-4">
              <label className="flex items-center gap-2 text-sm text-slate-700"><input type="radio" name="hasValidSaDriversLicence" value="yes" defaultChecked={profile?.hasValidSaDriversLicence === true} /> Yes</label>
              <label className="flex items-center gap-2 text-sm text-slate-700"><input type="radio" name="hasValidSaDriversLicence" value="no" defaultChecked={!profile?.hasValidSaDriversLicence} /> No</label>
            </div>
          </fieldset>

          <fieldset className="rounded-2xl border border-slate-200 p-4">
            <legend className="px-1 text-sm font-semibold text-slate-800">PrDP / PDP?</legend>
            <div className="mt-3 flex gap-4">
              <label className="flex items-center gap-2 text-sm text-slate-700"><input type="radio" name="hasPrdpPdp" value="yes" defaultChecked={profile?.hasPrdpPdp === true} /> Yes</label>
              <label className="flex items-center gap-2 text-sm text-slate-700"><input type="radio" name="hasPrdpPdp" value="no" defaultChecked={!profile?.hasPrdpPdp} /> No</label>
            </div>
          </fieldset>
        </div>

        <fieldset className="rounded-2xl border border-slate-200 p-4">
          <legend className="px-1 text-sm font-semibold text-slate-800">Platforms you want to apply for</legend>
          <div className="mt-3 grid gap-3 sm:grid-cols-2">
            {platformOptions.map((platform) => (
              <label key={platform.value} className="flex items-center gap-3 rounded-xl border border-slate-200 p-3 text-sm text-slate-700">
                <input type="checkbox" name="selectedPlatforms" value={platform.value} defaultChecked={selected.includes(platform.value)} />
                {platform.label}
              </label>
            ))}
          </div>
        </fieldset>

        <div className="rounded-2xl bg-amber-50 p-4 text-sm text-amber-900">
          This app is for planning and tracking only. Always verify the latest rules directly with SARS, your municipality, traffic department, insurer, Mr D, Bolt, and Uber.
        </div>

        <button type="submit" className="rounded-xl bg-brand-700 px-5 py-3 font-semibold text-white shadow-sm hover:bg-brand-800">
          Save setup and go to dashboard
        </button>
      </form>
    </section>
  );
}
