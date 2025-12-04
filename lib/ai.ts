// Free AI API integration
// Using resources from: https://github.com/cheahjs/free-llm-api-resources
// Supports OpenAI-compatible APIs and Google AI Studio (Gemini)

const AI_API_KEY = process.env.AI_API_KEY!
const AI_API_URL = process.env.AI_API_URL || 'https://api.openai.com/v1/chat/completions'
const AI_MODEL = process.env.AI_MODEL || 'gpt-3.5-turbo'

// Check if using Google AI Studio (Gemini API)
const isGoogleAI = AI_API_URL.includes('generativelanguage.googleapis.com') || 
                   AI_API_URL.includes('googleapis.com')

export interface AIGenerationRequest {
  keyword: string
  sectionTemplate?: string
  customizations?: string
}

export async function generateSectionCode(request: AIGenerationRequest): Promise<string> {
  const { keyword, sectionTemplate, customizations } = request

  const systemPrompt = `You are an expert Shopify theme developer. Generate clean, production-ready Shopify Liquid section code based on user requirements.

Requirements:
- Use modern Shopify section schema format
- Include proper settings schema for theme editor
- Use semantic HTML
- Include proper accessibility attributes
- Follow Shopify best practices
- Return ONLY the Liquid code, no markdown formatting or explanations`

  const userPrompt = sectionTemplate
    ? `Generate a Shopify section based on this template and keyword "${keyword}". ${customizations ? `Customizations: ${customizations}` : ''}

Template:
${sectionTemplate}

Generate the final Liquid code:`
    : `Generate a Shopify section for: "${keyword}". ${customizations ? `Customizations: ${customizations}` : ''}

Generate the Liquid code:`

  try {
    let response: Response
    let data: any

    if (isGoogleAI) {
      // Google AI Studio (Gemini) API format
      const fullPrompt = `${systemPrompt}\n\n${userPrompt}`
      const apiUrl = AI_API_URL.includes(':generateContent') 
        ? AI_API_URL 
        : `https://generativelanguage.googleapis.com/v1beta/models/${AI_MODEL}:generateContent`

      response = await fetch(`${apiUrl}?key=${AI_API_KEY}`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          contents: [
            {
              parts: [
                {
                  text: fullPrompt,
                },
              ],
            },
          ],
          generationConfig: {
            temperature: 0.7,
            maxOutputTokens: 2000,
          },
        }),
      })

      if (!response.ok) {
        const error = await response.json()
        throw new Error(error.error?.message || 'Failed to generate section code')
      }

      data = await response.json()
      const generatedCode = data.candidates?.[0]?.content?.parts?.[0]?.text || ''
      return generatedCode.replace(/```liquid\n?/g, '').replace(/```\n?/g, '').trim()
    } else {
      // OpenAI-compatible API format (OpenAI, Groq, OpenRouter, etc.)
      response = await fetch(AI_API_URL, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${AI_API_KEY}`,
        },
        body: JSON.stringify({
          model: AI_MODEL,
          messages: [
            { role: 'system', content: systemPrompt },
            { role: 'user', content: userPrompt },
          ],
          temperature: 0.7,
          max_tokens: 2000,
        }),
      })

      if (!response.ok) {
        const error = await response.json()
        throw new Error(error.error?.message || 'Failed to generate section code')
      }

      data = await response.json()
      const generatedCode = data.choices[0]?.message?.content || ''
      return generatedCode.replace(/```liquid\n?/g, '').replace(/```\n?/g, '').trim()
    }
  } catch (error) {
    console.error('AI Generation Error:', error)
    throw error
  }
}

