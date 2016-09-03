cm.config = cm.config or {}

cm.config.MENU_KEY = "F1"

cm.config.COMMUNITY_NAME = "My Community"
cm.config.COMMUNITY_FORUMS_URL = "https://google.nl"
cm.config.COMMUNITY_RULES_URL = "https://google.co.uk"

cm.config.MAIN_COLOR = Color( 255, 75, 75 )
cm.config.GRADIENT_COLOR = Color( 0, 0, 0, 255 )
cm.config.BACKGROUND_COLOR_INCREMENTS = 0.008

cm.config.FADE_TIME = 0.5

cm.config.STYLE = {
    FONT_FACE = "Roboto",

    BUTTON_COLOR = Color( 255, 255, 255 ),
    BUTTON_DISABLED_COLOR = Color( 125, 125, 125 ),
    BUTTON_HOVER_COLOR = Color( 235, 235, 235 ),
    BUTTON_DOWN_COLOR = Color( 215, 215, 215 ),
}

cm.config.ELEMENTS = {
    {
        name = "HOME",
        callback = function( panel )
            local time = os.time()
            local day = os.date( "%A", time )

            local label = panel:Add( "DLabel" )
            label:SetText( "Happy " .. day .. " " .. LocalPlayer():Nick() .. "." )
            label:SetFont( "cmLargeThin" )
            label:SetTextColor( color_white )
            label:SetContentAlignment( 5 )
            label:SetHeight( 20 )
            label:SizeToContents()
        end
    },
    {
        name = "FORUMS",
        showURL = cm.config.COMMUNITY_FORUMS_URL
    },
    {
        name = "STAFF",
        callback = function( panel ) end,
        customCheck = function( client, panel ) return false end,
    },
    {
        name = "RULES",
        showURL = cm.config.COMMUNITY_RULES_URL
    },
}
