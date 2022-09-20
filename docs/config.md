# Config explanation
In this file you can find more detailed description of each config option.  

<details>
<summary><b>Quick navigation</b></summary>

- [locale](#locale)
- [versionCheck](#versioncheck)
- [serverName](#servername)
- [commandName](#commandname)
- [commandKey](#commandkey)
- [visibleParts](#visibleparts)
- [drawerSide](#drawerside)
- [groupList](#grouplist)
</details>

<br>

## locale
What supported language to use for the UI.  
Locale name is the same as the file name in [locales](../locales) folder without the `.lua` extension (eg. **en**, **cs**).  
Feel free to submit a PR with more languages!

**Accepted values**  
`'en'` = Or any other locale.



## versionCheck
Whether to check for newer resource version and notify in server console.

**Accepted values**  
`true` = You will be notified in server console when a newer version of **ac_scoreboard** is available.  
`false` = You will need to manually check for a newer version on GitHub 👎🏽



## serverName
Server name shown in the header of the scoreboard.

**Accepted values**  
`'My cool RP server'` = Or any other string value



## commandName
Command name for opening the scoreboard.

**Accepted values**  
`'scoreboard'` = Or any other string value



## commandKey
Default keybind for the scoreboard command.

**Accepted values**  
`false` = The keybind will not be created at all.  
`''` = Empty quotes for creating the keybind, but not setting a default key.   
`'DELETE'` = Or any other [valid key](https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard) to create a keybind with **this** default key.



## visibleParts
Which parts of the scoreboard should be visible.

**Accepted values**  
`'both'` = Both groups and players will be visible.  
`'groups'` = Only groups will be visible.  
`'players'` = Only players will be visible.



## drawerSide
On which side of the screen the scoreboard should be.

**Accepted values**  
`'left'` = Left.  
`'right'` = Right.



## groupList
List of groups which will be visible in the scoreboard UI with their total count.  
Order in the UI is the same as in the config!

**Accepted values**  
```lua
{
    label = 'Label for the groups below',
    groups = {'any valid', 'groups'}
}
```

**Example config data**
```lua
groupList = {
    {   -- Number of players in 'police' and/or 'sheriff' group will be shown under the 'Police' label.
        label = 'Police',
        groups = {'police', 'sheriff'}
    },
    {   -- Number of players in 'ambulance' group will be shown under the 'EMS' label.
        label = 'EMS',
        groups = {'ambulance'}
    },
}
```