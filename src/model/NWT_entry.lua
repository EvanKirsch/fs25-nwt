-- NWT_entry
--
-- Data object for table entry information
--

NWT_entry = {}
local NWT_entry_mt = Class(NWT_entry, Object)

InitObjectClass(NWT_entry, "NWT_entry")

function NWT_entry.new(isServer, isClient, customMt)
    local self = Object.new(isServer, isClient, customMt or NWT_entry_mt)

    return self
end

function NWT_entry:init(farmId, title, category, subCategory, details, amount)
    self.farmId = farmId
    self.entryTitle = title
    self.category = category
    self.subCategory = subCategory
    self.details = details
    self.entryAmount = amount
end

function NWT_entry:getCSVHeaders()
    return "tile" .. "," ..
        "category" .. "," ..
        "subCategory" .. "," ..
        "details" .. "," ..
        "amount"
end

function NWT_entry:toCSV() -- putting in quotes to escape possible commas
    return "\"" .. (self.entryTitle or "") .. "\"" .. "," ..
        "\"" .. (self.category or "") .. "\"" .. "," ..
        "\"" .. (self.subCategory or "") .. "\"" .. "," ..
        "\"" .. (self.details or "") .. "\"" .. "," ..
        (self.entryAmount or "")
end
