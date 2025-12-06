import { clerkMiddleware, createRouteMatcher } from "@clerk/nextjs/server"
import { NextResponse } from "next/server"

// Validate Clerk keys are configured
if (!process.env.NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY || 
    process.env.NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY.includes('...') ||
    !process.env.CLERK_SECRET_KEY ||
    process.env.CLERK_SECRET_KEY.includes('...')) {
  console.error('❌ Clerk keys are missing or contain placeholder values!')
  console.error('Please update your .env file with valid Clerk keys from https://dashboard.clerk.com')
}

const isPublicRoute = createRouteMatcher([
  "/",
  "/pricing",
  "/sign-in(.*)",
  "/sign-up(.*)",
  "/api/webhooks(.*)",
])

export default clerkMiddleware(async (auth, req) => {
  // Only protect non-public routes
  if (!isPublicRoute(req)) {
    const { userId } = await auth()
    if (!userId) {
      const signInUrl = new URL("/sign-in", req.url)
      return NextResponse.redirect(signInUrl)
    }
  }
  
  return NextResponse.next()
})

export const config = {
  matcher: [
    // Skip Next.js internals and all static files, unless found in search params
    "/((?!_next|[^?]*\\.(?:html?|css|js(?!on)|jpe?g|webp|png|gif|svg|ttf|woff2?|ico|csv|docx?|xlsx?|zip|webmanifest)).*)",
    // Always run for API routes
    "/(api|trpc)(.*)",
  ],
}

