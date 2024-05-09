local Config = require 'config'



---@return table
local function getUiLocales()
    local locales = lib.getLocales()
    local uiLocales = {}

    for key, locale in pairs(locales) do
        local uiKey = key:match('^ui%.(.+)')

        if uiKey then
            uiLocales[uiKey] = locale
        end
    end

    return uiLocales
end



RegisterNUICallback('ready', function(_, cb)
    cb(1)

    SendNUIMessage({
        action = 'setConfig',
        data = Config.settings,
    })

    SendNUIMessage({
        action = 'setLocales',
        data = getUiLocales(),
    })
end)

AddEventHandler('ox_lib:setLocale', function()
    SendNUIMessage({
        action = 'setLocales',
        data = getUiLocales(),
    })
end)



RegisterNUICallback('copyServerId', function(_, cb)
    cb(1)
    lib.setClipboard(tostring(cache.serverId))
end)
