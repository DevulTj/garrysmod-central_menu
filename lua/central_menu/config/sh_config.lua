cm.registerUneditableConfig( "menu_key", "F1" )
cm.registerUneditableConfig( "background_material_disabled", false )
cm.registerUneditableConfig( "background_material", "cm/gmod_background.jpg" )
cm.registerUneditableConfig( "element_title_force_uppercase", true )
cm.registerUneditableConfig( "can_edit_clientside_settings", true )

cm.registerClientConfig( "theme_elements_color", Color( 255, 255, 255 ), "The theme's element's colour", nil, { category = "appearance" } )
cm.registerClientConfig( "theme_elements_widget_color", Color( 255, 255, 255 ), "The theme's element's theme widget colour", nil, { category = "appearance" } )
cm.registerClientConfig( "main_color", Color( 26, 28, 89 ), "The theme's main colour", nil, { category = "appearance" } )
cm.registerClientConfig( "gradient_color", Color( 25, 25, 25 ), "The theme's gradient main colour", nil, { category = "appearance" } )
cm.registerClientConfig( "fade_time", 0.5, "Fade time for animations within the theme", nil, { category = "appearance" } )
cm.registerClientConfig( "element_pressed_fade_time", 0.5, "Fade time for when you press an element button", nil, { category = "appearance" } )

cm.registerClientConfig( "font", "Roboto", "The theme's font", function( _, newFont )
		hook.Run( "LoadFonts", newFont )
end, { category = "appearance" } )

cm.registerClientConfig( "element_button_color", Color( 255, 255, 255 ), "Button colour within the theme", nil, { category = "element button appearance" } )
cm.registerClientConfig( "element_button_disabled_color", Color( 125, 125, 125 ), "Disabled button colour within the theme", nil, { category = "element button appearance" } )
cm.registerClientConfig( "element_button_hover_color", Color( 235, 235, 235 ), "Hovered button colour within the theme", nil, { category = "element button appearance" } )
cm.registerClientConfig( "element_button_down_color", Color( 215, 215, 215 ), "Pressed down button colour within the theme", nil, { category = "element button appearance" } )

cm.registerClientConfig( "button_text_color", Color( 255, 255, 255 ), "Text colour within the theme", nil, { category = "button appearance" } )
cm.registerClientConfig( "button_text_color_inverted", Color( 0, 0, 0 ), "Inverted text color within the theme", nil, { category = "button appearance" } )
cm.registerClientConfig( "button_bg_color", Color( 255, 255, 255 ), "Button background color within the theme", nil, { category = "button appearance" } )

cm.registerClientConfig( "ask_on_close", true, "Whether to ask to close the frame when you press the close button", nil, { category = "general configuration" } )

cm.registerElement( "HOME", {
    showGreeting = true
})

cm.registerElement( "FORUMS", {
    showURL = "https://google.nl"
})

cm.registerElement( "STAFF", {
    customCheck = function( client, panel ) return client:IsAdmin() or client:IsSuperAdmin() end,
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
