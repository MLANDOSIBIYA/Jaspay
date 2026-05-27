-- CreateEnum
CREATE TYPE "KycStatus" AS ENUM ('LITE', 'FULL', 'PENDING', 'REJECTED');

-- CreateEnum
CREATE TYPE "AccountStatus" AS ENUM ('ACTIVE', 'SUSPENDED', 'BANNED');

-- CreateTable
CREATE TABLE "Seller" (
    "id" TEXT NOT NULL,
    "tradingName" TEXT NOT NULL,
    "legalName" TEXT NOT NULL,
    "mobileNumber" TEXT NOT NULL,
    "idLastFour" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL,
    "kycStatus" "KycStatus" NOT NULL DEFAULT 'LITE',
    "accountStatus" "AccountStatus" NOT NULL DEFAULT 'ACTIVE',
    "referralCode" TEXT NOT NULL,
    "transactionFeePct" DECIMAL(65,30) NOT NULL DEFAULT 0.0250,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Seller_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Wallet" (
    "id" TEXT NOT NULL,
    "sellerId" TEXT NOT NULL,
    "balance" DECIMAL(65,30) NOT NULL DEFAULT 0.00,
    "totalEarned" DECIMAL(65,30) NOT NULL DEFAULT 0.00,
    "totalFeesPaid" DECIMAL(65,30) NOT NULL DEFAULT 0.00,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Wallet_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Seller_mobileNumber_key" ON "Seller"("mobileNumber");

-- CreateIndex
CREATE UNIQUE INDEX "Seller_referralCode_key" ON "Seller"("referralCode");

-- CreateIndex
CREATE UNIQUE INDEX "Wallet_sellerId_key" ON "Wallet"("sellerId");

-- AddForeignKey
ALTER TABLE "Wallet" ADD CONSTRAINT "Wallet_sellerId_fkey" FOREIGN KEY ("sellerId") REFERENCES "Seller"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
