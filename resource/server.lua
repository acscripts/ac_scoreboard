local players = {}
local maxPlayers = GetConvarInt('sv_maxclients', 32)
local lastMaxPlayers = os.time()

RegisterNetEvent('ox:playerJoined', function()
	if not players[source] then
		players[source] = {
			name = GetPlayerName(source),
			id = source
		}
	end
end)

AddEventHandler('playerDropped', function()
	players[source] = nil
end)

CreateThread(function()
	for _, playerId in pairs(GetPlayers()) do
		players[playerId] = {
			name = GetPlayerName(playerId),
			id = playerId
		}
	end
end)

lib.callback.register('ac_scoreboard:getData', function()
	-- "none of that is really important or worth the risk of badly designing stuff over just a every-so-often poll or so, meh"
	-- Anyways, update 'maxPlayers' every 5 minutes if called, because it's not that important :)
	if os.time() - lastMaxPlayers > 300 then
		maxPlayers = GetConvarInt('sv_maxclients', 32)
		lastMaxPlayers = os.time()
	end

	return {
		players = players,
		maxPlayers = maxPlayers
	}
end)
