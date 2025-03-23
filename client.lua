CreateThread(function()
    for _, prop in ipairs(Config.TrashProps) do
        exports.ox_target:addModel(prop, {
            label = "Søg i skraldespand",
            icon = "fa-solid fa-trash",
            onSelect = function(entity)
                TriggerEvent('vandaben_search', entity)
            end
        })
    end
end)

RegisterNetEvent('vandaben_search')
AddEventHandler('vandaben_search', function(entity)
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)

    exports.ox_lib:progressBar({
        duration = 5000,
        label = "Søger i skraldespand...",
        useWhileDead = false,
        canCancel = false,
        disable = { move = true, car = true, combat = true },
    })

    ClearPedTasks(playerPed)
    TriggerServerEvent('vandaben_reward')
end)