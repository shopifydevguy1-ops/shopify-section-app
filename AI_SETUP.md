# AI API Setup Guide

This guide will help you set up a free AI API for the Shopify Section Generator.

## 🚀 Recommended: Groq (Fast & Free)

**Why Groq?**
- ⚡ Extremely fast inference (up to 10x faster than others)
- 🆓 Free tier with generous limits
- 🔧 OpenAI-compatible API (easy integration)
- 💻 Great for code generation

### Step 1: Sign Up for Groq

1. Visit [https://console.groq.com](https://console.groq.com)
2. Click **"Sign Up"** or **"Get Started"**
3. Sign up with your email or GitHub account
4. Verify your email if required

### Step 2: Get Your API Key

1. Once logged in, go to **API Keys** section
2. Click **"Create API Key"**
3. Give it a name (e.g., "Shopify Section Generator")
4. Copy the API key (starts with `gsk_...`)
5. ⚠️ **Save it securely** - you won't be able to see it again!

### Step 3: Configure Your App

1. Open your `.env` file
2. Update these values:

```env
AI_API_KEY=gsk_your_groq_api_key_here
AI_API_URL=https://api.groq.com/openai/v1/chat/completions
AI_MODEL=llama-3.1-70b-versatile
```

**Available Groq Models:**
- `llama-3.1-70b-versatile` (Recommended - Best balance)
- `llama-3.1-8b-instant` (Faster, smaller)
- `mixtral-8x7b-32768` (Good for longer context)
- `gemma-7b-it` (Fast and efficient)

### Step 4: Test the Configuration

1. Restart your development server:
   ```bash
   npm run dev
   ```
2. Go to `/dashboard/generate`
3. Try generating a section with keyword "hero banner"
4. If it works, you're all set! 🎉

---

## 🔄 Alternative: OpenRouter (Many Models)

**Why OpenRouter?**
- 🎯 Access to 100+ models
- 🆓 50 free requests/day (1,000 with $10 top-up)
- 🔄 Easy model switching

### Setup Steps:

1. Visit [https://openrouter.ai](https://openrouter.ai)
2. Sign up with GitHub or email
3. Go to **Keys** section
4. Create a new key
5. Update `.env`:

```env
AI_API_KEY=sk-or-v1-your_openrouter_key_here
AI_API_URL=https://openrouter.ai/api/v1/chat/completions
AI_MODEL=openai/gpt-3.5-turbo
```

**Popular OpenRouter Models:**
- `openai/gpt-3.5-turbo` (Free tier)
- `meta-llama/llama-3.1-70b-instruct` (Free tier)
- `google/gemini-pro-1.5` (Free tier)

---

## 🌟 Alternative: Google AI Studio

**Why Google AI Studio?**
- 🆓 3,000,000 tokens/day free
- 🚀 Powerful Gemini models
- 📊 Good for complex tasks

### Setup Steps:

1. Visit [https://aistudio.google.com](https://aistudio.google.com)
2. Sign in with Google account
3. Click **"Get API Key"**
4. Create a new key
5. Update `.env`:

```env
AI_API_KEY=your_google_api_key_here
AI_API_URL=https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:generateContent
AI_MODEL=gemini-2.0-flash-exp
```

**Note:** Google AI Studio uses a different API format. You may need to update `lib/ai.ts` for full compatibility.

---

## 🔍 Other Free Options

From [free-llm-api-resources](https://github.com/cheahjs/free-llm-api-resources):

1. **HuggingFace Inference** - Free tier available
2. **Cloudflare Workers AI** - 10,000 neurons/day
3. **Mistral La Plateforme** - Free tier
4. **NVIDIA NIM** - Free tier

---

## ⚙️ Configuration Reference

Your `.env` file should have:

```env
# AI API Configuration
AI_API_KEY=your_api_key_here
AI_API_URL=https://api.groq.com/openai/v1/chat/completions
AI_MODEL=llama-3.1-70b-versatile
```

## 🐛 Troubleshooting

### "Invalid API Key" Error
- Double-check your API key is correct
- Make sure there are no extra spaces
- Verify the key hasn't expired

### "Rate Limit Exceeded" Error
- You've hit the free tier limit
- Wait for the limit to reset (usually daily)
- Consider upgrading or switching providers

### "Model Not Found" Error
- Check the model name is correct
- Verify the model is available in your region
- Try a different model from the list

### API Not Responding
- Check your internet connection
- Verify the API URL is correct
- Check the provider's status page

## 📚 Resources

- [Free LLM API Resources](https://github.com/cheahjs/free-llm-api-resources)
- [Groq Documentation](https://console.groq.com/docs)
- [OpenRouter Documentation](https://openrouter.ai/docs)
- [Google AI Studio](https://aistudio.google.com)

## 🔒 Security Reminder

- ⚠️ Never commit your `.env` file to git
- ⚠️ Never share your API keys publicly
- ⚠️ Rotate keys if they're exposed
- ✅ Use environment variables for all secrets

