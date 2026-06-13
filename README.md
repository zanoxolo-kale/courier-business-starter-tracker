# courier-business-starter-tracker

A GitHub-ready full-stack portfolio project for South African courier, food delivery, grocery delivery, package delivery, and ride-hailing startup readiness tracking.

## Stack

- Next.js App Router, React, TypeScript, Tailwind CSS
- PostgreSQL with Prisma ORM
- React Hook Form and Zod validation

## Features

- Dashboard with readiness cards, cost totals, missing documents, upcoming tax reminders, and progress bars.
- Editable platform requirement data for Mr D, Bolt, Uber Eats, and Uber passengers.
- Step-by-step startup checklist across business registration, permits, vehicles, platforms, tax records, equipment, and multi-app strategy.
- Document, startup cost, vehicle, platform application, weekly income, and expense trackers.
- Beginner-friendly South African learning guide.
- Search and filtering screens.
- Prisma schema and realistic seed data.

## Important disclaimer

This tracker is educational planning support only. It is not legal, tax, transport, municipal, insurance, or platform advice. Platform requirements, SARS rules, municipal rules, vehicle requirements, operating licence rules, and permit requirements can change. Always verify directly with SARS, the relevant municipality or traffic department, and each platform before applying or spending money.

## Getting started

```bash
cp .env.example .env
npm install
npm run prisma:generate
npm run prisma:migrate
npm run db:seed
npm run dev
```

Open http://localhost:3000.

## Database models

User, Platform, PlatformRequirement, StartupChecklistItem, StartupCost, VehiclePlan, RequiredDocument, PlatformApplication, WeeklyIncome, WeeklyExpense, and LearningGuideArticle.

## Portfolio notes

The UI intentionally includes responsive navigation, cards, tables, forms, badges, progress bars, empty-state friendly sections, clear disclaimers, and typed validation examples.
