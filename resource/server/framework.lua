---@param name string
---@return boolean
local function hasResource(name)
	return GetResourceState(name):find('start') ~= nil
end

local core = (hasResource('es_extended') and 'esx') or (hasResource('qb-core') and 'qb') or (hasResource('ox_core') and 'ox') or ''

if core == 'esx' then
	-- Credits to Linden (https://gist.github.com/thelindat/93311a4fd6ea6c1d4427438a533e228c)
	local ESX = exports.es_extended:getSharedObject()
	local jobCount = {}

	-- setters
	local function addJob(job)
		jobCount[job] = (jobCount[job] or 0) + 1
		GlobalState[('%s:count'):format(job)] = jobCount[job]
	end

	local function removeJob(job)
		jobCount[job] = (jobCount[job] or 1) - 1
		GlobalState[('%s:count'):format(job)] = jobCount[job]
	end

	-- add
	local function playerLoaded(_, xPlayer)
		local data = {
			name = xPlayer.job.name,
			onDuty = xPlayer.job.onDuty == nil or xPlayer.job.onDuty,
		}

		ESX.Players[xPlayer.source] = data

		if data.onDuty then addJob(data.name) end
	end

	for i = 1, #ESX.Players do
		playerLoaded(_, ESX.Players[i])
	end

	AddEventHandler('esx:playerLoaded', playerLoaded)

	-- remove
	AddEventHandler('esx:playerDropped', function(playerId)
		local lastJob = ESX.Players[playerId]
		ESX.Players[playerId] = nil

		if lastJob.onDuty then removeJob(lastJob.name) end
	end)

	-- set
	AddEventHandler('esx:setJob', function(playerId, job)
		local data = {
			name = job.name,
			onDuty = job.onDuty == nil or job.onDuty,
		}

		local lastJob = ESX.Players[playerId]
		ESX.Players[playerId] = data

		if job.name ~= lastJob.name then
			if data.onDuty then addJob(data.name) end
			if lastJob.onDuty then removeJob(lastJob.name) end
		end
	end)

elseif core == 'qb' then
	local QB = exports['qb-core']:GetCoreObject()
	local players = {}
	local jobCount = {}

	-- setters
	local function addJob(job)
		jobCount[job] = (jobCount[job] or 0) + 1
		GlobalState[('%s:count'):format(job)] = jobCount[job]
	end

	local function removeJob(job)
		jobCount[job] = (jobCount[job] or 1) - 1
		GlobalState[('%s:count'):format(job)] = jobCount[job]
	end

	-- add
	local function playerLoaded(player)
		player = player.PlayerData
		local data = {
			name = player.job.name,
			onduty = player.job.onduty == nil or player.job.onduty,
		}

		players[player.source] = data

		if data.onduty then addJob(data.name) end
	end

	for _, player in pairs(QB.Functions.GetQBPlayers()) do
		playerLoaded(player)
	end

	AddEventHandler('QBCore:Server:PlayerLoaded', playerLoaded)

	-- remove
	AddEventHandler('playerDropped', function()
		local lastJob = players[source]
		players[source] = nil

		if lastJob.onduty then removeJob(lastJob.name) end
	end)

	-- set
	AddEventHandler('QBCore:Server:OnJobUpdate', function(playerId, job)
		local data = {
			name = job.name,
			onduty = job.onduty == nil or job.onduty,
		}

		local lastJob = players[playerId]
		players[playerId] = data

		if job.name ~= lastJob.name then
			if data.onduty then addJob(data.name) end
			if lastJob.onduty then removeJob(lastJob.name) end
		end
	end)

end
