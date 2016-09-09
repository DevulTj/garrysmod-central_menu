cm.addUnEditableConfig( "menu_key", "F1" )
cm.addUnEditableConfig( "background_material_disabled", false )
cm.addUnEditableConfig( "background_material", "cm/gmod_background.jpg" )
cm.addUnEditableConfig( "element_title_force_uppercase", true )

cm.addUnEditableConfig( "can_edit_clientside_settings", true )

cm.addClientConfig( "theme_elements_color", Color( 255, 255, 255 ), "The theme's element's colour", nil, { category = "appearance" } )
cm.addClientConfig( "theme_elements_widget_color", Color( 255, 255, 255 ), "The theme's element's theme widget colour", nil, { category = "appearance" } )

cm.addClientConfig( "main_color", Color( 26, 28, 89 ), "The theme's main colour", nil, { category = "appearance" } )
cm.addClientConfig( "gradient_color", Color( 25, 25, 25 ), "The theme's gradient main colour", nil, { category = "appearance" } )
cm.addClientConfig( "fade_time", 0.5, "Fade time for animations within the theme", nil, { category = "appearance" } )
cm.addClientConfig( "element_pressed_fade_time", 0.5, "Fade time for when you press an element button", nil, { category = "appearance" } )

cm.addClientConfig( "font", "Roboto", "The theme's font", function( _, newFont )
		hook.Run( "LoadFonts", newFont )
end, { category = "appearance" } )

cm.addClientConfig( "element_button_color", Color( 255, 255, 255 ), "Button colour within the theme", nil, { category = "element button appearance" } )
cm.addClientConfig( "element_button_disabled_color", Color( 125, 125, 125 ), "Disabled button colour within the theme", nil, { category = "element button appearance" } )
cm.addClientConfig( "element_button_hover_color", Color( 235, 235, 235 ), "Hovered button colour within the theme", nil, { category = "element button appearance" } )
cm.addClientConfig( "element_button_down_color", Color( 215, 215, 215 ), "Pressed down button colour within the theme", nil, { category = "element button appearance" } )

cm.addClientConfig( "button_text_color", Color( 255, 255, 255 ), "Text colour within the theme", nil, { category = "button appearance" } )
cm.addClientConfig( "button_text_color_inverted", Color( 0, 0, 0 ), "Inverted text color within the theme", nil, { category = "button appearance" } )
cm.addClientConfig( "button_bg_color", Color( 255, 255, 255 ), "Button background color within the theme", nil, { category = "button appearance" } )

cm.addClientConfig( "ask_on_close", true, "Whether to ask to close the frame when you press the close button", nil, { category = "general configuration" } )

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
