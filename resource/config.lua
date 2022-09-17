ac = {
	locale = 'en',

	-- Server name shown in the scoreboard header.
	serverName = 'Very cool server',

	-- Command name to open the scoreboard UI.
	commandName = 'scoreboard',

	-- Default keybind for the '/scoreboard' command.
	commandKey = 'DELETE',

	-- Listed groups with visible active player count.
	groupList = {
		{
			label = 'Police',
			groups = {'police', 'sheriff'}
		},
		{
			label = 'EMS',
			groups = {'ambulance'}
		},
		{
			label = 'Taxi',
			groups = {'taxi'}
		},
		{
			label = 'Mechanic',
			groups = {'mechanic', 'lsc', 'bennys'}
		}
	}
}
