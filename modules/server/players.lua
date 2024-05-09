local Config = require 'config'
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



lib.callback.register('ac_scoreboard:getPlayerData', function(playerId)
    print(playerId)

    local showPlayerNames = not Config.anonymizePlayerNames or IsPlayerAceAllowed(playerId, 'ac_scoreboard.showPlayerNames')
    local showPlayerIds = Config.showPlayerIds or IsPlayerAceAllowed(playerId, 'ac_scoreboard.showPlayerIds')

    local players = {}
    local index = 1

    for id, name in pairs(Players) do
        local data = {}

        if showPlayerIds then
            data.id = id
        end

        if showPlayerNames then
            data.name = name
        end

        players[index] = data
        index += 1
    end

    -- local payload = msgpack.pack_args(players)
    -- print('size', #payload)

    return {
        players = players,
        maxPlayers = GetConvarInt('sv_maxclients', 0), -- still waiting for the day when we can subscribe to convar changes
        playerCount = GetNumPlayerIndices(),
    }
end)
