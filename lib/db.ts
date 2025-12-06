import { PrismaClient } from '@prisma/client'

const globalForPrisma = globalThis as unknown as {
  prisma: PrismaClient | undefined
}

// Create Prisma client with connection error handling
const createPrismaClient = () => {
  if (!process.env.DATABASE_URL) {
    console.error('❌ DATABASE_URL is not set!')
    throw new Error('DATABASE_URL environment variable is required')
  }

  // Check if this is a Supabase connection
  const isSupabase = process.env.DATABASE_URL.includes('supabase.co')
  
  if (isSupabase && !process.env.DATABASE_URL.includes('sslmode')) {
    console.warn('⚠️ Supabase connection detected but SSL mode not specified.')
    console.warn('   Add ?sslmode=require to your DATABASE_URL for better security.')
  }

  return new PrismaClient({
    log: process.env.NODE_ENV === 'development' ? ['query', 'error', 'warn'] : ['error'],
  })
}

export const prisma = globalForPrisma.prisma ?? createPrismaClient()

if (process.env.NODE_ENV !== 'production') globalForPrisma.prisma = prisma

// Handle connection errors gracefully
prisma.$connect().catch((error) => {
  console.error('❌ Failed to connect to database:', error.message)
  if (process.env.NODE_ENV === 'production') {
    console.error('Please check your DATABASE_URL environment variable')
  }
})

