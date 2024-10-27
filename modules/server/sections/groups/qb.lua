local Config = require 'config'
local Players = {}
local Groups = {}


---@param groupName string
local function addMember(groupName)
    Groups[groupName] = (Groups[groupName] or 0) + 1
end

---@param groupName string
local function removeMember(groupName)
    Groups[groupName] = (Groups[groupName] or 1) - 1
end

--- To eliminate confusion between `onDuty` and `onduty`
---@param job table
---@return string, boolean
local function getGroupData(job)
    return job.name, job.onduty
end


CreateThread(function()
    local QB = exports['qb-core']:GetCoreObject()

    for _, player in ipairs(QB.Functions.GetQBPlayers()) do
        player = player.PlayerData
        local groupName, onDuty = getGroupData(player.job)

        Players[player.source] = {
            name = groupName,
            onDuty = onDuty,
        }

        if Config.includeOffDuty or onDuty then
            addMember(groupName)
        end
    end
end)


---@param player table
AddEventHandler('QBCore:Server:PlayerLoaded', function(player)
    player = player.PlayerData
    local groupName, onDuty = getGroupData(player.job)

    Players[player.source] = {
        name = groupName,
        onDuty = onDuty,
    }

    if Config.includeOffDuty or onDuty then
        addMember(groupName)
    end
end)

---@param playerId number
---@param group table
AddEventHandler('QBCore:Server:OnJobUpdate', function(playerId, group)
    local oldGroup = Players[playerId]
    local groupName, onDuty = getGroupData(group)

    Players[playerId] = {
        name = groupName,
        onDuty = onDuty,
    }

    if Config.includeOffDuty then
        removeMember(oldGroup.name)
        addMember(groupName)
    else
        if oldGroup.onDuty then
            removeMember(oldGroup.name)
        end

        if onDuty then
            addMember(groupName)
        end
    end
end)


---@param playerId number
local function removePlayer(playerId)
	local group = Players[playerId]
    if not group then return end

    if Config.includeOffDuty or group.onDuty then
        removeMember(group.name)
    end

	Players[playerId] = nil
end

AddEventHandler('QBCore:Server:OnPlayerUnload', removePlayer)
AddEventHandler('playerDropped', function()
	removePlayer(source)
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
