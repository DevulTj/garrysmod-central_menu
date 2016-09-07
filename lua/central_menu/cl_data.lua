cm.data = cm.data or {}

cm.data.playerData = cm.data.playerData or {}
cm.data.stored = cm.data.stored or {}

cm.data.folderName = "cm"
cm.data.fileName = "configuration.txt"

local function saveData()
    file.Write( cm.data.folderName .. "/" .. cm.data.fileName, util.TableToJSON( cm.data.playerData ) )
end

local function getAllData()
    return util.JSONToTable( file.Read( cm.data.folderName .. "/" .. cm.data.fileName, "DATA" ) or "[]" ) or {}
end

function cm.addConfig( var, val, description, callback, data )
    local oldCfg = cm.data.stored[ var ]

    cm.data.stored[ var ] = {
        data = data,
        value = oldCfg and oldCfg.value or val,
        default = val,
        description = description,
        callback = callback
    }
end

function cm.getData( var, fallbackVal )
    return cm.data.playerData[ var ] or fallbackVal
end

function cm.setData( var, val )
    cm.data.playerData[ var ] = val

    saveData()
end

cm.data.playerData = getAllData()
