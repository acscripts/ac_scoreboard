---------------------------------------------------------------------------------------------
-- More detailed description of each config option can be found in 'docs/config.md' file.
---------------------------------------------------------------------------------------------

ac = {
	-- Language for the UI
	locale = 'en',

	-- Whether to check for newer resource version and notify in server console.
	versionCheck = true,

	-- Server name shown in the scoreboard header.
	serverName = 'AC Scoreboard',

	-- Command name to open the scoreboard UI.
	commandName = 'scoreboard',

	-- Default keybind for the '/scoreboard' command.
	commandKey = 'DELETE',

	-- Group list shown in the scoreboard.
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
