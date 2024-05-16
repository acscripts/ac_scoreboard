local Players = {}

AddEventHandler('playerJoining', function()
    local playerId = tostring(source)
    Players[playerId] = GetPlayerName(playerId)
end)

AddEventHandler('playerDropped', function()
    Players[tostring(source)] = nil
end)

CreateThread(function()
    for _, playerId in ipairs(GetPlayers()) do
        Players[playerId] = GetPlayerName(playerId)
    end
end)

---@param playerNames boolean
---@param playerIds boolean
---@return table[]
local function getPlayers(playerNames, playerIds)
    local players = {}
    local index = 1

    for id, name in pairs(Players) do
        local data = {}

        if playerNames then
            data.name = name
        end

        if playerIds then
            data.id = id
        end

        players[index] = data
        index += 1
    end

    return players
end

return {
    getPlayers = getPlayers,
}
