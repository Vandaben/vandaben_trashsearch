ESX = exports['es_extended']:getSharedObject()

Config = Config or {}
if not Config.Rewards then dofile('config.lua') end

RegisterNetEvent('vandaben_reward')
AddEventHandler('vandaben_reward', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        local reward = Config.Rewards[math.random(#Config.Rewards)]
        xPlayer.addInventoryItem(reward.item, reward.amount)
        TriggerClientEvent('esx:showNotification', src, "Du fandt " .. reward.amount .. "x " .. reward.item)
        local data = {
            ['Player'] = GetPlayerName(src),
            ['Log'] = 'trash_search',
            ['Title'] = 'Trash Search Reward',
            ['Message'] = 'Player ' .. GetPlayerName(src) .. ' found ' .. reward.amount .. 'x ' .. reward.item,
        }
        TriggerEvent('Boost-Logs:SendLog', data)
    end
end)
