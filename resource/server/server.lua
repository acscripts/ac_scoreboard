local players = {}
local playerCount = 0
local maxPlayers = GetConvarInt('sv_maxclients', 32)
local lastMaxPlayers = os.time()

---@param playerId string
local function addPlayer(playerId)
	if not players[playerId] then
		players[playerId] = GetPlayerName(playerId)
		playerCount += 1
	end
end

RegisterNetEvent('ac_scoreboard:playerJoined', function()
	addPlayer(tostring(source))
end)

AddEventHandler('playerDropped', function()
	players[tostring(source)] = nil
	playerCount -= 1
end)

CreateThread(function()
	for _, playerId in pairs(GetPlayers()) do
		addPlayer(playerId)
	end
end)

RegisterNetEvent('ac_scoreboard:requestData', function()
	-- Convar change handlers are "not really important or worth the risk of badly designing stuff",
	-- so we update 'maxPlayers' every 5 minutes if called, like a dicks.
	if os.time() - lastMaxPlayers > 300 then
		maxPlayers = GetConvarInt('sv_maxclients', 32)
		lastMaxPlayers = os.time()
	end

	TriggerClientEvent('ac_scoreboard:receiveData', source, {
		players = players,
		playerCount = playerCount,
		maxPlayers = maxPlayers
	})
end)
