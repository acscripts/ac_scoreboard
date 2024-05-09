if not lib.checkDependency('ox_core', '0.25.0', true) then return end

local Config = require 'config'
local Ox = require '@ox_core.lib.init' --[[ @as OxServer ]]
