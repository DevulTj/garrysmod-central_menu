--[[
  Central UI Menu
  Created by http://steamcommunity.com/id/Devul/ and http://steamcommunity.com/id/fruitwasp/
  Do not redistribute this software without permission from authors

  Developer information: {{ user_id }} : {{ script_id }} : {{ script_version_id }}
]]--

cm.dataChecks = {}

function cm.addDataCheck( varToCheck, callback )
    cm.dataChecks[ varToCheck ] = callback
end

cm.addDataCheck( "showURL", function( data, frame )
    local html = frame.panel:Add( "HTML" )
    html:Dock( FILL )
    html:OpenURL( data.showURL )
end )

cm.addDataCheck( "text", function( data, frame )
    local label = frame.panel:Add( "DLabel" )
    label:Dock( FILL )
    label:SetText( data.text or "" )
    label:SetFont( "cmMedium" )
    label:SetTextColor( color_white )
    label:SetContentAlignment( 7 )
    label:SetExpensiveShadow( 1, Color( 0, 0, 0, 185 ) )
end )

cm.addDataCheck( "callback", function( data, frame )
    if data.callback then data.callback( frame.panel ) end
end )

cm.addDataCheck( "staff", function( data, frame )
    local staffGroups = data.staff
    if not staffGroups then return end

    local scroll = frame.panel:Add( "DScrollPanel" )
    scroll:Dock( FILL )

    local layout = scroll:Add( "DIconLayout" )
    layout:Dock( FILL )

    layout:SetSpaceX( 4 )
    layout:SetSpaceY( 4 )

    local groupUsers = {}
    for Id, client in ipairs( player.GetAll() ) do
        local usergroup = client:GetUserGroup()
        if not staffGroups[ usergroup ] then continue end

        if not groupUsers[ usergroup ] then groupUsers[ usergroup ] = {} end
        groupUsers[ usergroup ][ Id ] = client
    end

    for userGroup, clients in SortedPairs( groupUsers ) do
        local _layout = layout:Add( "DIconLayout" )
        _layout:Dock( TOP )
        _layout:DockMargin( 0, 0, 0, 4 )
        _layout:SetTall( 158 )

        _layout:SetSpaceX( 4 )
        _layout:SetSpaceY( 4 )

        local label = _layout:Add( "DLabel" )
        label:Dock( TOP )
        label:SetText( userGroup )
        label:SetFont( "cmMedium" )
        label:SetTextColor( staffGroups[ userGroup ] )
        label:SetExpensiveShadow( 1, Color( 0, 0, 0, 185 ) )

        for _, client in pairs( clients ) do
            local usergroup = client:GetUserGroup()
            if staffGroups[ usergroup ] then

                local avatar = _layout:Add( "AvatarImage" )
                avatar:SetSize( 128, 128 )
                avatar:Center()
                avatar:SetPlayer( client, 128 )

                local button = avatar:Add( "DButton" )
                button:SetSize( 128, 128 )
                button:SetText( client:Nick() )
                button:SetFont( "cmMedium" )
                button:SetContentAlignment( 2 )
                button:SetExpensiveShadow( 1, color_black )
                button:SetExpensiveShadow( 1, Color( 0, 0, 0, 185 ) )

                button.textCol = 255
                button.boxY = button:GetTall() / 2
                button.Paint = function( self, w, h )
                    local buttonColor = staffGroups[ usergroup ]

                    local hovered = self:IsHovered()

                    self.boxY = math.Clamp( hovered and ( self.boxY - 2 ) or ( self.boxY + 2 ), 0, self:GetTall() / 2 )
                    surface.SetDrawColor( Color( buttonColor.r, buttonColor.g, buttonColor.b, 75 ) )
                    surface.SetMaterial( Material( "vgui/gradient_up" ) )
                    surface.DrawTexturedRect( 0, self.boxY, w, h )

                    surface.SetDrawColor( Color( buttonColor.r, buttonColor.g, buttonColor.b, 255 ) )
                    surface.DrawOutlinedRect( 0, 0, w, h )

                    self:SetTextColor( color_white )
                end
            end
        end
    end
end )

cm.addDataCheck( "servers", function( data, frame )
    local servers = data.servers
    if not servers then return end

    local label = frame.panel:Add( "DLabel" )
    label:SetText( "Click one of the server buttons to connect to one of our servers!" )
    label:SetFont( "cmLargeThin" )
    label:SetTextColor( color_white )
    label:Dock( TOP )
    label:DockMargin( 0, 0, 0, 12 )
    label:SizeToContents()
    label:SetExpensiveShadow( 1, Color( 0, 0, 0, 185 ) )

    local layout = frame.panel:Add( "DIconLayout" )
    layout:Dock( FILL )
    layout:SetSpaceX( 4 )
    layout:SetSpaceY( 4 )

    for serverName, serverInfo in pairs( servers ) do
        local server = layout:Add( "centralMenuServerButton" )
        server:SetSize( 320, 256 )
        server:setText( serverName )
        server:setDesc( serverInfo.desc )
        server:setJoinText( serverInfo.joinText )
        server:setServerIcon( serverInfo.icon )
        server:setIP( serverInfo.ip )

        server:setUp()
    end
end )

local gradient = Material( "gui/gradient" )
cm.addDataCheck( "showGreeting", function( _, frame )
    local time = os.time()
    local day = os.date( "%A", time )

    local label = frame.panel:Add( "DLabel" )
    label:SetText( "Happy " .. day .. ", " .. LocalPlayer():Nick() .. "." )
    label:SetFont( "cmLargeThin" )
    label:SetTextColor( color_white )
    label:SetContentAlignment( 4 )
    label:Dock( TOP )
    label:DockMargin( 0, 0, 0, 4 )
    label:SetHeight( 20 )
    label:SizeToContents()
    label:SetExpensiveShadow( 1, Color( 0, 0, 0, 185 ) )

    local spacer = frame.panel:Add( "DPanel" )
    spacer:Dock( TOP )
    spacer:DockMargin( 0, 4, 0, 8 )
    spacer:SetHeight( 1 )

    local elementsCol = cm.getClientData( "theme_elements_color", color_white )
    spacer.Paint = function( _, w, h )
        surface.SetDrawColor( Color( elementsCol.r, elementsCol.g, elementsCol.b, 75 ) )
        surface.SetMaterial( gradient )
        surface.DrawTexturedRect( 0, 0, w / 2, h )
    end
end )

function cm.getCallback( data, frame )
    if not data then return end
    if not IsValid( frame ) then return end

    for var, callback in pairs( cm.dataChecks ) do
        if data[ var ] then callback( data, frame ) end
    end
end
