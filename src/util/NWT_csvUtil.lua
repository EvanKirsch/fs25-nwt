-- NWT_csvUtil
--
-- Used for CSV file IO
--

NWT_csvUtil = {}

function NWT_csvUtil:writeToFile(path, myTable)
    print("--- SOF ---")
    local file = io.open(path, "w")
    if #myTable > 0  then
        print(myTable[1]:getCSVHeaders())
        file:write(myTable[1]:getCSVHeaders(), "\n")
        for _, record in ipairs(myTable) do
            print(record:toCSV())
            file:write(record:toCSV(), "\n")
        end
    end
    file:close()
    print("-- EOF --")
end
