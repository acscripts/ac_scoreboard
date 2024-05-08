-----------------------------------------------------------------
-- Visit https://docs.acscripts.dev/scoreboard for documentation
-----------------------------------------------------------------

return {
    settings = {
        title = {
            text = 'AC Scoreboard',
            logo = 'https://static.hypen.cz/images/web/hypen-logo.svg',
        },

        side = 'right',

        showOverlay = true,

        overlayBlur = 'sm',

        closeOnEscape = true,

        closeOnOutsideClick = true,

        uppercaseNames = false,

        compactRows = false,

        playerColumns = 1,

        groupColumns = 1,
    },

    -- Command name for opening the scoreboard
    commandName = 'scoreboard',

    -- Default keybind for the '/scoreboard' command
    commandKey = 'DELETE',

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
    }
}
