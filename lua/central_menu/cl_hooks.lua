--[[
  Central UI Menu
  Created by http://steamcommunity.com/id/Devul/ and http://steamcommunity.com/id/fruitwasp/
  Do not redistribute this software without permission from authors

  Developer information: {{ user_id }} : {{ script_id }} : {{ script_version_id }}
]]--

local FKeyToHook = {
    ["F1"] = "ShowHelp",
    ["F2"] = "ShowTeam",
    ["F3"] = "ShowSpare",
    ["F4"] = "ShowSpare2"
}

hook.Add( FKeyToHook[ cm.getUnEditableData( "menu_key", "F1" ) ] or "", "cm", function()
    if not cm.frame or not cm.frame:IsVisible() or not cm.frame.background.reverseFade then
		cm.create()
	else
		cm.close()
	end
end )
