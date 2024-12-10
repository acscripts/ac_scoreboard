if not lib.checkDependency('ox_core', '1.1.3', true) then return end

local Config = require 'config'


--- Get the total player count of the given group array
---@param groups string[]
---@param includeOffDuty boolean
---@return number
local function getGroupsCount(groups, includeOffDuty)
    local count = 0

    for _, groupName in ipairs(groups) do
        count += GlobalState[('%s:%s'):format(groupName, includeOffDuty and 'count' or 'activeCount')] or 0
    end

    return count
end

--- Get the total player count of each entry in group section
---@return number[]
local function getAllGroupsCounts()
    local counts = {}
    local includeOffDuty = Config.includeOffDuty

    for index, group in ipairs(Config.groups) do
        counts[index] = getGroupsCount(group.groups, includeOffDuty)
    end

    return counts
end


return {
    getAllGroupsCounts = getAllGroupsCounts,
    getGroupsCount = getGroupsCount,
}
