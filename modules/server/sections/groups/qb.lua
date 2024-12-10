local Config = require 'config'
local Players = {}
local Groups = {}


---@param groupName string
---@param onDuty boolean
local function addMember(groupName, onDuty)
    local group = Groups[groupName]

    if not group then
        Groups[groupName] = {
            count = 1,
            activeCount = onDuty and 1 or 0,
        }
        return
    end

    group.count += 1

    if onDuty then
        group.activeCount += 1
    end
end

---@param groupName string
---@param onDuty boolean
local function removeMember(groupName, onDuty)
    local group = Groups[groupName]

    if not group then
        Groups[groupName] = {
            count = 0,
            activeCount = 0,
        }
        return
    end

    group.count -= 1

    if onDuty then
        group.activeCount -= 1
    end
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

        addMember(groupName, onDuty)
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

    addMember(groupName, onDuty)
end)

---@param playerId number
---@param group table
AddEventHandler('QBCore:Server:OnJobUpdate', function(playerId, group)
    local oldGroup = Players[playerId]
    if not oldGroup then return end

    local groupName, onDuty = getGroupData(group)

    Players[playerId] = {
        name = groupName,
        onDuty = onDuty,
    }

    removeMember(oldGroup.name, oldGroup.onDuty)
    addMember(groupName, onDuty)
end)


---@param playerId number
local function removePlayer(playerId)
	local group = Players[playerId]
    if not group then return end

    removeMember(group.name, group.onDuty)

	Players[playerId] = nil
end

AddEventHandler('QBCore:Server:OnPlayerUnload', removePlayer)
AddEventHandler('playerDropped', function()
	removePlayer(source)
end)


--- Get the total player count of the given group array
---@param groups string[]
---@param includeOffDuty boolean
---@return number
local function getGroupsCount(groups, includeOffDuty)
    local count = 0
    local dutyKey = includeOffDuty and 'count' or 'activeCount'

    for _, groupName in ipairs(groups) do
        count += Groups[groupName]?[dutyKey] or 0
    end

    return count
end

--- Get the total player count of each entry in group section
---@return number[]
local function getAllGroupsCounts()
    local counts = {}
    local includeOffDuty = Config.includeOffDuty

    for index, group in ipairs(Config.groups) do
        counts[index] = getGroupsCount(group.groups, group.includeOffDuty or group.includeOffDuty == nil and includeOffDuty)
    end

    return counts
end


return {
    getAllGroupsCounts = getAllGroupsCounts,
    getGroupsCount = getGroupsCount,
}
