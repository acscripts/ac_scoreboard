local Config = require 'config'
local Utils = require 'modules.server.utils'

lib.versionCheck('acscripts/ac_scoreboard')

SetTimeout(0, function()
    if Utils.hasExport('ox_core.GetPlayer') then
        require 'modules.server.framework.ox'
    elseif Utils.hasExport('es_extended.getSharedObject') then
        require 'modules.server.framework.esx'
    elseif Utils.hasExport('qb-core.GetCoreObject') then
        require 'modules.server.framework.qb'
    end
end)



local visibleSections = Config.visibleSections
local Players = visibleSections.players and require 'modules.server.players'

lib.callback.register('ac_scoreboard:getServerData', function(playerId)
    local payload = {}

    if visibleSections.players and Players then
        local showPlayerNames = not Config.anonymizePlayerNames or IsPlayerAceAllowed(playerId, 'ac_scoreboard.showPlayerNames')
        local showPlayerIds = Config.showPlayerIds or IsPlayerAceAllowed(playerId, 'ac_scoreboard.showPlayerIds')

        payload.players = Players.getPlayers(showPlayerNames, showPlayerIds)
    end

    if visibleSections.groups then
        payload.groups = {}
    end

    if visibleSections.statusIndicators then
        payload.statusIndicators = {}
    end

    if visibleSections.footer then
        payload.footer = {
            maxPlayers = GetConvarInt('sv_maxclients', 0), -- still waiting for the day when we can subscribe to convar changes
            playerCount = GetNumPlayerIndices(),
        }
    end

    return payload
end)
