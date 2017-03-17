--[[
    Central UI Menu
    Created by http://steamcommunity.com/id/Devul/ and http://steamcommunity.com/id/fruitwasp/
    Do not redistribute this software without permission from authors

    Developer information: {{ user_id }} : {{ script_id }} : {{ script_version_id }}
]]--

hook.Add( "PlayerButtonUp", "dThirdPerson_keyBind", function( player, buttonId )
	if not IsFirstTimePredicted() then return end
	if player ~= LocalPlayer() then return end
	if gui.IsGameUIVisible() then return end
	if player:IsTyping() then return end

    local chosenKey = cm.getUnEditableData( "menu_key", KEY_F1 )
    if buttonId ~= chosenKey then return end

    cm.toggleMenu()
end )

if cm.getClientData( "auto_open_on_join", true ) then
    hook.Add( "InitPostEntity", "centralMenu", cm.toggleMenu )
end
