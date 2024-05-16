if not lib.checkDependency('ox_core', '0.25.0', true) then return end

local Config = require 'config'


local function getCounts()
    local counts = {}

    for index, group in ipairs(Config.groups) do
        local totalCount = 0

        for _, groupName in ipairs(group.groups) do
            totalCount += GlobalState[('%s:count'):format(groupName)] or 0
        end

        counts[index] = totalCount
    end

    return counts
end


return {
    getCounts = getCounts,
}
