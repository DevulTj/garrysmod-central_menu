cm.config.MENU_KEY = "F1"

cm.config.COMMUNITY_NAME = "My Community"
cm.config.COMMUNITY_FORUMS_URL = "https://google.nl"
cm.config.COMMUNITY_RULES_URL = "https://google.co.uk"

cm.config.BACKGROUND_MATERIAL_DISABLED = false
cm.config.BACKGROUND_MATERIAL = Material( "cm/gmod_background.jpg" )

cm.addConfig( "main_color", Color( 26, 28, 89 ), "The theme's main colour", nil, { category = "appearance" } )
cm.addConfig( "gradient_color", Color( 25, 25, 25 ), "The theme's gradient main colour", nil, { category = "appearance" } )
cm.addConfig( "fade_time", 0.5, "Fade time for animations within the theme", nil, { category = "appearance" } )
cm.addConfig( "element_pressed_fade_time", 0.5, "Fade time for when you press an element button", nil, { category = "appearance" } )

cm.addConfig( "font", "Roboto", "The theme's font", function( _, newFont )
		hook.Run( "LoadFonts", newFont )
end, { category = "appearance" } )

cm.addConfig( "button_color", Color( 255, 255, 255 ), "Button colour within the theme", nil, { category = "button appearance" } )
cm.addConfig( "button_disabled_color", Color( 125, 125, 125 ), "Disabled button colour within the theme", nil, { category = "button appearance" } )
cm.addConfig( "button_hover_color", Color( 235, 235, 235 ), "Hovered button colour within the theme", nil, { category = "button appearance" } )
cm.addConfig( "button_down_color", Color( 215, 215, 215 ), "Pressed down button colour within the theme", nil, { category = "button appearance" } )

cm.registerElement( "HOME", {
    showGreeting = true
})

cm.registerElement( "FORUMS", {
    showURL = cm.config.COMMUNITY_FORUMS_URL
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

cm.registerElement( "STAFF", {
    showURL = cm.config.COMMUNITY_RULES_URL
})
