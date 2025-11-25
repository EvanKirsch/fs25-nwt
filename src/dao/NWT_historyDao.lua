-- NWT_historyDao
--
-- Data Access Object for tracking farm's net worth history
--

NWT_historyDao = {}
NWT_historyDao.KEY = "history"

function NWT_historyDao:loadFromXMLFile()
  local savegameDir = g_currentMission.missionInfo.savegameDirectory
  local xmlPath = savegameDir.."/nwt_history.xml"
  local xmlFile = XMLFile.loadIfExists("nwt_history", xmlPath, NWT_historyDao.KEY)

  if xmlFile ~= nil then
    -- g_farmManager.getFarms() - NPEs, I assume it is not fully loaded
    -- g_farmManager.farmIdToFarm - the ids are wrong?
    -- TODO - figure out how to get farmIds?
    for farmIdIndex = 0, 16 do
      for dayIndex = 0, g_currentMission.environment.currentDay do

        local valueKey = NWT_historyDao.KEY
          ..string.format(".farm(%d)", farmIdIndex)
          ..string.format(".day(%d)", dayIndex)

        if xmlFile:hasProperty(valueKey) then
          local farmId = xmlFile:getInt(valueKey.."#farmId")
          local dayId = xmlFile:getInt(valueKey.."#dayId")
          local category = xmlFile:getString(valueKey.."#category")
          local amount = xmlFile:getFloat(valueKey.."#amount")

          if farmId ~= nil
           and dayId ~= nil
           and category ~= nil
           and amount ~= nil then
            local valueHistory = NWT_history.new(g_currentMission:getIsServer(), g_currentMission:getIsClient())
            valueHistory:init(farmId, dayId, category, amount)
            valueHistory:register()

            table.insert(g_nwt_historyManager.histories, valueHistory)

          end
        end

      end
    end

    xmlFile:delete()

  end

  -- DebugUtil.printTableRecursively(g_nwt_historyManager.histories)

end

function NWT_historyDao:saveToXMLFile()
  local savegameDir = g_currentMission.missionInfo.savegameDirectory
  local xmlPath = savegameDir.."/nwt_history.xml"
  local xmlFile = XMLFile.create("nwt_history", xmlPath, NWT_historyDao.KEY)

  -- DebugUtil.printTableRecursively(g_nwt_historyManager.histories)

  for _, history in g_nwt_historyManager.histories do
    local valueKey = NWT_historyDao.KEY
      ..string.format(".farm(%d)", history.farmId)
      ..string.format(".day(%d)", history.dayId)

    xmlFile:setInt(valueKey.."#farmId", history.farmId)
    xmlFile:setInt(valueKey.."#dayId", history.dayId)
    xmlFile:setString(valueKey.."#category", history.category)
    xmlFile:setFloat(valueKey.."#amount", history.amount)

  end

  xmlFile:save()
  xmlFile:delete()

end

function init()
    Mission00.loadItemsFinished = Utils.appendedFunction(Mission00.loadItemsFinished, NWT_historyDao.loadFromXMLFile)
    FSCareerMissionInfo.saveToXMLFile = Utils.appendedFunction(FSCareerMissionInfo.saveToXMLFile, NWT_historyDao.saveToXMLFile)
end

init()
