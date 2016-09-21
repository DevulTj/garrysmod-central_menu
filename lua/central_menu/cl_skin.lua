--[[
  Central UI Menu
  Created by http://steamcommunity.com/id/Devul/ and http://steamcommunity.com/id/fruitwasp/
  Do not redistribute this software without permission from authors

  Developer information: {{ user_id }} : {{ script_id }} : {{ script_version_id }}
]]--

hook.Add( "loadFonts" , "fonts", function()
	local fontFace = cm.getClientData( "font", "Roboto" )

	surface.CreateFont( "cmLarge", {
		font = fontFace,
		size = 32,
		weight = 500,
		antialias = true
	} )

	surface.CreateFont( "cmLargeThin", {
		font = fontFace,
		size = 30,
		weight = 0,
		antialias = true
	} )

	surface.CreateFont( "cmMedium", {
		font = fontFace,
		size = 24,
		weight = 500,
		antialias = true
	} )

	surface.CreateFont( "cmSmall", {
		font = fontFace,
		size = 16,
		weight = 500,
		antialias = true
	} )
end )

hook.Call( "loadFonts" )

local blur = Material( "pp/blurscreen" )
function cm.drawBlurAt( x, y, w, h, amount, passes )
	amount = amount or 4

	surface.SetMaterial( blur )
	surface.SetDrawColor( color_white )

	local scrW, scrH = ScrW(), ScrH()
	local _x, _y = x / scrW, y / scrH
	local _w, _h = ( x + w ) / scrW, ( y + h ) / scrH

	for i = - passes or 0.15, 1, 0.15 do
		blur:SetFloat( "$blur", i * amount )
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRectUV( x, y, w, h, _x, _y, _w, _h )
	end
end
