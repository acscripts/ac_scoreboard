---@param name string
---@return boolean
local function hasResource(name)
	return GetResourceState(name):find('start') ~= nil
end

local core = (hasResource('es_extended') and 'esx') or (hasResource('qb-core') and 'qb') or (hasResource('ox_core') and 'ox') or ''
if core ~= 'esx' and core ~= 'qb' then return end


local count = {}
local players = {}

---@class JobData
---@field name string Job name
---@field onDuty boolean?
---@field source number

local jobs = {
	---@param job string Job name
	add = function(job)
		count[job] = (count[job] or 0) + 1
		GlobalState[('%s:count'):format(job)] = count[job]
	end,

	---@param job string Job name
	remove = function(job)
		count[job] = (count[job] or 1) - 1
		GlobalState[('%s:count'):format(job)] = count[job]
	end,

	---@param data JobData
	loaded = function(self, data)
		local onDuty = data.onDuty == nil or data.onDuty

		players[data.source] = {
			name = data.name,
			onDuty = onDuty,
		}

		if onDuty then self.add(data.name) end
	end,

	---@param data JobData
	update = function(self, data)
		local lastJob = players[data.source]
		if not lastJob then return end

		local onDuty = data.onDuty == nil or data.onDuty
		if data.name == lastJob.name and onDuty == lastJob.onDuty then return end

		players[data.source] = {
			name = data.name,
			onDuty = onDuty,
		}

		if onDuty then self.add(data.name) end
		if lastJob.onDuty then self.remove(lastJob.name) end
	end
}

AddEventHandler('playerDropped', function()
	local lastJob = players[source]
	players[source] = nil

	if lastJob?.onDuty then jobs.remove(lastJob.name) end
end)


if core == 'esx' then
	-- Credits to Linden (https://gist.github.com/thelindat/93311a4fd6ea6c1d4427438a533e228c)
	local ESX = exports.es_extended:getSharedObject()

	for _, player in pairs(ESX.GetExtendedPlayers()) do
		jobs:loaded({
			name = player.job.name,
			onDuty = player.job.onDuty,
			source = player.source
		})
	end

	AddEventHandler('esx:playerLoaded', function(_, player)
		jobs:loaded({
			name = player.job.name,
			onDuty = player.job.onDuty,
			source = player.source
		})
	end)

	AddEventHandler('esx:setJob', function(playerId, job)
		jobs:update({
			name = job.name,
			onDuty = job.onDuty,
			source = playerId
		})
	end)

elseif core == 'qb' then
	local QB = exports['qb-core']:GetCoreObject()

	for _, player in pairs(QB.Functions.GetQBPlayers()) do
		player = player.PlayerData
		jobs:loaded({
			name = player.job.name,
			onDuty = player.job.onduty,
			source = player.source
		})
	end

	AddEventHandler('QBCore:Server:PlayerLoaded', function(player)
		player = player.PlayerData
		jobs:loaded({
			name = player.job.name,
			onDuty = player.job.onduty,
			source = player.source
		})
	end)

	AddEventHandler('QBCore:Player:SetPlayerData', function(player)
		jobs:update({
			name = player.job.name,
			onDuty = player.job.onduty,
			source = player.source
		})
	end)

end
