-- NWT_trackOverTimeManager
--
-- Event manager for tracking farm's net worth over time
--

NWT_trackOverTimeManager = {}

local NWT_trackOverTimeManager_mt = Class(NWT_trackOverTimeManager, AbstractManager)

function NWT_trackOverTimeManager.new(customMt)
  local self = NWT_trackOverTimeManager:superClass().new(customMt or NWT_trackOverTimeManager_mt)

  return self
end

function NWT_trackOverTimeManager:loadMap()
  g_messageCenter:subscribe(MessageType.PERIOD_CHANGED, self.onPeriodChanged, self)
end

function NWT_trackOverTimeManager:onPeriodChanged()
  if g_currentMission:getIsServer() then
    g_nwt_trackOverTimeManager:recordFarmValues()

  end
end

function NWT_trackOverTimeManager:recordFarmValues()
  print("--- NWT TODO ---")
end

g_nwt_trackOverTimeManager = NWT_trackOverTimeManager.new()
