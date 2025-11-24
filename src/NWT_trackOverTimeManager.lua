-- NWT_trackOverTimeManager
--
-- Event manager for tracking farm's net worth over time
--

NWT_trackOverTimeManager = {}
NWT_trackOverTimeManager.periodFarmValues = {}

local NWT_trackOverTimeManager_mt = Class(NWT_trackOverTimeManager, AbstractManager)

function NWT_trackOverTimeManager.new(customMt)
  local self = NWT_trackOverTimeManager:superClass().new(customMt or NWT_trackOverTimeManager_mt)
  self.periodFarmValues = {}

  return self
end

function NWT_trackOverTimeManager:loadMap()
  g_messageCenter:subscribe(MessageType.PERIOD_CHANGED, self.onPeriodChanged, self)
end

function NWT_trackOverTimeManager:onPeriodChanged()
  if g_currentMission:getIsServer() then
    g_nwt_trackOverTimeManager:recordFarmValue()

  end
end

function NWT_trackOverTimeManager:recordFarmValue()
  local farmId = g_farmManager:getFarmByUserId(g_currentMission.playerUserId).farmId
  local entryData = NWT_netWorthCalcUtil:getEntries(farmId)
  local fNetWorthTotalValue = 0
  for _, entry in pairs(entryData) do
    fNetWorthTotalValue = fNetWorthTotalValue + entry.entryAmount

  end
  local periodId = g_currentMission.environment.currentPeriod
  local periodValue = NWT_valueAtPeriod.new(g_currentMission:getIsServer(), g_currentMission:getIsClient())
  periodValue:init(farmId, periodId, "Total", fNetWorthTotalValue)
  periodValue:register()

  -- DebugUtil.printTableRecursively(g_currentMission.environment)
  table.insert(self.periodFarmValues, periodValue)

end

g_nwt_trackOverTimeManager = NWT_trackOverTimeManager.new()
