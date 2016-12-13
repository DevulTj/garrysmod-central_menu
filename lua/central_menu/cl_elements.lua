--[[
    Central UI Menu
    Created by http://steamcommunity.com/id/Devul/ and http://steamcommunity.com/id/fruitwasp/
    Do not redistribute this software without permission from authors

    Developer information: {{ user_id }} : {{ script_id }} : {{ script_version_id }}
]]--

local gradient = Material( "gui/gradient" )
local gradientr = Material( "vgui/gradient-r" )
local glowMat = Material( "particle/Particle_Glow_04_Additive" )
local blur = Material( "pp/blurscreen" )

local centralMenu

function cm.getCentralMenu()
    return centralMenu
end

cm.toggleMenu = function()
    if not IsValid( centralMenu ) then
        centralMenu = vgui.Create( "centralMenuFrame" )
    end

    centralMenu:SetAlpha( 0 )
    centralMenu:fadeIn()
end

local FRAME = {}

function FRAME:Init()
    self:StretchToParent( 0, 0, 0, 0 )
    self:SetDraggable( false )
    self:ShowCloseButton( false )
    self:SetTitle( "" )

    self:MakePopup()

    self:setUp()
end

function FRAME:canFade()
    if self.fadingIn or self.fadingOut then return false end

    return true
end

function FRAME:fadeIn()
    if not self:canFade() then return end

    self.fadingIn = true

    self:refreshBackground()

    self:AlphaTo( 255, cm.getClientData( "fade_time", 0.5 ), 0, function()
        self.fadingIn = false
    end )
end

function FRAME:fadeOut()
    if not self:canFade() then return end

    self.fadingOut = true

    self.background:MoveTo( 0.1, 0, cm.getClientData( "element_pressed_fade_time", 0.5 ), 0, -1, function()
        self:AlphaTo( 0, cm.getClientData( "fade_time", 0.5 ), 0, function()
            self.fadingOut = false
            self:Close()
        end )
    end )
end

function FRAME:refreshBackground()
    if cm.getUnEditableData( "background_material_disabled", false ) then return end

    local backgroundMaterial = cm.getClientData( "background_material", "cm/gmod_background.jpg" )

    if istable( backgroundMaterial ) then
        backgroundMaterial = table.Random( backgroundMaterial )
    end

    self.backgroundMaterial = Material( backgroundMaterial )
end

function FRAME:setUp()
    self:refreshBackground()

    local buttonDisabledColor = cm.getClientData( "element_button_disabled_color", Color( 125, 125, 125 ) )
    local buttonDownColor = cm.getClientData( "element_button_down_color", Color( 235, 235, 235 ) )
    local buttonHoverColor = cm.getClientData( "element_button_hover_color", Color( 215, 215, 215 ) )
    local buttonColor = cm.getClientData( "element_button_color", color_white )

    self.background = self:Add( "DPanel" )
    self.background:SetSize( self:GetWide() * 3, self:GetTall() )

    local color = cm.getClientData( "main_color", color_black )
    local gradientCol = cm.getClientData( "gradient_color", color_black )

    self.background.Paint = function( pnl, w, h )
        local scrW, scrH = ScrW(), ScrH()

        draw.RoundedBox( 0, 0, 0, w, h, color )
        draw.RoundedBox( 0, scrW, 0, w - scrW, h, gradientCol )

        if self.backgroundMaterial then
            surface.SetDrawColor( Color( 255, 255, 255, self:GetAlpha() ) )
            surface.SetMaterial( self.backgroundMaterial )
            surface.DrawTexturedRect( 0, 0, scrW, scrH )
        end

        surface.SetDrawColor( gradientCol )
        surface.SetMaterial( gradientr )
        surface.DrawTexturedRect( scrW * 0.75, 0, scrW * 0.25, h )
    end

    self.leftLayout = self:Add( "DIconLayout" )
    self.leftLayout:Dock( LEFT )
    self.leftLayout:DockMargin( 0, -24, 0, 0 )
    self.leftLayout:SetWide( 160 )
    self.leftLayout:SetSpaceX( 4 )

    local elementsCol = cm.getClientData( "theme_elements_color", color_white )
    elementsCol = Color( elementsCol.r, elementsCol.g, elementsCol.b, 75 )
    self.leftLayout.Paint = function( pnl, w, h )
        surface.SetDrawColor( elementsCol )
        surface.SetMaterial( gradient )
        surface.DrawTexturedRect( w - 1, 0, 1, h )
    end

    self.buttonLayout = self:Add( "DIconLayout" )
    self.buttonLayout:Dock( TOP )
    self.buttonLayout:DockMargin( 24, 0, 0, 0 )
    self.buttonLayout:DockPadding( 0, 0, 0, 16 )
    self.buttonLayout:SetTall( 40 )
    self.buttonLayout:SetSpaceX( 4 )

    self.buttonLayout.Paint = function( pnl, w, h )
        surface.SetDrawColor( elementsCol )
        surface.SetMaterial( gradient )
        surface.DrawTexturedRect( 0, h - 1, w, 1 )
    end

    self.panel = self:Add( "EditablePanel" )
    self.panel:Dock( FILL )
    self.panel:DockMargin( 20, 12, 0, 0 )
    self.panel.Paint = function( pnl, w, h ) end

    local buttonW = 120

    self.buttonUnderWidget = self:Add( "DPanel" )
    self.buttonUnderWidget:SetSize( buttonW, 1 )
    self.buttonUnderWidget.Paint = function( pnl, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, cm.getClientData( "theme_elements_widget_color", color_white ) )
    end

    self.elements = {}
    for Id, data in SortedPairs( cm.config.ELEMENTS ) do
        self.elements[ Id ] = self.buttonLayout:Add( "DButton" )
        local button = self.elements[ Id ]

        button:SetText(
        cm.getUnEditableData( "element_title_force_uppercase", false ) and string.upper( data.name )
        or data.name )

        button:Dock( LEFT )
        button:SetWide( buttonW )
        button:SetFont( "cmLarge" )
        button:SetExpensiveShadow( 1, Color( 0, 0, 0, 185 ) )

        button.alpha = 0
        button.Paint = function( pnl, w, h )
            pnl.alpha = math.Clamp( pnl:IsHovered() and pnl.alpha + 5 or pnl.alpha - 5, 0, 75 )
            surface.SetDrawColor( Color( buttonHoverColor.r, buttonHoverColor.g, buttonHoverColor.b, pnl.alpha ) )
            surface.SetMaterial( glowMat )
            surface.DrawTexturedRect( 0, 0, w, h * 1.2 )
        end

        local customCheck = data.customCheck and data.customCheck( LocalPlayer(), button )
        button:SetDisabled( customCheck == false )

        button.UpdateColours = function( pnl, skin )
            if pnl:GetDisabled() then return pnl:SetTextStyleColor( buttonDisabledColor ) end
            if pnl.Depressed or pnl.m_bSelected then return pnl:SetTextStyleColor( buttonDownColor ) end
            if pnl.Hovered then return pnl:SetTextStyleColor( buttonHoverColor ) end

            return pnl:SetTextStyleColor( buttonColor )
        end

        local increaseAmount = ScrW() / 6
        button.DoClick = function( pnl )
            local fadeTime = cm.getClientData( "element_pressed_fade_time", 0.5 )
            self.panel:AlphaTo( 0, fadeTime, 0 )
            self.background:MoveTo( - ( increaseAmount * ( Id - 1 ) ), nil, fadeTime, 0, -1, function()
                self.panel:Clear()
                self.panel:AlphaTo( 255, fadeTime, 0 )

                cm.getCallback( data, self )
            end )

            self.buttonUnderWidget:MoveTo( 68 + ( buttonW * Id ), 24 + 20 + pnl:GetTall(), fadeTime, 0, -1 )
        end

        if Id == 1 then self.buttonUnderWidget:SetPos( 68 + ( buttonW * Id ), 24 + 22 + button:GetTall() ) end
    end

    self.closeBtn = self:Add( "DImageButton" )
    self.closeBtn:SetSize( 32, 32 )
    self.closeBtn:SetPos( 100, ScrH() * 0.8 )
    self.closeBtn:SetImage( "cm/power.png" )
    self.closeBtn:SetColor( buttonColor )

    self.closeBtn.spam = CurTime()
    self.closeBtn.Paint = function( pnl, w, h )
        if pnl.Hovered then
            if not pnl.fading and self.closeBtn.spam < CurTime() then
                self.closeLabel.fading = true
                self.closeBtn.spam = CurTime() + 0.5

                self.closeLabel:MoveTo( -10, ScrH() * 0.8, 0.3, 0, -1, function() self.closeLabel.fading = false self.closeLabel.isInView = true end )
            end

            return
        end

        if not pnl.fading and self.closeLabel.isInView and self.closeBtn.spam < CurTime() then
            self.closeLabel.fading = true
            self.closeBtn.spam = CurTime() + 0.5

            self.closeLabel:MoveTo( -120, ScrH() * 0.8, 0.3, 0, -1, function() self.closeLabel.fading = false self.closeLabel.isInView = false end )
        end

        return
    end

    self.closeBtn.DoClick = function( pnl )
        local doDialogue = cm.getClientData( "ask_on_close" )

        if doDialogue then
            cm.createDialogue(
                "CLOSE",
                "Do you want to close?",
                "Yes",
                function( dialogue )
                    dialogue:Close()
                    self:fadeOut()
                end,
                "No",
                function( dialogue )
                    dialogue:Close()
                end )
        else
            self:fadeOut()
        end
    end

    self.closeLabel = self:Add( "DButton" )
    self.closeLabel:SetText( "CLOSE" )
    self.closeLabel:SetPos( -120 , ScrH() * 0.8 )
    self.closeLabel:SetSize( nil, 32 )
    self.closeLabel:SetWide( buttonW )
    self.closeLabel:SetFont( "cmMedium" )
    self.closeLabel.Paint = function() end

    self.closeLabel.UpdateColours = function( pnl, skin )
        if pnl:GetDisabled() then return pnl:SetTextStyleColor( buttonDisabledColor ) end
        if pnl.Depressed or pnl.m_bSelected then return pnl:SetTextStyleColor( buttonDownColor ) end
        if pnl.Hovered then return pnl:SetTextStyleColor( buttonHoverColor ) end

        return pnl:SetTextStyleColor( buttonColor )
    end

    if cm.getUnEditableData( "can_edit_clientside_settings", true ) then
        self.settingsLabel = self:Add( "DButton" )
        self.settingsLabel:SetText( "SETTINGS" )
        self.settingsLabel:SetPos( -120 , ScrH() * 0.9 )
        self.settingsLabel:SetSize( nil, 32 )
        self.settingsLabel:SetWide( buttonW )
        self.settingsLabel:SetFont( "cmMedium" )
        self.settingsLabel.Paint = function() end

        self.settingsLabel.UpdateColours = function( pnl, skin )
            if pnl:GetDisabled() then return pnl:SetTextStyleColor( buttonDisabledColor ) end
            if pnl.Depressed or pnl.m_bSelected then return pnl:SetTextStyleColor( buttonDownColor ) end
            if pnl.Hovered then return pnl:SetTextStyleColor( buttonHoverColor ) end

            return pnl:SetTextStyleColor( buttonColor )
        end

        self.settingsBtn = self:Add( "DImageButton" )
        self.settingsBtn:SetSize( 32, 32 )
        self.settingsBtn:SetPos( 100, ScrH() * 0.9 )
        self.settingsBtn:SetImage( "cm/cog.png" )
        self.settingsBtn:SetColor( buttonColor )

        self.settingsBtn.spam = CurTime()
        self.settingsBtn.Paint = function( pnl, w, h )
            if pnl.Hovered then
                if not pnl.fading and self.settingsBtn.spam < CurTime() then
                    self.settingsLabel.fading = true
                    self.settingsBtn.spam = CurTime() + 0.3

                    self.settingsLabel:MoveTo( -10, ScrH() * 0.9, 0.3, 0, -1, function() self.settingsLabel.fading = false self.settingsLabel.isInView = true end )
                end

                return
            end

            if not pnl.fading and self.settingsLabel.isInView and self.settingsBtn.spam < CurTime() then
                self.settingsLabel.fading = true
                self.settingsBtn.spam = CurTime() + 0.3

                self.settingsLabel:MoveTo( -120, ScrH() * 0.9, 0.3, 0, -1, function() self.settingsLabel.fading = false self.settingsLabel.isInView = false end )
            end

            return
        end

        self.settingsBtn.DoClick = function( pnl )
            cm.createSettingsFrame()
        end
    end

    if cm.getUnEditableData( "show_avatar", false ) then
        self.avatar = self:Add( "AvatarImage" )
        self.avatar:SetSize( 64, 64 )
        self.avatar:SetPos( 70, ScrH() * 0.18 )
        self.avatar:SetPlayer( LocalPlayer(), 64 )

        self.avatarClick = self:Add( "DButton" )
        self.avatarClick:SetTall( self.avatar:GetTall() )
        self.avatarClick:SetWide( self.avatar:GetWide() + 32 )
        self.avatarClick:SetText( "" )
        self.avatarClick:SetPos( select( 1, self.avatar:GetPos() ) - 32, select( 2, self.avatar:GetPos() ) )

        self.avatarClick.Paint = function( pnl, w, h )
            surface.SetDrawColor( Color( 237, 154, 30 ) )
            surface.SetMaterial( gradient )
            surface.DrawTexturedRect( 0, 0, 1, h )
        end

        self.avatarClick.DoClick = function() end
    end

    local firstElement = cm.config.ELEMENTS[ 1 ]
    if firstElement then cm.getCallback( firstElement, self ) end

    self.panel:SetAlpha( 0 )
    self.panel:AlphaTo( 255, cm.getClientData( "fade_time", 0.5 ), 0 )
end

derma.DefineControl( "centralMenuFrame", nil, FRAME, "DFrame" )

local BUTTON = {}

function BUTTON:Init()
    self:SetFont( "cmMedium" )
end

function BUTTON:Paint( w, h )
    local buttonColor = cm.getClientData( "button_bg_color", color_white )

    local isHovered = self:IsHovered()
    local xOverride, yOverride, wOverride, hOverride = self.xOverride or 0, self.yOverride or 0, self.wOverride or w, self.hOverride or h
    draw.RoundedBox( 0, xOverride, yOverride, wOverride, hOverride, Color( buttonColor.r, buttonColor.g, buttonColor.b, isHovered and 255 or 0 ) )

    surface.SetDrawColor( Color( buttonColor.r, buttonColor.g, buttonColor.b, 255 ) )
    surface.DrawOutlinedRect( xOverride, yOverride, wOverride, hOverride )

    self:SetTextColor( isHovered and cm.getClientData( "button_text_color_inverted", color_black ) or cm.getClientData( "button_text_color", color_white ) )
end

function BUTTON:PaintOver()
    local pressed = self.Depressed or self.m_bSelected

    self.xOverride, self.yOverride = pressed and 1 or nil, pressed and 1 or nil
    self.wOverride, self.hOverride = pressed and ( self:GetWide() - 2 ) or nil, pressed and ( self:GetTall() - 2 ) or nil
end

derma.DefineControl( "centralMenuDialogueButton", nil, BUTTON, "DButton" )

FRAME = {}

function FRAME:Init()
    self:StretchToParent( 0, 0, 0, 0 )
    self:SetDraggable( false )
    self:ShowCloseButton( false )

    self:SetTitle( "" )

    self:MakePopup()
end

function FRAME:Paint( w, h )
    draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )

    surface.SetMaterial( blur )
    surface.SetDrawColor( color_white )

    local x, y = self:LocalToScreen( 0, 0 )

    local scrW, scrH = ScrW(), ScrH()
    for i = 0.2, 1, 0.2 do
        blur:SetFloat( "$blur", i * 4 )
        blur:Recompute()

        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect( x * - 1, y * - 1, scrW, scrH )
    end
end

function FRAME:setUp()
    self.container = self:Add( "EditablePanel" )
    self.container:SetSize( ScrH() * 0.3, ScrH() * 0.3 )
    self.container:Center()

    self.title = self.container:Add( "DLabel" )
    self.title:Dock( TOP )
    self.title:SetText( self.titleText or "THIS IS A TITLE" )
    self.title:SetFont( "cmLarge" )
    self.title:SetTextColor( color_white )
    self.title:SetContentAlignment( 5 )
    self.title:SetHeight( 20 )

    self.text = self.container:Add( "DLabel" )
    self.text:Dock( TOP )
    self.text:SetText( self.textText or "This is some text" )
    self.text:SetFont( "cmMedium" )
    self.text:SetTextColor( color_white )
    self.text:SetContentAlignment( 5 )
    self.text:SetHeight( 40 )

    self.option1 = self.container:Add( "centralMenuDialogueButton" )
    self.option1:Dock( TOP )
    self.option1:SetText( self.option1Text or "YES" )
    self.option1:SetHeight( 40 )
    self.option1.DoClick = function( pnl )
        if self.callback1 then return self.callback1( self ) end
    end

    self.option2 = self.container:Add( "centralMenuDialogueButton" )
    self.option2:Dock( TOP )
    self.option2:DockMargin( 0, 4, 0, 0 )
    self.option2:SetText( self.option2Text or "NO" )
    self.option2:SetHeight( 40 )
    self.option2.DoClick = function( pnl )
        if self.callback2 then return self.callback2( self ) end
    end
end

derma.DefineControl( "centralMenuDialogueFrame", nil, FRAME, "DFrame" )

cm.createDialogue = function( title, text, option1, callback1, option2, callback2 )
    cm.dialogueFrame = vgui.Create( "centralMenuDialogueFrame" )

    cm.dialogueFrame.titleText = title
    cm.dialogueFrame.textText = text

    cm.dialogueFrame.option1Text = option1
    cm.dialogueFrame.callback1 = callback1

    cm.dialogueFrame.option2Text = option2
    cm.dialogueFrame.callback2 = callback2

    cm.dialogueFrame:setUp()

    cm.dialogueFrame:SetAlpha( 0 )
    cm.dialogueFrame:AlphaTo( 255, cm.getClientData( "fade_time", 0.5 ), 0 )
end

FRAME = {}

function FRAME:Init()
    self:StretchToParent( 0, 0, 0, 0 )
    self:SetDraggable( false )
    self:ShowCloseButton( false )

    self:SetTitle( "" )

    self:MakePopup()
end

function FRAME:Paint( w, h )

    draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ))

    surface.SetMaterial( blur )
    surface.SetDrawColor( color_white )

    local x, y = self:LocalToScreen( 0, 0 )

    for i = 0.2, 1, 0.2 do
        blur:SetFloat( "$blur", i * 4 )
        blur:Recompute()

        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect( x * - 1, y * - 1, ScrW(), ScrH() )
    end
end

function FRAME:setUp()
    self.container = self:Add( "Panel" )
    self.container:SetSize( ScrH() * 0.75, ScrH() * 0.75 )
    self.container:Center()

    self.title = self.container:Add( "DLabel" )
    self.title:Dock( TOP )
    self.title:SetText( "SETTINGS" )
    self.title:SetFont( "cmLarge" )
    self.title:SetTextColor( color_white )
    self.title:SetContentAlignment( 4 )
    self.title:SetHeight( 20 )

    self.spacer = self.container:Add( "DPanel" )
    self.spacer:Dock( TOP )
    self.spacer:DockMargin( 0, 8, 0, 0 )
    self.spacer:SetHeight( 1 )

    self.spacer.Paint = function( pnl, w, h )
        surface.SetDrawColor( color_white )
        surface.SetMaterial( gradient )
        surface.DrawTexturedRect( 0, 0, w, h )
    end

    self.closeBtn = self.container:Add( "centralMenuDialogueButton" )
    self.closeBtn:Dock( BOTTOM )
    self.closeBtn:DockMargin( 0, 4, 0, 0 )
    self.closeBtn:SetText( "CLOSE" )
    self.closeBtn:SetHeight( 40 )
    self.closeBtn.DoClick = function( pnl )
        self:Close()
    end

    self.resetBtn = self.container:Add( "centralMenuDialogueButton" )
    self.resetBtn:Dock( BOTTOM )
    self.resetBtn:DockMargin( 0, 4, 0, 4 )
    self.resetBtn:SetText( "RESET TO DEFAULTS" )
    self.resetBtn:SetHeight( 40 )
    self.resetBtn.DoClick = function( pnl )
        cm.createDialogue( "RESET", "Reset to defaults settings?", "YES", function( dialogue )
            for a, b in pairs( cm.data.stored ) do
                cm.setClientData( a, b.default )
            end

            dialogue:Close()

            self:Close()
            cm.createSettingsFrame()
        end, "NO", function( dialogue ) dialogue:Close() end )
    end

    self.scroll = self.container:Add( "DScrollPanel" )
    self.scroll:Dock( FILL )
    self.scroll:SetSize( ScrH() * 0.75, ScrH() * 0.75 - 112 )
    self.scroll:InvalidateParent( true )

    self.properties = self.scroll:Add( "DProperties" )
    self.properties:SetSize( self.scroll:GetSize() )

    local varsSaved = {}
    for k, v in pairs( cm.data.stored ) do
        local index = v.data and v.data.category or "misc"

        varsSaved[ index ] = varsSaved[ index ] or {}
        varsSaved[ index ][ k ] = v
    end

    for category, settings in SortedPairs( varsSaved ) do
        for k, v in SortedPairs( settings ) do
            local form = v.data and v.data.form
            local value = cm.getClientData( k, cm.data.stored[ k ].default )

            if not form then
                local _type = type( value )

                if _type == "number" then
                    form = "Int"
                    value = tonumber( value )
                elseif _type == "boolean" then
                    form = "Boolean"
                    value = tobool( value )
                elseif _type == "table" and not value.r then
                    form = "Combo"
                else
                    form = "Generic"
                end
            end

            if form == "Generic" and type( value ) == "table" and value.r and value.g and value.b then
                value = Vector( value.r / 255, value.g / 255, value.b / 255 )
                form = "VectorColor"
            end

            local row = self.properties:CreateRow( category, k )
            row:Setup( form, v.data and v.data.data or {} )
            row:SetTooltip( v.description )

            local _type = type( value )
            if _type == "table" and not IsColor(value) then
                for _, rowValue in pairs( value ) do
                    row:AddChoice( rowValue, rowValue, true )
                    print(rowValue)
                end
            end

            if _type ~= "table" then
                row:SetValue( value )
            end

            local beforeVal = value
            row.DataChanged = function( this, data )
                if form == "VectorColor" then
                    local vector = Vector( data )

                    data = Color( math.floor( vector.x * 255 ), math.floor( vector.y * 255 ), math.floor( vector.z * 255 ) )
                elseif form == "Int" or form == "Float" then
                    data = tonumber( data )

                    if form == "Int" then
                        data = math.Round( data )
                    end
                elseif form == "Boolean" then
                    data = tobool( data )
                end

                cm.setClientData( k, data )
                if v.callback then v.callback( beforeVal, data ) end
            end
        end
    end
end

derma.DefineControl( "centralMenuSettingsFrame", nil, FRAME, "DFrame" )

cm.createSettingsFrame = function()
    cm.settingsFrame = vgui.Create( "centralMenuSettingsFrame" )
    cm.settingsFrame:setUp()

    cm.settingsFrame:SetAlpha( 0 )
    cm.settingsFrame:AlphaTo( 255, cm.getClientData( "fade_time", 0.5 ), 0 )
end

BUTTON = {}

function BUTTON:Init()
    self:SetText( "" )
end

function BUTTON:setText( text )
    self.textText = text
end

function BUTTON:getText()
    return self.textText
end

function BUTTON:setDesc( desc )
    self.descText = desc
end

function BUTTON:getDesc()
    return self.descText
end

function BUTTON:setJoinText( text )
    self.joinText = text
end

function BUTTON:getJoinText()
    return self.joinText
end

function BUTTON:setServerIcon( mat )
    self.serverIcon = mat
end

function BUTTON:getServerIcon()
    return self.serverIcon
end

function BUTTON:setIP( ip )
    self.ip = ip
end

function BUTTON:getIP()
    return self.ip
end

function BUTTON:setUp()
    self.topPanel = self:Add( "DPanel" )
    self.topPanel:SetSize( self:GetWide(), self:GetTall() / 2 )

    self.bottomPanel = self:Add( "DButton" )
    self.bottomPanel:SetText( "" )
    self.bottomPanel:SetSize( self:GetWide(), self:GetTall() / 2 )
    self.bottomPanel:SetPos( 0, self:GetTall() / 2 )

    self.bottomPanel.boxY = self.bottomPanel:GetTall()
    self.bottomPanel.textCol = 255

    self.bottomPanel.Paint = function( pnl, w, h )
        local hovered = pnl:IsHovered()

        pnl.boxY = math.Clamp( hovered and ( pnl.boxY - 4 ) or ( pnl.boxY + 3 ), 0, self.bottomPanel:GetTall() )
        pnl.textCol = math.Clamp( hovered and ( pnl.textCol - 10 ) or ( pnl.textCol + 10 ), 0, 255 )

        draw.RoundedBox( 0, 0, pnl.boxY, w, h, cm.getClientData( "button_bg_color", color_white ) )
        draw.RoundedBox( 0, 0, h - 32, w, 1, Color( 150, 150, 150, 255 ) )

        draw.SimpleText( self.joinText or "JOIN", "cmMedium", w / 2, h - 4, Color( pnl.textCol, pnl.textCol, pnl.textCol, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )
        draw.SimpleText( self.textText or "SERVER NAME", "cmMedium", 12, 10, Color( pnl.textCol, pnl.textCol, pnl.textCol, 255 ) )

        draw.SimpleText( self.descText or "A garry's mod server.", "cmSmall", 12, 36, Color( pnl.textCol, pnl.textCol, pnl.textCol, 255 ) )
    end

    local icon = self:getServerIcon()

    self.topPanel.iconW, self.topPanel.iconH = self.topPanel:GetSize()
    self.topPanel.PaintOver = function( pnl, w, h )
        local hovered = self.bottomPanel:IsHovered()
        pnl.iconW = math.Clamp( hovered and ( pnl.iconW + 0.25 ) or ( pnl.iconW - 0.25 ), self.topPanel:GetWide(), self.topPanel:GetWide() * 1.02 )
        pnl.iconH = math.Clamp( hovered and ( pnl.iconH + 0.25 ) or ( pnl.iconH - 0.25 ), self.topPanel:GetTall(), self.topPanel:GetTall() * ( 1 + ( 0.02 * ( self.topPanel:GetWide() / self.topPanel:GetTall() ) ) ) )

        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.SetMaterial( icon )
        surface.DrawTexturedRect( 0, 0, pnl.iconW, pnl.iconH )
    end

    self.bottomPanel.DoClick = function( pnl )
        cm.createDialogue( "JOIN SERVER", "Do you want join " .. self.textText .. "?" , "Yes", function( dialogue ) dialogue:Close() RunConsoleCommand( "connect", self:getIP() ) end, "No", function( dialogue ) dialogue:Close() end )
    end
end

function BUTTON:Paint( w, h )
    draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 75 ) )
    surface.SetMaterial( blur )
    surface.SetDrawColor( color_white )

    local x, y = self:LocalToScreen( 0, 0 )

    local scrW, scrH = ScrW(), ScrH()
    for i = 2, 1, 0.2 do
        blur:SetFloat( "$blur", i * 5 )
        blur:Recompute()

        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect( x * - 1, y * - 1, scrW, scrH )
    end
end

function BUTTON:PaintOver()
    local pressed = self.Depressed or self.m_bSelected

    self.xOverride, self.yOverride = pressed and 1 or nil, pressed and 1 or nil
    self.wOverride, self.hOverride = pressed and ( self:GetWide() - 2 ) or nil, pressed and ( self:GetTall() - 2 ) or nil
end

derma.DefineControl( "centralMenuServerButton", nil, BUTTON, "DButton" )
