--[[
  Central UI Menu
  Created by http://steamcommunity.com/id/Devul/ and http://steamcommunity.com/id/fruitwasp/
  Do not redistribute this software without permission from authors

  Developer information: {{ user_id }} : {{ script_id }} : {{ script_version_id }}
]]--

local FBinds = {
    ["gm_showhelp"] = "ShowHelp",
    ["gm_showteam"] = "ShowTeam",
    ["gm_showspare1"] = "ShowSpare1",
    ["gm_showspare2"] = "ShowSpare2"
}

local FKeyToHook = {
    ["F1"] = "ShowHelp",
    ["F2"] = "ShowTeam",
    ["F3"] = "ShowSpare",
    ["F4"] = "ShowSpare2"
}

hook.Add( "PlayerBindPress", "cm", function( client, bind, pressed )
    local _bind = string.match( string.lower( bind ), "gm_[a-z]+[12]?" )
    if _bind and FBinds[ _bind ] then
        hook.Call( FBinds[ _bind ], gmod.GetGamemode() )
    end
end )

hook.Add( FKeyToHook[ cm.getUnEditableData( "menu_key", "F1" ) ] or "", "cm", function()
    if not cm.frame or not cm.frame:IsVisible() or not cm.frame.background.reverseFade then
		cm.create()
	else
		cm.close()
	end
end )
