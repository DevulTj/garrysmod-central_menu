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

function cm.addClientConfig( var, val, description, callback, data )
    local oldCfg = cm.data.stored[ var ]

    cm.data.stored[ var ] = {
        data = data,
        value = oldCfg and oldCfg.value or val,
        default = val,
        description = description,
        callback = callback
    }
end

function cm.addUnEditableConfig( var, val )
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
