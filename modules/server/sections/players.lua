local Players = {}

CreateThread(function()
    for _, playerId in ipairs(GetPlayers()) do
        Players[tonumber(playerId)] = GetPlayerName(playerId)
    end
end)


AddEventHandler('playerJoining', function()
    Players[source] = GetPlayerName(source)
end)

AddEventHandler('playerDropped', function()
    Players[source] = nil
end)


---@param showPlayerNames boolean
---@param showPlayerIds boolean
---@return table[]
local function getPlayers(showPlayerNames, showPlayerIds)
    local players = {}
    local index = 1

    for id, name in pairs(Players) do
        local data = {}

        if showPlayerNames then
            data.name = name
        end

        if showPlayerIds then
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
