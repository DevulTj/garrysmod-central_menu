cm.config.MENU_KEY = "F1"

cm.config.COMMUNITY_NAME = "My Community"
cm.config.COMMUNITY_FORUMS_URL = "https://google.nl"
cm.config.COMMUNITY_RULES_URL = "https://google.co.uk"

cm.config.BACKGROUND_MATERIAL_DISABLED = false
cm.config.BACKGROUND_MATERIAL = Material( "cm/gmod_background.jpg" )

cm.config.MAIN_COLOR = Color( 26, 28, 89 )
cm.config.GRADIENT_COLOR = Color( 25, 25, 25 )
cm.config.BACKGROUND_COLOR_INCREMENTS = 0.008

cm.config.FADE_TIME = 0.5

cm.config.STYLE = {
    FONT_FACE = "Roboto",

    BUTTON_COLOR = Color( 255, 255, 255 ),
    BUTTON_DISABLED_COLOR = Color( 125, 125, 125 ),
    BUTTON_HOVER_COLOR = Color( 235, 235, 235 ),
    BUTTON_DOWN_COLOR = Color( 215, 215, 215 ),
}

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
