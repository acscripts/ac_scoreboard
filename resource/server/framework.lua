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

	-- add
	local function addJob(job)
		jobCount[job.name] = (jobCount[job.name] or 0) + 1
		GlobalState[('%s:count'):format(job.name)] = jobCount[job.name]
	end

	local function playerLoaded(_, xPlayer)
		local data = {
			name = xPlayer.job.name,
			onDuty = xPlayer.job.onDuty == nil or xPlayer.job.onDuty,
		}

		ESX.Players[xPlayer.source] = data

		if data.onDuty then addJob(data) end
	end

	for i = 1, #ESX.Players do
		playerLoaded(_, ESX.Players[i])
	end

	AddEventHandler('esx:playerLoaded', playerLoaded)

	-- remove
	local function removeJob(job)
		jobCount[job.name] = (jobCount[job.name] or 1) - 1
		GlobalState[('%s:count'):format(job.name)] = jobCount[job.name]
	end

	AddEventHandler('esx:playerDropped', function(playerId)
		local lastJob = ESX.Players[playerId]
		ESX.Players[playerId] = nil

		if lastJob.onDuty then removeJob(lastJob) end
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
			if data.onDuty then addJob(data) end
			if lastJob.onDuty then removeJob(lastJob) end
		end
	end)

end
