require("lualibs.lua")

function getJsonFromFile(file)
  local fileHandle = io.open(file)
  local jsonString = fileHandle:read('*a')
  fileHandle.close()
  local jsonData = utilities.json.tolua(jsonString)
  return jsonData
end

function printEduItems(file)
  local json = getJsonFromFile(file)
  for key, value in pairs(json) do
    tex.print("\\resumeEduEntry")
    tex.print("{" .. value["school"] .. "}")
    tex.print("{" .. value["school_location"] .. "}")
    tex.print("{" .. value["degree"] .. "}")
    tex.print("{" .. value["time_period"] .. "}")
  end
end

function printExpItems(file)
  local json = getJsonFromFile(file)
  for key, value in pairs(json) do
    tex.print("\\resumeExpEntry")
    tex.print("{" .. value["company"] .. "}")
    tex.print("{" .. value["company_location"] .. "}")
    tex.print("{" .. value["role"] .. "}")
    tex.print("{" .. value["team"] .. "}")
    tex.print("{" .. value["time_duration"] .. "}")

    tex.print("\\resumeItemListStart")
    for key, value in pairs(value["details"]) do
      tex.print("\\resumeItem")
      tex.print("{" .. value["title"] .. "}")
      tex.print("{" .. value["description"] .. "}")
      tex.print("{" .. value["languages"] .. "}")
    end
    tex.print("\\resumeItemListEnd")
  end
end

function printProjItems(file)
  local json = getJsonFromFile(file)
  for key, value in pairs(json) do
    tex.print("\\resumeSubItem")
    tex.print("{" .. value["title"] .. "}")
    tex.print("{" .. value["description"] .. "}")
    tex.print("{" .. value["languages"] .. "}")
  end
end

function printHeading(file)
  local json = getJsonFromFile(file)
  for key, value in pairs(json) do
    tex.print("\\begin{tabular*}{\\textwidth}{l@{\\extracolsep{\\fill}}r}")

    tex.print("\\textbf{\\href")
    tex.print("{" .. value["website"] .. "/}")
    tex.print("{\\Large " .. value["name"] .. "}}")
    tex.print(" & Email: \\href")
    tex.print("{mailto:" .. value["email"] .. "}")
    tex.print("{" .. value["email"] .. "}\\\\")

    tex.print("\\href")
    tex.print("{" .. value["website"] .. "/}")
    tex.print("{" .. value["website"] .. "}")
    tex.print(" & Phone: " .. value["phone"] .. "\\\\")

    tex.print("\\end{tabular*}")
  end
end

function printList(file, primary, secondary)
  local json = getJsonFromFile(file)
  local first = true
  for key, value in pairs(json) do
    for key, value in pairs(value[primary]) do
      if (first) then
        tex.print(value[secondary])
        first = false
      else
        tex.print(", " .. value[secondary])
      end
    end
  end
end
