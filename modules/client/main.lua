local Config = require 'config'

local isOpened = false



local function closeScoreboard()

end

local function openScoreboard()
    if isOpened then
        isOpened = false
        return SendNUIMessage({
            action = 'setVisible',
            data = false,
        })
    end

    isOpened = true

    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(true)
    SetCursorLocation(0.8, 0.5)
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



RegisterCommand(Config.commandName, openScoreboard, false)
