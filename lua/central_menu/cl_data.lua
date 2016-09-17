--[[
  Central UI Menu
  Created by http://steamcommunity.com/id/Devul/ and http://steamcommunity.com/id/fruitwasp/
  Do not redistribute this software without permission from authors

  Developer information: {{ user_id }} : {{ script_id }} : {{ script_version_id }}
]]--

cm.data = cm.data or {}

cm.data.playerData = cm.data.playerData or {}
cm.data.stored = cm.data.stored or {}

cm.data.unEditableConfig = cm.data.unEditableConfig or {}

cm.data.folderName = "cm"
cm.data.fileName = "configuration.txt"

local function saveData()
    file.Write( cm.data.folderName .. "/" .. cm.data.fileName, util.TableToJSON( cm.data.playerData ) )
end

local function getAllData()
    return util.JSONToTable( file.Read( cm.data.folderName .. "/" .. cm.data.fileName, "DATA" ) or "[]" ) or {}
end

function cm.registerClientConfig( var, val, description, callback, data )
    local oldCfg = cm.data.stored[ var ]

    cm.data.stored[ var ] = {
        data = data,
        value = oldCfg and oldCfg.value or val,
        default = val,
        description = description,
        callback = callback
    }
end

function cm.registerUneditableConfig( var, val )
    cm.data.unEditableConfig[ var ] = val
end

function cm.getUnEditableData( var, fallbackVal )
    return cm.data.unEditableConfig[ var ] or fallbackVal
end

function cm.getClientData( var, fallbackVal )
    return cm.data.playerData[ var ] or fallbackVal
end

function cm.setClientData( var, val )
    cm.data.playerData[ var ] = val

    saveData()
end

cm.data.playerData = getAllData()

--[[----------------------------------------
    ELEMENTS SETUP
------------------------------------------]]

cm.config = cm.config or {}
cm.config.ELEMENTS = {}

cm.registerElement = function( name, data )
    data = data or {}
    data.name = name

    return table.insert( cm.config.ELEMENTS, data )
end
