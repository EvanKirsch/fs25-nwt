-- NWT_trackOverTimeDao
--
-- Data Access Object for tracking farm's net worth over time
--

NWT_trackOverTimeDoa = {}

function NWT_trackOverTimeDoa:loadFromXMLFile(xmlFileName)
  print("--- NWT TODO loadFromXMLFile---")
end

function NWT_trackOverTimeDoa:saveObjectToXMLFile(valueAtPeriod, xmlFileName)
  print("--- NWT TODO saveToXMLFile---")
  DebugUtil.printTableRecursively(valueAtPeriod)
end
