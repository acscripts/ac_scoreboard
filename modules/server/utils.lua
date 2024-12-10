---@return string?
local function getFramework()
    if GetResourceState('ox_core') == 'started' then
        return 'ox'
    elseif GetResourceState('es_extended') == 'started' then
        return 'esx'
    elseif GetResourceState('qbx_core') == 'started' then
        return 'qbx'
    elseif GetResourceState('qb-core') == 'started' then
        return 'qb'
    end

    return nil
end


return {
    getFramework = getFramework,
}
