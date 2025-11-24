-- NWT_trackOverTimeDao
--
-- Data Access Object for tracking farm's net worth over time
--

NWT_trackOverTimeDoa = {}

function NWT_trackOverTimeDoa:loadFromXMLFile()
  print("--- NWT TODO loadFromXMLFile---")
end

function NWT_trackOverTimeDoa:saveToXMLFile()
  local savegameDir = g_currentMission.missionInfo.savegameDirectory
  local xmlPath = savegameDir.."/nwt_track_over_time.xml"
  local key = "value_over_time"
  local xmlFile = XMLFile.create("nwt_track_over_time", xmlPath, key)

  local periodFarmValues = g_nwt_trackOverTimeManager.periodFarmValues
  --DebugUtil.printTableRecursively(periodFarmValues)

  for _, valueAtPeriod in periodFarmValues do
    local valueKey = key
      .."."..tostring(valueAtPeriod.farmId)
      .."_"..tostring(valueAtPeriod.periodId)
      .."_"..valueAtPeriod.category

    xmlFile:setInt(valueKey.."#farmId", valueAtPeriod.farmId)
    xmlFile:setInt(valueKey.."#periodId", valueAtPeriod.periodId)
    xmlFile:setString(valueKey.."#category", valueAtPeriod.category)
    xmlFile:setFloat(valueKey.."#amount", valueAtPeriod.amount)

  end

  xmlFile:save()
  xmlFile:delete()

end

function init()
    Mission00.loadItemsFinished = Utils.appendedFunction(Mission00.loadItemsFinished, NWT_trackOverTimeDoa.loadFromXMLFile)
    FSCareerMissionInfo.saveToXMLFile = Utils.appendedFunction(FSCareerMissionInfo.saveToXMLFile, NWT_trackOverTimeDoa.saveToXMLFile)
end

init()
