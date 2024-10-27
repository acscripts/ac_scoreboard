if not lib.checkDependency('ox_core', '1.1.3', true) then return end

local Config = require 'config'
local COUNT_TYPE = Config.includeOffDuty and 'count' or 'activeCount'


local function getCounts()
    local counts = {}

    for index, group in ipairs(Config.groups) do
        local totalCount = 0

        for _, groupName in ipairs(group.groups) do
            totalCount += GlobalState[('%s:%s'):format(groupName, COUNT_TYPE)] or 0
        end

        counts[index] = totalCount
    end

    return counts
end


return {
    getCounts = getCounts,
}
