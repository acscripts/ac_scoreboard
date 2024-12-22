local Config = require 'config'
local isOpened = false


local function openScoreboard()
    if isOpened then
        isOpened = false
        return SendNUIMessage({
            action = 'setVisible',
            data = false,
        })
    end

    isOpened = true

    local data = lib.callback.await('ac_scoreboard:getServerData', false)

    if data.groups then
        local groups = {}

        for index, group in ipairs(Config.groups) do
            groups[index] = {
                label = group.label,
                count = data.groups[index],
                icon = group.icon,
            }
        end

        data.groups = groups
    end

    if data.statusIndicators then
        local indicators = {}

        for index, indicator in ipairs(Config.statusIndicators) do
            indicators[index] = {
                label = indicator.label,
                icon = indicator.icon,
                state = data.statusIndicators[index],
            }
        end

        data.statusIndicators = indicators
    end

    if data.footer then
        data.footer.serverId = cache.serverId
    end

    SendNUIMessage({
        action = 'setData',
        data = data,
    })

    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(true)
    SetCursorLocation(Config.settings.side == 'right' and 0.8 or 0.2, 0.5)

    SendNUIMessage({
        action = 'setVisible',
        data = true,
    })

    while isOpened do
        HudWeaponWheelIgnoreSelection()
        DisablePlayerFiring(cache.playerId, true)
        DisableControlAction(0, 1, true) -- INPUT_LOOK_LR
        DisableControlAction(0, 2, true) -- INPUT_LOOK_UD
        DisableControlAction(0, 200, true) -- INPUT_FRONTEND_PAUSE_ALTERNATE
        Wait(0)
    end

    while IsDisabledControlPressed(0, 200) do
        DisableControlAction(0, 200, true)
        Wait(0)
    end

    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
end

RegisterNUICallback('close', function(_, cb)
    cb(1)
    isOpened = false
end)


TriggerEvent('chat:addSuggestion', ('/%s'):format(Config.commandName), locale('command_open'))
RegisterCommand(Config.commandName, openScoreboard, false)

if Config.commandKey then
	RegisterKeyMapping(Config.commandName, locale('keymap_open'), 'keyboard', Config.commandKey)
end


AddEventHandler('onResourceStop', function(resource)
    if resource == cache.resource then
        if isOpened then
            SetNuiFocus(false, false)
            SetNuiFocusKeepInput(false)
        end
    end
end)
