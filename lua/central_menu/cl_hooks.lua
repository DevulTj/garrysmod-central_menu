local FKeyToHook = {
    ["F1"] = "ShowHelp",
    ["F2"] = "ShowTeam",
    ["F3"] = "ShowSpare",
    ["F4"] = "ShowSpare2"
}

hook.Add( FKeyToHook[ cm.config.MENU_KEY ] or "", "cm", function()
    if not cm.frame or not cm.frame:IsVisible() or not cm.frame.background.reverseFade then
		cm.create()
	else
		cm.close()
	end
end )
