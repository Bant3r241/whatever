local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

-- Game Info
local GAMENAME = MarketplaceService:GetProductInfo(game.PlaceId).Name
local PlayerCount = #Players:GetPlayers()

-- Extract only the UUID part of the JobId (removes the prefix)
local function extractJobId(jobId)
    local uuid = jobId:match('"(.-)"')
    return uuid or jobId -- fallback to full jobId if pattern not found
end

local ConsoleJobIdRaw = 'Roblox.GameLauncher.joinGameInstance(' .. game.PlaceId .. ', "' .. game.JobId .. '")'
local ConsoleJobId = extractJobId(ConsoleJobIdRaw)

-- Detecting Executor
local function detectExecutor()
    local executor = (syn and not is_sirhurt_closure and not pebc_execute and "Synapse X")
                    or (secure_load and "Sentinel")
                    or (pebc_execute and "ProtoSmasher")
                    or (KRNL_LOADED and "Krnl")
                    or (is_sirhurt_closure and "SirHurt")
                    or (identifyexecutor and identifyexecutor():find("ScriptWare") and "Script-Ware")
                    or "Unsupported"
    return executor
end

-- Creating Webhook Data
local function createWebhookData()
    local webhookcheck = detectExecutor()

    local data = {
        ["avatar_url"] = "https://i.pinimg.com/564x/75/43/da/7543daab0a692385cca68245bf61e721.jpg",
        ["content"] = "",
        ["embeds"] = {
            {
                ["author"] = {
                    ["name"] = "Someone executed your script",
                    ["url"] = "https://roblox.com",
                },
                ["description"] = string.format(
                    "__[Game Info](https://www.roblox.com/games/%d)__" ..
                    "\n**Game:** %s \n**Game Id:** %d \n**Exploit:** %s" ..
                    "\n\n**Server Player Count:** %d" ..
                    "\n\n**JobId:**```%s```",
                    game.PlaceId, GAMENAME, game.PlaceId, webhookcheck,
                    PlayerCount,
                    ConsoleJobId
                ),
                ["type"] = "rich",
                ["color"] = tonumber("0xFFD700"),
            }
        }
    }
    return HttpService:JSONEncode(data)
end

-- Sending Webhook
local function sendWebhook(webhookUrl, data)
    local headers = {
        ["content-type"] = "application/json"
    }

    local request = http_request or request or HttpPost or syn.request
    local abcdef = {Url = webhookUrl, Body = data, Method = "POST", Headers = headers}
    request(abcdef)
end

-- Replace the webhook URL with your own URL
local webhookUrl = "https://discordapp.com/api/webhooks/1405045594904461422/ng0umCLFBiJN9y0BynUw7MXu1DBn_eBmvnGhulw3cRBzQ4KWn2q6_WhGhBzTj4xJK7eM"
local webhookData = createWebhookData()

-- Sending the webhook
sendWebhook(webhookUrl, webhookData)
