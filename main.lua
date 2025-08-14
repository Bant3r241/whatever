local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

-- Game Info
local GAMENAME = MarketplaceService:GetProductInfo(game.PlaceId).Name
local PlayerCount = #Players:GetPlayers()

-- Extract JobId UUID
local function extractJobId(jobId)
    local uuid = jobId:match('"(.-)"')
    return uuid or jobId
end

local ConsoleJobIdRaw = 'Roblox.GameLauncher.joinGameInstance(' .. game.PlaceId .. ', "' .. game.JobId .. '")'
local ConsoleJobId = extractJobId(ConsoleJobIdRaw)

-- Helper: Convert "$3.5M/s" → 3500000
local function parseMoneyPerSec(text)
    local num, suffix = text:match("%$([%d%.]+)([KMBT])?/s")
    if not num then return nil end
    num = tonumber(num)
    if not num then return nil end
    local multipliers = {
        K = 1e3,
        M = 1e6,
        B = 1e9,
        T = 1e12
    }
    return num * (multipliers[suffix] or 1)
end

-- Search workspace for best brainrot
local function findBestBrainrot()
    local best = {
        name = "Unknown",
        raw = "N/A",
        value = 0
    }

    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA("TextLabel") then
            local text = descendant.Text
            if text:find("/s") then
                local value = parseMoneyPerSec(text)
                if value and value > best.value then
                    best.value = value
                    best.raw = text
                    best.name = descendant.Parent and descendant.Parent.Parent and descendant.Parent.Parent.Name or "Unknown"
                end
            end
        end
    end

    return best
end

local bestBrainrot = findBestBrainrot()

-- Create webhook
local function createWebhookData()
    local data = {
        ["avatar_url"] = "https://i.pinimg.com/564x/75/43/da/7543daab0a692385cca68245bf61e721.jpg",
        ["content"] = "",
        ["embeds"] = {
            {
                ["author"] = {
                    ["name"] = "Test Notifier",
                    ["url"] = "https://roblox.com",
                },
                ["description"] = string.format(
                    "__[Game Info](https://www.roblox.com/games/%d)__" ..
                    "\n**Game:** %s" ..
                    "\n\n**Server Player Count:** %d" ..
                    "\n\n**Best Brainrot:** %s" ..
                    "\n**Money per second:** %s" ..
                    "\n\n**JobId:**```%s```",
                    game.PlaceId, GAMENAME,
                    PlayerCount,
                    bestBrainrot.name,
                    bestBrainrot.raw,
                    ConsoleJobId
                ),
                ["type"] = "rich",
                ["color"] = tonumber("0xFFD700"),
            }
        }
    }
    return HttpService:JSONEncode(data)
end

-- Send webhook
local function sendWebhook(webhookUrl, data)
    local headers = {
        ["content-type"] = "application/json"
    }

    local request = http_request or request or HttpPost or syn.request
    local abcdef = {Url = webhookUrl, Body = data, Method = "POST", Headers = headers}
    request(abcdef)
end

-- Webhook URL
local webhookUrl = "https://discordapp.com/api/webhooks/1405045594904461422/ng0umCLFBiJN9y0BynUw7MXu1DBn_eBmvnGhulw3cRBzQ4KWn2q6_WhGhBzTj4xJK7eM"
local webhookData = createWebhookData()

-- Send
sendWebhook(webhookUrl, webhookData)
