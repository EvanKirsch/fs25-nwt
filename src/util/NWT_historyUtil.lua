-- NWT_historyUtil
--
-- Manages the creation of histories
--

NWT_historyUtil = {}

function NWT_historyUtil:getHistories(farmId)
    local histories = g_nwt_historyManager.histories
    local farmHistories = {}
    for _, history in pairs(histories) do
        if history.farmId == farmId then
            table.insert(farmHistories, history)
        end

    end

    return farmHistories
end
