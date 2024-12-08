local Config = require 'config'
local IndicatorMap = {}
local Indicators = {}

CreateThread(function()
    for index, data in ipairs(Config.statusIndicators) do
        IndicatorMap[data.id] = index
        Indicators[index] = data.defaultState or false
    end
end)


---@param id string
---@param state boolean
local function setIndicatorState(id, state)
    if not IndicatorMap[id] then return end
    local index = IndicatorMap[id]
    Indicators[index] = state or false
end

---@return boolean[]
local function getStates()
    return Indicators
end


AddEventHandler('ac_scoreboard:setIndicatorState', setIndicatorState)
exports('setIndicatorState', setIndicatorState)

return {
    getStates = getStates,
}
