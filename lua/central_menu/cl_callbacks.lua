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

function cm.getCallback( data, frame )
    if not data then return end
    if not IsValid( frame ) then return end

    for var, callback in pairs( cm.dataChecks ) do
        if data[ var ] then callback( data, frame ) end
    end
end
