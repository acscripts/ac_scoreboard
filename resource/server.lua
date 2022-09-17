local players = {}
local maxPlayers = GetConvarInt('sv_maxclients', 32)
local lastMaxPlayers = os.time()

local function addPlayer(playerId)
	playerId = tostring(playerId)
	if not players[playerId] then
		players[playerId] = GetPlayerName(playerId)
	end
end

RegisterNetEvent('ox:playerJoined', function()
	addPlayer(source)
end)

AddEventHandler('playerDropped', function()
	players[tostring(source)] = nil
end)

CreateThread(function()
	for _, playerId in pairs(GetPlayers()) do
		addPlayer(playerId)
	end
end)

lib.callback.register('ac_scoreboard:getData', function()
	-- Convar change handlers are "not really important or worth the risk of badly designing stuff",
	-- so we update 'maxPlayers' every 5 minutes if called, like a dicks.
	if os.time() - lastMaxPlayers > 300 then
		maxPlayers = GetConvarInt('sv_maxclients', 32)
		lastMaxPlayers = os.time()
	end

	return {
		players = players,
		maxPlayers = maxPlayers
	}
end)

lib.versionCheck('antond15/ac_scoreboard')
