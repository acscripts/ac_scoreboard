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

---@param playerId string
---@param section string
---@return boolean
local function canShowSection(playerId, section)
    local state = visibleSections[section]
    return state == true or state == 'limited' and IsPlayerAceAllowed(playerId, ('scoreboard.show.%s'):format(section))
end

lib.callback.register('ac_scoreboard:getServerData', function(playerId)
    local payload = {}

    if Players and canShowSection(playerId, 'players') then
        local showPlayerNames = canShowSection(playerId, 'playerNames')
        local showPlayerIds = canShowSection(playerId, 'playerIds')
        payload.players = Players.getPlayers(showPlayerNames, showPlayerIds)
    end

    if canShowSection(playerId, 'groups') then
        payload.groups = {}
    end

    if canShowSection(playerId, 'statusIndicators') then
        payload.statusIndicators = {}
    end

    if canShowSection(playerId, 'footer') then
        payload.footer = {
            maxPlayers = GetConvarInt('sv_maxclients', 0), -- still waiting for the day when we can subscribe to convar changes
            playerCount = GetNumPlayerIndices(),
        }
    end

    return payload
end)
