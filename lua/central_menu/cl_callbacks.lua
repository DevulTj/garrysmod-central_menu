cm.dataChecks = {}

function cm.addDataCheck( varToCheck, callback )
    cm.dataChecks[ varToCheck ] = callback
end

cm.addDataCheck( "showURL", function( data, frame )
    local html = frame.panel:Add( "HTML" )
    html:Dock( FILL )
    html:OpenURL( data.showURL )
end )

cm.addDataCheck( "callback", function( data, frame )
    if data.callback then data.callback( frame.panel ) end
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

    local layout = frame.panel:Add( "DIconLayout" )
    layout:Dock( FILL )
    layout:SetSpaceX( 4 )
    layout:SetSpaceY( 4 )

    for serverName, data in pairs( servers ) do
        local server = layout:Add( "centralMenuServerButton" )
        server:SetSize( 320, 256 )
        server:setText( serverName )
        server:setDesc( data.desc )
        server:setJoinText( data.joinText )
        server:setServerIcon( data.icon )

        server:setUp()
    end
end )

cm.addDataCheck( "showGreeting", function( data, frame )
    local time = os.time()
    local day = os.date( "%A", time )

    local label = frame.panel:Add( "DLabel" )
    label:SetText( "Happy " .. day .. " " .. LocalPlayer():Nick() .. "." )
    label:SetFont( "cmLargeThin" )
    label:SetTextColor( color_white )
    label:SetContentAlignment( 5 )
    label:SetHeight( 20 )
    label:SizeToContents()
end )

function cm.getCallback( data, frame )
    if not data then return end
    if not IsValid( frame ) then return end

    for var, callback in pairs( cm.dataChecks ) do
        if data[ var ] then callback( data, frame ) end
    end
end
