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

---@param job string
---@return string, boolean
local function deretardifyEsxDutySystem(job)
    local groupName = job
    local onDuty = true

    if job:sub(1, 4) == 'off_' then
        groupName = job:sub(5)
        onDuty = false
    end

    return groupName, onDuty
end


CreateThread(function()
    local ESX = exports.es_extended:getSharedObject()

    for _, player in ipairs(ESX.GetExtendedPlayers()) do
        local group = player.job
        local groupName, onDuty = deretardifyEsxDutySystem(group.name)

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
AddEventHandler('esx:playerLoaded', function(_, player)
    local group = player.job
    local groupName, onDuty = deretardifyEsxDutySystem(group.name)

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
AddEventHandler('esx:setJob', function(playerId, group)
    local oldGroup = Players[playerId]
    local groupName, onDuty = deretardifyEsxDutySystem(group.name)

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

    local groupName, onDuty = deretardifyEsxDutySystem(group.name)

    if Config.includeOffDuty or onDuty then
        removeMember(groupName)
    end

	Players[playerId] = nil
end

AddEventHandler('esx:playerLogout', removePlayer)
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
