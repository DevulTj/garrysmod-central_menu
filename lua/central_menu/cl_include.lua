--[[
  Central UI Menu
  Created by http://steamcommunity.com/id/Devul/ and http://steamcommunity.com/id/fruitwasp/
  Do not redistribute this software without permission from authors

  Developer information: {{ user_id }} : {{ script_id }} : {{ script_version_id }}
]]--

cm.config = cm.config or {}
cm.config.ELEMENTS = {}

cm.registerElement = function( name, data )
    data = data or {}
    data.name = cm.config.ELEMENT_TITLE_FORCE_UPPERCASE and string.upper( name ) or name

    return table.insert( cm.config.ELEMENTS, data )
end

cm.Include( "cl_data.lua" )
cm.Include( "config/sh_config.lua" )

cm.Include( "cl_callbacks.lua" )

cm.Include( "cl_skin.lua" )

cm.Include( "cl_elements.lua" )

cm.Include( "cl_hooks.lua" )
