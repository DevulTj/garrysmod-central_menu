hook.Add( "LoadFonts" , "fonts", function()
	local fontFace = cm.getData( "font", "Roboto" )
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
end)

hook.Run( "LoadFonts" )

local blur = Material( "pp/blurscreen" )
function cm.drawBlurAt( x, y, w, h, amount, passes )
	amount = amount or 5

	surface.SetMaterial(blur)
	surface.SetDrawColor(255, 255, 255)

	local scrW, scrH = ScrW(), ScrH()
	local x2, y2 = x / scrW, y / scrH
	local w2, h2 = (x + w) / scrW, (y + h) / scrH

	for i = -(passes or 0.2), 1, 0.2 do
		blur:SetFloat("$blur", i * amount)
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRectUV(x, y, w, h, x2, y2, w2, h2)
	end
end
