-- NWT_historyManager
--
-- Event manager for tracking farm's net worth history
--

NWT_historyManager = {}
NWT_historyManager.histories = {}

local NWT_historyManager_mt = Class(NWT_historyManager, AbstractManager)

function NWT_historyManager.new(customMt)
  local self = NWT_historyManager:superClass().new(customMt or NWT_historyManager_mt)
  self.histories = {}

  return self
end

function NWT_historyManager:loadMap()
  g_messageCenter:subscribe(MessageType.DAY_CHANGED, self.onDayChanged, self)
end

function NWT_historyManager:onDayChanged()
  if g_currentMission:getIsServer() then
    g_nwt_historyManager:recordFarmValue()

  end
end

function NWT_historyManager:recordFarmValue()
  local farmId = g_farmManager:getFarmByUserId(g_currentMission.playerUserId).farmId
  local entryData = NWT_netWorthCalcUtil:getEntries(farmId)
  local fNetWorthTotalValue = 0
  for _, entry in pairs(entryData) do
    fNetWorthTotalValue = fNetWorthTotalValue + entry.entryAmount

  end
  local dayId = g_currentMission.environment.currentDay
  local history = NWT_history.new(g_currentMission:getIsServer(), g_currentMission:getIsClient())
  history:init(farmId, dayId, "Total", fNetWorthTotalValue)
  history:register()

  -- DebugUtil.printTableRecursively(g_currentMission.environment)
  table.insert(self.histories, history)

end

g_nwt_historyManager = NWT_historyManager.new()
