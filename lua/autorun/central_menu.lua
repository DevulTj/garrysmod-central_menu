--[[
  Central UI Menu
  Created by http://steamcommunity.com/id/Devul/ and http://steamcommunity.com/id/fruitwasp/
  Do not redistribute this software without permission from authors

  Developer information: {{ user_id }} : {{ script_id }} : {{ script_version_id }}
]]--

cm = cm or {}

cm.dir = "central_menu"

function cm.Include( dir )
	if not dir then return end
	dir = ( cm.dir .. "/" .. dir ):lower( )

	if SERVER and dir:find( "sv_" ) then
		include( dir )
	elseif dir:find( "cl_" ) then
		if SERVER then
			AddCSLuaFile( dir )
		else
			include( dir )
		end
	elseif dir:find( "sh_" ) then
		AddCSLuaFile( dir )
		include( dir )
	end
end

cm.Include(  "cl_include.lua" )
