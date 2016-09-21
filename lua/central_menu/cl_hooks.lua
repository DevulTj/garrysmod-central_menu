--[[
    Central UI Menu
    Created by http://steamcommunity.com/id/Devul/ and http://steamcommunity.com/id/fruitwasp/
    Do not redistribute this software without permission from authors

    Developer information: {{ user_id }} : {{ script_id }} : {{ script_version_id }}
]]--

local allowedKeyBinds =
{
    gm_showhelp = "f1",
    gm_showteam = "f2",
    gm_showspare1 = "f3",
    gm_showspare2 = "f4",
}

hook.Add( "PlayerBindPress", "cm", function( client, bind, pressed )
    local key = allowedKeyBinds[ string.lower( bind ) ]
    if not key then return end

    local chosenKey = string.lower( cm.getUnEditableData( "menu_key", "F1" ) )
    if key ~= chosenKey then return end

    cm.toggleMenu()
    return true
end )
