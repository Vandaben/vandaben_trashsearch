ESX = exports['es_extended']:getSharedObject()

Config = Config or {}
if not Config.Rewards then dofile('config.lua') end

-- Webhook URL (udskift med din egen)
local webhookURL = "DIT_WEBHOOK_URL"

local function sendToDiscord(name, message, color)
    local embed = {
        {
            ['title'] = name,
            ['description'] = message,
            ['color'] = color,
        }
    }
    PerformHttpRequest(webhookURL, function(err, text, headers) end, 'POST', json.encode({username = "Trash Log", embeds = embed}), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent('vandaben_reward')
AddEventHandler('vandaben_reward', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        local reward = Config.Rewards[math.random(#Config.Rewards)]
        xPlayer.addInventoryItem(reward.item, reward.amount)
        TriggerClientEvent('esx:showNotification', src, "Du fandt " .. reward.amount .. "x " .. reward.item)
        
        local steamName = GetPlayerName(src)
        local discordIdentifier
        for _, id in ipairs(GetPlayerIdentifiers(src)) do
            if string.find(id, "discord:") then
                discordIdentifier = "<@" .. string.sub(id, 9) .. ">"
                break
            end
        end
            
        local logMessage = string.format("**Spiller:** %s (%s)\n**Fandt:** %dx %s", steamName, discordIdentifier or "Ingen Discord", reward.amount, reward.item)
        sendToDiscord("Vandaben - Trash Search Logs", logMessage, 0x0072FF) -- Blå farve (Kan ændres)
    end
end)
