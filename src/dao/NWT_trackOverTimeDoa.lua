-- NWT_trackOverTimeDao
--
-- Data Access Object for tracking farm's net worth over time
--

NWT_trackOverTimeDoa = {}

function NWT_trackOverTimeDoa:loadFromXMLFile()
  print("--- NWT TODO loadFromXMLFile---")
end

function NWT_trackOverTimeDoa:saveObjectToXMLFile(valueAtPeriod)
  print("--- NWT TODO saveToXMLFile---")
  DebugUtil.printTableRecursively(valueAtPeriod)
  local savegameDir = g_currentMission.missionInfo.savegameDirectory
  local xmlPath = savegameDir.."/nwt_track_over_time.xml"
  local key = tostring(valueAtPeriod.farmId)
    .."_"..tostring(valueAtPeriod.periodId)
    .."_"..valueAtPeriod.category
  local xmlFile = XMLFile.create("nwt_track_over_time", xmlPath, key)

  xmlFile:setInt(key.."#farmId", valueAtPeriod.farmId)
  xmlFile:setInt(key.."#periodId", valueAtPeriod.periodId)
  xmlFile:setString(key.."#category", valueAtPeriod.category)
  xmlFile:setFloat(key.."#amount", valueAtPeriod.amount)
  print("--- NWT Done saveToXMLFile---")
  xmlFile:save()
  xmlFile:delete()

end
