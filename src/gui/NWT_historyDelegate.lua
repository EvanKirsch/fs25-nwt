-- NWT_historyDelegate
--
-- Delegates history page lookups
--

NWT_historyDelegate = {}
NWT_historyDelegate._mt = Class(NWT_historyDelegate, TabbedMenuFrameElement)

function NWT_historyDelegate.new()
    local self = NWT_historyDelegate:superClass().new(nil, customMt or NWT_historyDelegate._mt)
    return self
 end

function NWT_historyDelegate:getFarmHistories()
    local farmId = g_farmManager:getFarmByUserId(g_currentMission.playerUserId).farmId
    local historyData = NWT_historyUtil:getHistories(farmId)

    -- DebugUtil.printTableRecursively(historyData)
    return historyData
end
