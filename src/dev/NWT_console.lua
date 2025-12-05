-- NWT_Console adds console commands for NWT, inspired by Courseplay's implemention
--

NWT_Console = {}
NWT_Console.commands = {
    --- call name, description, function
    { 'nwtBuildHistory', 'builds value history from last recorded day', 'buildHistory' },
    { 'nwtToggleDebug', 'toggles nwt debug mode', 'toggleDebug' },
    { 'nwtGetFarmValue', 'calculates farms current value', 'getFarmValue' },
}

local NWT_Console_mt = Class(NWT_Console, Object)

function NWT_Console.new(customMt)
    local self = NWT_Console:superClass().new(customMt or NWT_Console_mt)

    return self
end

function NWT_Console:init()
    self:registerConsoleCommands()
end

function NWT_Console:delete()
    self:unregisterConsoleCommands()
end

function NWT_Console:registerConsoleCommands()
    for _, commandData in ipairs(self.commands) do
        local name, desc, funcName = unpack(commandData)
        addConsoleCommand( name, desc, funcName, self)
    end
end

function NWT_Console:unregisterConsoleCommands()
    for _, commandData in ipairs(self.commands) do
        local name = unpack(commandData)
        removeConsoleCommand(name)
    end
end

---
--- Start Console Commands
---

function NWT_Console:buildHistory()
  local currentHistories = g_nwt_historyManager.histories
  local farmId = g_farmManager:getFarmByUserId(g_currentMission.playerUserId).farmId
  local minHistory = nil
  if (currentHistories ~= nil) then
      minHistory = self:getMinHistory(farmId, currentHistories)
  end

  local dayId = nil
  local periodId = nil
  local year = nil
  local currentValue = nil
  if (minHistory ~= nil) then
      day = minHistory.dayId
      periodId = minHistory.periodId
      year = minHistory.year
      currentValue = minHistory.amount
  else
      day = g_currentMission.environment.currentMonotonicDay
      periodId = g_currentMission.environment.currentPeriod
      year = g_currentMission.environment.currentYear
      currentValue = NWT_netWorthCalcUtil:getFarmValue(farmId)
  end

  -- reasonable steps, not to any target
  local valueStep = currentValue / ((year * 12) + periodId)

  -- start on previous day
  day = day - 1
  periodId = periodId - 1
  if (periodId < 0) then
      year = year - 1
      periodId = 11
  end

  while (year >= 0 and day >= 0) do
      local value = valueStep * ((year * 12) + periodId)
      local history = NWT_history.new(g_currentMission:getIsServer(), g_currentMission:getIsClient())
      history:init(farmId, day, periodId, 1, year, g_nwt_historyManager.categories.Total, value)
      history:register()
      table.insert(g_nwt_historyManager.histories, history)
      print("Adding History Record:" .. tostring(history))
      print("   " .. tostring(day) .. ", ".. tostring(periodId) .. ", " .. tostring(year) .. ", " .. tostring(value))

      day = day - 1
      periodId = periodId - 1
      if (periodId == -1) then
          year = year - 1
          periodId = 11
      end
  end

end

function NWT_Console:toggleDebug()
    NWT_netWorthTracker.debug = not NWT_netWorthTracker.debug
    print("NWT_netWorthTracker.debug=" .. tostring(NWT_netWorthTracker.debug))
    return NWT_netWorthTracker.debug
end

function NWT_Console:getFarmValue(farmId)
    farmId = farmId or g_farmManager:getFarmByUserId(g_currentMission.playerUserId).farmId
    local value = NWT_netWorthCalcUtil:getFarmValue(farmId)
    print("Value : " .. tostring(value))
    return value
end

---
--- End Console Commands
---

function NWT_Console:getMinHistory(farmId, currentHistories)
    local minHistory = nil
    for _, history in ipairs(currentHistories) do
        if (history.farmId == farmId
            and (minHistory == nil or history.dayId < minHistory.dayId)) then
            minHistory = history
        end
    end
    return minHistory
end

if g_nwt_console then
   g_nwt_console:delete()
end

g_nwt_console = NWT_Console.new()
NWT_Console:init()
