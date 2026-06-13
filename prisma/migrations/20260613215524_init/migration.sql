-- CreateEnum
CREATE TYPE "PlatformName" AS ENUM ('ALL', 'MR_D', 'BOLT', 'UBER_EATS', 'UBER_PASSENGERS');

-- CreateEnum
CREATE TYPE "Priority" AS ENUM ('LOW', 'MEDIUM', 'HIGH');

-- CreateEnum
CREATE TYPE "TaskStatus" AS ENUM ('NOT_STARTED', 'IN_PROGRESS', 'COMPLETED', 'BLOCKED');

-- CreateEnum
CREATE TYPE "DocumentStatus" AS ENUM ('MISSING', 'IN_PROGRESS', 'READY', 'UPLOADED', 'REJECTED', 'EXPIRED');

-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('NOT_PAID', 'PARTLY_PAID', 'PAID');

-- CreateEnum
CREATE TYPE "OwnershipType" AS ENUM ('OWNED', 'FINANCED', 'RENTED', 'PLANNING_TO_BUY');

-- CreateEnum
CREATE TYPE "ApplicationType" AS ENUM ('FOOD_DELIVERY', 'GROCERY_DELIVERY', 'PACKAGE_DELIVERY', 'PASSENGER_TRANSPORT');

-- CreateEnum
CREATE TYPE "ApplicationStatus" AS ENUM ('NOT_STARTED', 'DOCUMENTS_GATHERING', 'SUBMITTED', 'UNDER_REVIEW', 'APPROVED', 'REJECTED', 'BLOCKED');

-- CreateEnum
CREATE TYPE "ShiftType" AS ENUM ('MORNING', 'LUNCH', 'AFTERNOON', 'DINNER', 'EVENING', 'WEEKEND');

-- CreateEnum
CREATE TYPE "ExpenseCategory" AS ENUM ('FUEL', 'DATA', 'AIRTIME', 'VEHICLE_MAINTENANCE', 'INSURANCE', 'PARKING', 'CLEANING', 'FOOD_DELIVERY_SUPPLIES', 'OTHER');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Platform" (
    "id" TEXT NOT NULL,
    "name" "PlatformName" NOT NULL,
    "displayName" TEXT NOT NULL,
    "applicationTypes" TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Platform_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PlatformRequirement" (
    "id" TEXT NOT NULL,
    "platformId" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "editable" BOOLEAN NOT NULL DEFAULT true,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PlatformRequirement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StartupChecklistItem" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "phase" TEXT NOT NULL,
    "platform" "PlatformName" NOT NULL DEFAULT 'ALL',
    "priority" "Priority" NOT NULL DEFAULT 'MEDIUM',
    "status" "TaskStatus" NOT NULL DEFAULT 'NOT_STARTED',
    "dueDate" TIMESTAMP(3),
    "notes" TEXT,
    "documentRequired" BOOLEAN NOT NULL DEFAULT false,
    "estimatedCost" DECIMAL(65,30) NOT NULL DEFAULT 0,
    "actualCost" DECIMAL(65,30) NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "StartupChecklistItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StartupCost" (
    "id" TEXT NOT NULL,
    "itemName" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "platform" "PlatformName" NOT NULL DEFAULT 'ALL',
    "estimatedCost" DECIMAL(65,30) NOT NULL DEFAULT 0,
    "actualCost" DECIMAL(65,30) NOT NULL DEFAULT 0,
    "paymentStatus" "PaymentStatus" NOT NULL DEFAULT 'NOT_PAID',
    "dueDate" TIMESTAMP(3),
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "StartupCost_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VehiclePlan" (
    "id" TEXT NOT NULL,
    "vehicleType" TEXT NOT NULL,
    "ownershipType" "OwnershipType" NOT NULL,
    "vehicleYear" INTEGER,
    "platformUse" "PlatformName" NOT NULL,
    "monthlyRepaymentOrRentalCost" DECIMAL(65,30) NOT NULL DEFAULT 0,
    "estimatedMonthlyFuelCost" DECIMAL(65,30) NOT NULL DEFAULT 0,
    "insuranceCost" DECIMAL(65,30) NOT NULL DEFAULT 0,
    "maintenanceEstimate" DECIMAL(65,30) NOT NULL DEFAULT 0,
    "licenceStatus" TEXT NOT NULL,
    "roadworthyStatus" TEXT NOT NULL,
    "inspectionStatus" TEXT NOT NULL,
    "operatingCardStatus" TEXT NOT NULL,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "VehiclePlan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RequiredDocument" (
    "id" TEXT NOT NULL,
    "documentName" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "platform" "PlatformName" NOT NULL DEFAULT 'ALL',
    "requiredFor" TEXT NOT NULL,
    "status" "DocumentStatus" NOT NULL DEFAULT 'MISSING',
    "expiryDate" TIMESTAMP(3),
    "uploadDate" TIMESTAMP(3),
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "RequiredDocument_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PlatformApplication" (
    "id" TEXT NOT NULL,
    "platform" "PlatformName" NOT NULL,
    "applicationType" "ApplicationType" NOT NULL,
    "applicationStatus" "ApplicationStatus" NOT NULL DEFAULT 'NOT_STARTED',
    "dateStarted" TIMESTAMP(3),
    "dateSubmitted" TIMESTAMP(3),
    "expectedResponseDate" TIMESTAMP(3),
    "blockerReason" TEXT,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PlatformApplication_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WeeklyIncome" (
    "id" TEXT NOT NULL,
    "platform" "PlatformName" NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "shiftType" "ShiftType" NOT NULL,
    "grossIncome" DECIMAL(65,30) NOT NULL,
    "tips" DECIMAL(65,30) NOT NULL DEFAULT 0,
    "tripsOrDeliveries" INTEGER NOT NULL,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "WeeklyIncome_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WeeklyExpense" (
    "id" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "category" "ExpenseCategory" NOT NULL,
    "amount" DECIMAL(65,30) NOT NULL,
    "platform" "PlatformName" NOT NULL DEFAULT 'ALL',
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "WeeklyExpense_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LearningGuideArticle" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "topic" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "order" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LearningGuideArticle_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Platform_name_key" ON "Platform"("name");

-- CreateIndex
CREATE UNIQUE INDEX "LearningGuideArticle_slug_key" ON "LearningGuideArticle"("slug");

-- AddForeignKey
ALTER TABLE "PlatformRequirement" ADD CONSTRAINT "PlatformRequirement_platformId_fkey" FOREIGN KEY ("platformId") REFERENCES "Platform"("id") ON DELETE CASCADE ON UPDATE CASCADE;
