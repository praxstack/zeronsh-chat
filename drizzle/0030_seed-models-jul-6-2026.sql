-- Custom SQL migration file, put your code below! --

-- Latest models on the Vercel AI Gateway (per models.dev) that postdate our
-- current frontier for each provider we support and were missing on prod:
--   anthropic/claude-sonnet-5   (new Sonnet flagship, succeeds claude-sonnet-4.6)
--   alibaba/qwen3.7-plus        (cost-effective Qwen 3.7 tier below qwen3.7-max)
--   mistral/mistral-medium-3.5  (first new Mistral since mistral-large-3)
-- Capabilities follow models.dev modalities (image=vision, pdf=documents) plus
-- tool_call=tools and reasoning. Prices are micro-dollars per million tokens
-- (gateway $/token * 1e12).
INSERT INTO "model" (
    "id",
    "name",
    "model",
    "description",
    "capabilities",
    "icon",
    "access",
    "credits",
    "input_cost",
    "output_cost",
    "created_at",
    "updated_at"
)
VALUES
(
    'claude-5-sonnet', -- id
    'Claude Sonnet 5', -- name
    'anthropic/claude-sonnet-5', -- model
    'Anthropic''s newest Sonnet, upgrading Sonnet 4.6 with stronger agentic coding and reasoning at Sonnet pricing', -- description
    '["tools", "reasoning", "vision", "documents"]', -- capabilities
    'anthropic', -- icon
    'premium_required', -- access
    5, -- credits
    2000000, -- input_cost
    10000000, -- output_cost
    NOW(), -- created_at
    NOW() -- updated_at
),
(
    'qwen3.7-plus', -- id
    'Qwen 3.7 Plus', -- name
    'alibaba/qwen3.7-plus', -- model
    'Alibaba''s cost-effective Qwen 3.7 model with upgraded vision-language ability plus agentic coding, tool use, and productivity skills', -- description
    '["tools", "reasoning", "vision", "documents"]', -- capabilities
    'qwen', -- icon
    'account_required', -- access
    1, -- credits
    400000, -- input_cost
    1600000, -- output_cost
    NOW(), -- created_at
    NOW() -- updated_at
),
(
    'mistral-medium-3.5', -- id
    'Mistral Medium 3.5', -- name
    'mistral/mistral-medium-3.5', -- model
    'Mistral''s frontier-class multimodal model optimized for agentic and coding use cases', -- description
    '["tools", "reasoning", "vision"]', -- capabilities
    'mistral', -- icon
    'account_required', -- access
    2, -- credits
    1500000, -- input_cost
    7500000, -- output_cost
    NOW(), -- created_at
    NOW() -- updated_at
)
ON CONFLICT ("id") DO NOTHING;