local Config = require 'config'
local Utils = require 'modules.server.utils'

lib.versionCheck('acscripts/ac_scoreboard')


local visibleSections = Config.visibleSections
local Players = nil
local Groups = nil
local Indicators = nil

SetTimeout(0, function()
    if visibleSections.players then
        Players = require 'modules.server.sections.players'
    end

    if visibleSections.groups then
        if Utils.hasExport('ox_core.GetPlayer') then
            Groups = require 'modules.server.sections.groups.ox'
        elseif Utils.hasExport('es_extended.getSharedObject') then
            Groups = require 'modules.server.sections.groups.esx'
        elseif Utils.hasExport('qb-core.GetCoreObject') then
            Groups = require 'modules.server.sections.groups.qb'
        end
    end

    if visibleSections.statusIndicators then
        Indicators = require 'modules.server.sections.indicators'
    end
end)


---@param playerId number
---@param section string
---@return boolean
local function canShowSection(playerId, section)
    local state = visibleSections[section]
    return state == true or state == 'limited' and IsPlayerAceAllowed(tostring(playerId), ('scoreboard.show.%s'):format(section))
end


---@param playerId number
---@return table
lib.callback.register('ac_scoreboard:getServerData', function(playerId)
    local payload = {}

    if Players and canShowSection(playerId, 'players') then
        local showPlayerNames = canShowSection(playerId, 'playerNames')
        local showPlayerIds = canShowSection(playerId, 'playerIds')
        payload.players = Players.getPlayers(showPlayerNames, showPlayerIds)
    end

    if Groups and canShowSection(playerId, 'groups') then
        payload.groups = Groups.getCounts()
    end

    if Indicators and canShowSection(playerId, 'statusIndicators') then
        payload.statusIndicators = Indicators.getStates()
    end

    if canShowSection(playerId, 'footer') then
        payload.footer = {
            maxPlayers = GetConvarInt('sv_maxclients', 0), -- still waiting for the day when we can subscribe to convar changes
            playerCount = GetNumPlayerIndices(),
        }
    end

    return payload
end)
