--[[
Central UI Menu
Created by http://steamcommunity.com/id/Devul/ and http://steamcommunity.com/id/fruitwasp/
Do not redistribute this software without permission from authors

Developer information: {{ user_id }} : {{ script_id }} : {{ script_version_id }}
]]--

--[[
	If you bind the menu_key to F1, make sure you've disabled the default DarkRP f1 help menu:

	1. open `darkrpmodification/lua/darkrp_config/disabled_defaults.lua`
	2. find the `DarkRP.disabledDefaults["modules"]` table
	3. disable the f1menu module by setting the config to `true`
]]

cm.registerUneditableConfig( "menu_key", "F1" ) -- Available hotkeys (F1, F2, F3, F4)
cm.registerUneditableConfig( "background_material_disabled", false ) -- Disables material background image and uses main_color client configuration
cm.registerClientConfig( "background_material", { "cm/gmod_background.jpg" }, "The background of Central Menu", nil, { category = "appearance" } ) -- Material background path, make sure you FastDL/Workshop it
cm.registerUneditableConfig( "element_title_force_uppercase", true ) -- Forces element button titles to be in UPPERCASE or not
cm.registerUneditableConfig( "can_edit_clientside_settings", true ) -- Enforces the ability to set clientside customization
cm.registerUneditableConfig( "show_avatar", true ) -- Show avatar button

cm.registerClientConfig( "theme_elements_color", Color( 255, 255, 255 ), "The theme's element's colour", nil, { category = "appearance" } )
cm.registerClientConfig( "theme_elements_widget_color", Color( 255, 255, 255 ), "The theme's element's theme widget colour", nil, { category = "appearance" } )
cm.registerClientConfig( "main_color", Color( 26, 28, 89 ), "The theme's main colour", nil, { category = "appearance" } )
cm.registerClientConfig( "gradient_color", Color( 25, 25, 25 ), "The theme's gradient main colour", nil, { category = "appearance" } )
cm.registerClientConfig( "fade_time", 0.5, "Fade time for animations within the theme", nil, { category = "appearance" } )
cm.registerClientConfig( "element_pressed_fade_time", 0.5, "Fade time for when you press an element button", nil, { category = "appearance" } )

cm.registerClientConfig( "font", "Futura ICG", "The theme's font", function( _, newFont )
	hook.Call( "loadFonts", nil, newFont )
end, { category = "appearance" } )

cm.registerClientConfig( "element_button_color", Color( 255, 255, 255 ), "Button colour within the theme", nil, { category = "element button appearance" } )
cm.registerClientConfig( "element_button_disabled_color", Color( 125, 125, 125 ), "Disabled button colour within the theme", nil, { category = "element button appearance" } )
cm.registerClientConfig( "element_button_hover_color", Color( 235, 235, 235 ), "Hovered button colour within the theme", nil, { category = "element button appearance" } )
cm.registerClientConfig( "element_button_down_color", Color( 215, 215, 215 ), "Pressed down button colour within the theme", nil, { category = "element button appearance" } )

cm.registerClientConfig( "button_text_color", Color( 255, 255, 255 ), "Text colour within the theme", nil, { category = "button appearance" } )
cm.registerClientConfig( "button_text_color_inverted", Color( 0, 0, 0 ), "Inverted text color within the theme", nil, { category = "button appearance" } )
cm.registerClientConfig( "button_bg_color", Color( 255, 255, 255 ), "Button background color within the theme", nil, { category = "button appearance" } )

cm.registerClientConfig( "ask_on_close", true, "Whether to ask to close the frame when you press the close button", nil, { category = "general configuration" } )

cm.registerClientConfig( "auto_open_on_join", true, "Whether Central Menu should auto-open on join", nil, { category = "general configuration" } )

cm.registerElement( "HOME", {
	showGreeting = true,
	text = [[Text with multi line support. You can modify this through the server configuration files.]]
})

cm.registerElement( "FORUMS", {
	showURL = "https://facepunch.com/"
})

cm.registerElement( "STAFF", {
	--customCheck = function( client, panel ) return client:IsAdmin() or client:IsSuperAdmin() end,

	staff = {
		[ "admin" ] = Color( 255, 255, 255 ),
		[ "superadmin" ] = Color( 51, 125, 255 ),
		[ "owner" ] = Color( 235, 51, 51 )
	}
})

cm.registerElement( "SERVERS", {
	servers = {
		[ "DARKRP" ] = {
			icon = Material( "cm/server_icon.png" ),
			ip = "127.0.0.1",
			desc = "One of our servers.",

			joinText = "JOIN"
		},
		[ "TTT" ] = {
			icon = Material( "cm/server_icon_2.png" ),
			ip = "127.0.0.1",
			desc = "Another one of our servers.",

			joinText = "JOIN"
		}
	}
})

cm.registerElement( "RULES", {
	showURL = "https://google.co.uk"
})
