-----------------------------------------------------------------
-- Visit https://docs.acscripts.dev/scoreboard for documentation
-----------------------------------------------------------------

return {
    settings = {
        title = {
            text = 'AC Scoreboard',
            logo = 'https://cfx-nui-ac_scoreboard/web/build/logo.svg',
        },

        side = 'right',

        showOverlay = false,

        closeOnEscape = true,

        closeOnOutsideClick = true,

        uppercaseNames = false,

        highlightEmptyGroups = true,

        compactPlayers = false,

        compactGroups = false,

        playerColumns = 1,

        groupColumns = 1,
    },

    visibleSections = {
        groups = true,
        players = true,
        playerNames = true,
        playerIds = true,
        statusIndicators = true,
        footer = true,
    },

    -- Command name for opening the scoreboard
    commandName = 'scoreboard',

    -- Default keybind for the '/scoreboard' command
    commandKey = 'DELETE',

    -- Whether to include off-duty players in group count
    includeOffDuty = false,

    -- Group list shown in the scoreboard
    groups = {
        {
            label = 'Police',
            groups = {'police', 'sheriff'},
        },
        {
            label = 'EMS',
            groups = {'ambulance'},
        },
        {
            label = 'Mechanics',
            groups = {'lsc', 'bennys', 'hayes'},
        },
        {
            label = 'Taxi',
            groups = {'taxi'},
        },
    },

    -- Status indicators shown in the scoreboard
    statusIndicators = {
        { id = 'house_robbery', label = 'House robbery', icon = 'mdi:house', defaultState = true },
        { id = 'store_robbery', label = 'Store robbery', icon = 'mdi:store', defaultState = false },
        { id = 'bank_robbery', label = 'Bank robbery', icon = 'mdi:bank' },
    },
}
