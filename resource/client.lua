local opened = false
local maxPlayers = nil

local function handleClose()
	SetNuiFocus(false, false)
	SetNuiFocusKeepInput(false)
	opened = false
end

local function setData()
	if not maxPlayers then
		maxPlayers = lib.callback.await('ac_scoreboard:getMaxPlayers', false)
	end

	local groupData = {}
	for label, groups in pairs(ac.groups) do
		local count = 0
		for i=1, #groups do
			count += GlobalState[('%s:count'):format(groups[i])] or 0
		end

		groupData[#groupData + 1] = {
			label = label,
			count = count
		}
	end

	SendNUIMessage({
		action = 'setData',
		data = {
			serverName = ac.serverName,
			playerCount = GetNumberOfPlayers(),
			maxPlayers = maxPlayers,
			serverId = GetPlayerServerId(PlayerId()),
			groups = groupData
		}
	})
end

RegisterKeyMapping('scoreboard', 'Open scoreboard', 'keyboard', 'DELETE')

RegisterCommand('scoreboard', function()
	if opened then
		handleClose()
		SendNUIMessage({
			action = 'setVisible',
			data = false
		})
		return
	end

	opened = true

	CreateThread(function()
		while opened do
			DisablePlayerFiring(cache.playerId, true)
			HudWeaponWheelIgnoreSelection()
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 200, true)

			Wait(0)
		end
	end)

	setData()

	SetNuiFocus(true, false)
	SetNuiFocusKeepInput(true)

	SendNUIMessage({
		action = 'setVisible',
		data = true
	})
end)

RegisterNUICallback('close', function(_, cb)
	cb(1)
	handleClose()
end)
