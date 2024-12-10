local Config = require 'config'
local Utils = require 'modules.server.utils'
local Groups = nil

local IndicatorMap = {}
local Indicators = {}


CreateThread(function()
    local anyGroupTrigger = false

    for index, data in ipairs(Config.statusIndicators) do
        IndicatorMap[data.id] = index
        Indicators[index] = {
            state = data.defaultState or false,
            forcedState = nil,
            groupTrigger = data.groupTrigger,
        }

        if data.groupTrigger then
            anyGroupTrigger = true
        end
    end

    if anyGroupTrigger then
        local framework = Utils.getFramework()

        if framework then
            Groups = require(('modules.server.sections.groups.%s'):format(framework))
        else
            lib.print.warn('No compatible framework found. Integrated support for status indicators was automatically disabled. You can still use the `setIndicatorState` export to manually control the indicators.')
        end
    end
end)


---@param id string
---@param state boolean
local function setIndicatorState(id, state)
    local index = IndicatorMap[id]
    if not index then return end

    local indicator = Indicators[index]

    if indicator.groupTrigger then
        lib.print.warn('Cannot manually set the state of a group-triggered status indicator. You can use `forceIndicatorState` export to override the state.')
        return
    end

    indicator.state = state or false
end

AddEventHandler('ac_scoreboard:setIndicatorState', setIndicatorState)
exports('setIndicatorState', setIndicatorState)


---@param id string
---@param state? boolean
local function forceIndicatorState(id, state)
    local index = IndicatorMap[id]
    if not index then return end

    Indicators[index].forcedState = state
end

AddEventHandler('ac_scoreboard:forceIndicatorState', forceIndicatorState)
exports('forceIndicatorState', forceIndicatorState)


---@return boolean[]
local function getStates()
    local states = {}

    for index, data in pairs(Indicators) do
        local state = data.state

        if data.forcedState ~= nil then
            state = data.forcedState

        elseif data.groupTrigger and Groups then
            local trigger = data.groupTrigger
            local count = Groups.getGroupsCount(trigger.groups, trigger.includeOffDuty)

            if count >= (trigger.minimumCount or 0) then
                state = true
            end
        end

        states[index] = state
    end

    return states
end


return {
    getStates = getStates,
}
