if not LoadResourceFile(cache.resource, 'web/build/index.html') then
    error('\n^1Unable to load UI. Build ac_scoreboard yourself or download the latest prebuilt release:\n^4https://github.com/acscripts/ac_scoreboard/releases/latest/download/ac_scoreboard.zip^0\n', 0)
end

if not lib.checkDependency('ox_lib', '3.27.0', true) then return end

require 'modules.server.main'
