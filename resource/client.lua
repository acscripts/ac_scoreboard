local opened = false
local initialDataSet = false

local function handleClose()
	SetNuiFocus(false, false)
	SetNuiFocusKeepInput(false)
	opened = false
end

local function setData()
	if not initialDataSet then
		initialDataSet = true
		local maxPlayers = lib.callback.await('ac_scoreboard:getMaxPlayers', false)

		SendNUIMessage({
			action = 'setData',
			data = {
				serverName = ac.serverName,
				maxPlayers = maxPlayers,
				serverId = cache.serverId
			}
		})
	end

	local groupData = {}
	for i=1, #ac.groupList do
		local group = ac.groupList[i]
		local count = 0
		for j=1, #group.groups do
			count += GlobalState[('%s:count'):format(group.groups[j])] or 0
		end

		groupData[#groupData + 1] = {
			label = group.label,
			count = count
		}
	end

	SendNUIMessage({
		action = 'setData',
		data = {
			playerCount = GetNumberOfPlayers(),
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
			DisableControlAction(0, 1, true)
			DisableControlAction(0, 2, true)
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 200, true)

			Wait(0)
		end
	end)

	setData()

	SetNuiFocus(true, true)
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
