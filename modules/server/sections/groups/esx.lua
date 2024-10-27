local Config = require 'config'
local Players = {}
local Groups = {}


-- ESX apparently doesn't have built-in duty system :joy:
-- In case you have one, just remove this line and change the code below to suit your needs (don't ask for support)
Config.includeOffDuty = true


local function addMember(groupName)
    Groups[groupName] = (Groups[groupName] or 0) + 1
end

local function removeMember(groupName)
    Groups[groupName] = (Groups[groupName] or 1) - 1
end


CreateThread(function()
    local ESX = exports.es_extended:getSharedObject()

    for _, player in ipairs(ESX.GetExtendedPlayers()) do
        local group = player.job
        Players[player.source] = {
            name = group.name,
            onDuty = group.onDuty,
        }

        if Config.includeOffDuty or group.onDuty then
            addMember(group.name)
        end
    end
end)


AddEventHandler('esx:playerLoaded', function(_, player)
    local group = player.job

    Players[player.source] = {
        name = group.name,
        onDuty = group.onDuty,
    }

    if Config.includeOffDuty or group.onDuty then
        addMember(group.name)
    end
end)

AddEventHandler('esx:setJob', function(playerId, group)
    local oldGroup = Players[playerId]

    Players[playerId] = {
        name = group.name,
        onDuty = group.onDuty,
    }

    if Config.includeOffDuty then
        removeMember(oldGroup.name)
        addMember(group.name)
    else
        if oldGroup.onDuty then
            removeMember(oldGroup.name)
        end

        if group.onDuty then
            addMember(group.name)
        end
    end
end)

AddEventHandler('playerDropped', function()
	local group = Players[source]
    if not group then return end

    if Config.includeOffDuty or group.onDuty then
        removeMember(group.name)
    end

	Players[source] = nil
end)


local function getCounts()
    local counts = {}

    for index, group in ipairs(Config.groups) do
        local totalCount = 0

        for _, groupName in ipairs(group.groups) do
            totalCount += Groups[groupName] or 0
        end

        counts[index] = totalCount
    end

    return counts
end


return {
    getCounts = getCounts,
}
