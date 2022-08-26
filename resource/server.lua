lib.callback.register('ac_scoreboard:getMaxPlayers', function()
	return GetConvarInt('sv_maxclients', 32)
end)
