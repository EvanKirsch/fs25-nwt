-- NWT_farmValueDelegate
--
-- Delegates farm value page lookups
--

NWT_farmValueDelegate = {}
NWT_farmValueDelegate._mt = Class(NWT_farmValueDelegate, TabbedMenuFrameElement)

function NWT_farmValueDelegate.new(customMt)
    local self = NWT_farmValueDelegate:superClass().new(nil, customMt or NWT_farmValueDelegate._mt)
    return self
 end

function NWT_farmValueDelegate:getFarmEnteries()
    local farmId = g_farmManager:getFarmByUserId(g_currentMission.playerUserId).farmId
    local entryData = NWT_netWorthCalcUtil:getEntries(farmId)
    return entryData
end
