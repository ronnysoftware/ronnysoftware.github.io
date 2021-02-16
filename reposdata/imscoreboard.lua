script_name('Scoreboard | ImGui')
script_author('ronnyscripts')
script_version('1.4')
local imgui = require('imgui')
local inicfg = require("inicfg")
-- local bit = require("bit")
local encoding = require("encoding")
encoding.default = 'CP1251'
u8 = encoding.UTF8
local path = 'moonloader/config'
local ini_file = 'scoreboard.ini'

local ini = inicfg.load({
    cfg = {
        tabStandartBlock = true,
        sizeX = 1000,
        sizeY = 500,
        themeNumber = 0
    }
},ini_file)

local tabStandartBlock = imgui.ImBool(ini.cfg.tabStandartBlock)
local sizeX = imgui.ImInt(ini.cfg.sizeX)
local sizeY = imgui.ImInt(ini.cfg.sizeY)
local themeNumber = imgui.ImInt(ini.cfg.themeNumber)
local tabActive = imgui.ImBool(false)
local tabStream = imgui.ImBool(false)
local tabSearch = imgui.ImBuffer('',200)


if not doesDirectoryExist(path) then
    createDirectory(path)
end

if not doesFileExist(path..'/'..ini_file) then
    inicfg.save(ini,ini_file)
end

function onWindowMessage(msg, wparam, lparam)
	if msg == 0x100 or msg == 0x101 then
		if (wparam == 0x1B and tabActive.v) and not isPauseMenuActive() then
			consumeWindowMessage(true, false)
			if msg == 0x101 then
				tabActive.v = false
			end
        end
    end
end

function main()
    while not isSampAvailable() do
        wait(0)
    end
    while true do
        wait(0)
        imgui.Process = tabActive.v
        if tabStandartBlock.v then
            sampToggleScoreboard(false)
            if isKeyJustPressed(0x09) and not sampIsChatInputActive() then
                tabActive.v = not tabActive.v
            end
        else
            if isKeyJustPressed(0x7A) then
                tabActive.v = not tabActive.v
            end
        end
    end
end

function imgui.OnDrawFrame()
    local sw, sh = getScreenResolution()
    if tabActive.v then
        imgui.SetNextWindowSize(imgui.ImVec2(sizeX.v,sizeY.v))
        imgui.SetNextWindowPos(imgui.ImVec2(sw/2,sh/2),0,imgui.ImVec2(0.5,0.5))
        imgui.Begin(u8(''..sampGetCurrentServerName()),nil,imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
        imgui.SetNextWindowPos(imgui.ImVec2(150,sh - 100),0,imgui.ImVec2(0.5,0.5))
        if imgui.BeginPopup('Settings', true) then
            imgui.Text(u8('Block Standart Scoreboard'))
            imgui.SameLine()
            imgui.ToggleButton('##Block Standart Scoreboard',tabStandartBlock)
            imgui.SameLine()
            imgui.TextQuestion(u8('Blocking TAB for open standart scoreboard.\nIf this toggle is off, then for toggle on new scoreboard press F11'))
            imgui.Text(u8('Window Settings'))
            imgui.PushItemWidth(500)
            imgui.SliderInt('Size X',sizeX,100,sw)
            imgui.SliderInt('Size Y',sizeY,100,sh)
            imgui.PopItemWidth()
            if imgui.Combo('Change Theme',themeNumber,{'Dark Blue','Dark Red','Dark White'},-1) then
                imgui.Themes(themeNumber.v)
            end
            if imgui.Button('Save') then
                ini.cfg.tabStandartBlock = tabStandartBlock.v
                ini.cfg.sizeX = sizeX.v
                ini.cfg.sizeY = sizeY.v
                ini.cfg.themeNumber = themeNumber.v
                inicfg.save(ini,ini_file)
            end
            imgui.EndPopup()
        end
        imgui.Checkbox('Stream',tabStream)
        imgui.SameLine()
        if imgui.Button('Settings') then
            imgui.OpenPopup('Settings')
        end
        imgui.SameLine()
        imgui.Text(u8('Online: '..sampGetPlayerCount(false)..' | Stream: '..sampGetPlayerCount(true)-1))
        imgui.SameLine(sizeX.v - 180)
        imgui.PushItemWidth(120)
        imgui.PushAllowKeyboardFocus(false)
        imgui.InputText('Search',tabSearch)
        imgui.PopAllowKeyboardFocus()
        imgui.PopItemWidth()
        imgui.Columns(5,'All tab',true)
        imgui.Separator()
        imgui.SetColumnWidth(-1,30)
        imgui.Text('ID')
        imgui.NextColumn()
        imgui.SetColumnWidth(-1,sizeX.v -185)
        imgui.Text('Nick')
        imgui.NextColumn()
        imgui.SetColumnWidth(-1,45)
        imgui.Text('Score')
        imgui.NextColumn()
        imgui.SetColumnWidth(-1,45)
        imgui.Text('Ping')
        imgui.NextColumn()
        imgui.SetColumnWidth(-1,45)
        imgui.Text('Dist')
        imgui.NextColumn()
        local res,id = sampGetPlayerIdByCharHandle(PLAYER_PED)
        imgui.RenderScoreboardPlayers(id)
        local players = {}

        for i = 0, sampGetMaxPlayerId(false) do
			if id ~= i and sampIsPlayerConnected(i) then
				local isInStream = sampGetCharHandleBySampPlayerId(i)
				if(#tabSearch.v > 0) then
					if tonumber(tabSearch.v) ~= nil and tostring(i):find(tabSearch.v) or string.find(sampGetPlayerNickname(i):lower(), tabSearch.v:lower(), 1, true) then
						if not tabStream.v or (tabStream.v and isInStream) then
							local nickname = (sampGetPlayerNickname(i))
							table.insert(players, i)
						end
					end
				else
                    if not tabStream.v or (tabStream.v and isInStream) then
                        local nickname = (sampGetPlayerNickname(i))
                        table.insert(players, i)
                    end
				end
			end
		end

        if #players > 0  then
            local clipper = imgui.ImGuiListClipper(#players)
            while clipper:Step() do
                for i = clipper.DisplayStart + 1, clipper.DisplayEnd do
                    imgui.RenderScoreboardPlayers(players[i]) 
                end
            end
        end
        imgui.Columns(1)
        imgui.Separator()
        imgui.End()
    end
end
function sampGetPlayerDist(id)
    local res,handle_player = sampGetCharHandleBySampPlayerId(id)
    if res then 
        local x1,y1,z1 = getCharCoordinates(handle_player) 
        local x,y,z = getCharCoordinates(PLAYER_PED)
        return (math.floor(getDistanceBetweenCoords3d(x,y,z,x1,y1,z1)))
    end
    return nil
end

function imgui.RenderScoreboardPlayers(int_id)
    local str_nick = sampGetPlayerNickname(int_id) 
    local int_score = sampGetPlayerScore(int_id)
    local int_ping = sampGetPlayerPing(int_id)
    local bool_streaming = select(1, sampGetCharHandleBySampPlayerId(int_id))
    
    if imgui.BeginPopup('##playerinfo'..int_id,false) then
        if imgui.Button('Copy nick##'..int_id) then setClipboardText(str_nick) imgui.CloseCurrentPopup() end
        imgui.SameLine()
        if imgui.Button('Copy ID##'..int_id) then setClipboardText(int_id) imgui.CloseCurrentPopup() end
        imgui.EndPopup()
    end
    imgui.Separator()
    if imgui.Selectable(''..int_id,false,imgui.SelectableFlags.SpanAllColumns) then imgui.OpenPopup('##playerinfo'..int_id) end
    imgui.NextColumn()
    local player_color = sampGetPlayerColor(int_id)
    player_color = string.format('%06X', bit.band(player_color,  0xFFFFFF))
    imgui.TextColoredRGB('{'..player_color..'}'..str_nick)
    imgui.NextColumn()
    imgui.Text(''..int_score)
    imgui.NextColumn()
    imgui.Text(''..int_ping)
    imgui.NextColumn()
    local dist
    if bool_streaming then
        dist = sampGetPlayerDist(int_id) ..'m'
    else
        if int_id == select(2,sampGetPlayerIdByCharHandle(PLAYER_PED)) then
            dist = 'You' 
        else
            dist = '-' 
        end
    end
    imgui.Text(''..dist)
    imgui.NextColumn()
end
function imgui.Themes(intTheme)
    imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2
    
    
	style.WindowPadding = imgui.ImVec2(8, 8)
	style.WindowRounding = 6
	style.ChildWindowRounding = 5
	style.FramePadding = imgui.ImVec2(5, 3)
	style.FrameRounding = 3.0
	style.ItemSpacing = imgui.ImVec2(5, 4)
	style.ItemInnerSpacing = imgui.ImVec2(4, 4)
	style.IndentSpacing = 21
	style.ScrollbarSize = 10.0
	style.ScrollbarRounding = 13
	style.GrabMinSize = 8
	style.GrabRounding = 1
	style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
	style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)

    local tableThemes = {
        [0] = function()

            colors[clr.Text] = ImVec4(0.95, 0.96, 0.98, 1.00)
            colors[clr.TextDisabled] = ImVec4(0.36, 0.42, 0.47, 1.00)
            colors[clr.WindowBg] = ImVec4(0.11, 0.15, 0.17, 0.95)
            colors[clr.ChildWindowBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
            colors[clr.PopupBg] = ImVec4(0.08, 0.08, 0.08, 0.94)
            colors[clr.Border] = ImVec4(0.43, 0.43, 0.50, 0.50)
            colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
            colors[clr.FrameBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
            colors[clr.FrameBgHovered] = ImVec4(0.12, 0.20, 0.28, 1.00)
            colors[clr.FrameBgActive] = ImVec4(0.09, 0.12, 0.14, 1.00)
            colors[clr.TitleBg] = ImVec4(0.09, 0.12, 0.14, 0.65)
            colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.51)
            colors[clr.TitleBgActive] = ImVec4(0.08, 0.10, 0.12, 1.00)
            colors[clr.MenuBarBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
            colors[clr.ScrollbarBg] = ImVec4(0.02, 0.02, 0.02, 0.39)
            colors[clr.ScrollbarGrab] = ImVec4(0.20, 0.25, 0.29, 1.00)
            colors[clr.ScrollbarGrabHovered] = ImVec4(0.18, 0.22, 0.25, 1.00)
            colors[clr.ScrollbarGrabActive] = ImVec4(0.09, 0.21, 0.31, 1.00)
            colors[clr.ComboBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
            colors[clr.CheckMark] = ImVec4(0.28, 0.56, 1.00, 1.00)
            colors[clr.SliderGrab] = ImVec4(0.28, 0.56, 1.00, 1.00)
            colors[clr.SliderGrabActive] = ImVec4(0.37, 0.61, 1.00, 1.00)
            colors[clr.Button] = ImVec4(0.20, 0.25, 0.29, 1.00)
            colors[clr.ButtonHovered] = ImVec4(0.28, 0.56, 1.00, 1.00)
            colors[clr.ButtonActive] = ImVec4(0.06, 0.53, 0.98, 1.00)
            colors[clr.Header] = ImVec4(0.20, 0.25, 0.29, 0.55)
            colors[clr.HeaderHovered] = ImVec4(0.26, 0.59, 0.98, 0.80)
            colors[clr.HeaderActive] = ImVec4(0.26, 0.59, 0.98, 1.00)
            colors[clr.ResizeGrip] = ImVec4(0.26, 0.59, 0.98, 0.25)
            colors[clr.ResizeGripHovered] = ImVec4(0.26, 0.59, 0.98, 0.67)
            colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
            colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
            colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
            colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
            colors[clr.PlotLines] = ImVec4(0.61, 0.61, 0.61, 1.00)
            colors[clr.PlotLinesHovered] = ImVec4(1.00, 0.43, 0.35, 1.00)
            colors[clr.PlotHistogram] = ImVec4(0.90, 0.70, 0.00, 1.00)
            colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
            colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
            colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
        end,
        [1] = function()
            colors[clr.Text]                   = ImVec4(0.95, 0.96, 0.98, 1.00);
            colors[clr.TextDisabled]           = ImVec4(0.29, 0.29, 0.29, 1.00);
            colors[clr.WindowBg]               = ImVec4(0.14, 0.14, 0.14, 0.95);
            colors[clr.ChildWindowBg]          = ImVec4(0.17, 0.17, 0.17, 1.00);
            colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94);
            colors[clr.Border]                 = ImVec4(0.14, 0.14, 0.14, 1.00);
            colors[clr.BorderShadow]           = ImVec4(1.00, 1.00, 1.00, 0.10);
            colors[clr.FrameBg]                = ImVec4(0.22, 0.22, 0.22, 1.00);
            colors[clr.FrameBgHovered]         = ImVec4(0.18, 0.18, 0.18, 1.00);
            colors[clr.FrameBgActive]          = ImVec4(0.10, 0.10, 0.10, 1.00);
            colors[clr.TitleBg]                = ImVec4(0.14, 0.14, 0.14, 0.81);
            colors[clr.TitleBgActive]          = ImVec4(0.12, 0.12, 0.12, 1.00);
            colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51);
            colors[clr.MenuBarBg]              = ImVec4(0.20, 0.20, 0.20, 1.00);
            colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.39);
            colors[clr.ScrollbarGrab]          = ImVec4(0.36, 0.36, 0.36, 1.00);
            colors[clr.ScrollbarGrabHovered]   = ImVec4(0.18, 0.22, 0.25, 1.00);
            colors[clr.ScrollbarGrabActive]    = ImVec4(0.24, 0.24, 0.24, 1.00);
            colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 1.00);
            colors[clr.CheckMark]              = ImVec4(1.00, 0.28, 0.28, 1.00);
            colors[clr.SliderGrab]             = ImVec4(1.00, 0.28, 0.28, 1.00);
            colors[clr.SliderGrabActive]       = ImVec4(1.00, 0.28, 0.28, 1.00);
            colors[clr.Button]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
            colors[clr.ButtonHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
            colors[clr.ButtonActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
            colors[clr.Header]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
            colors[clr.HeaderHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
            colors[clr.HeaderActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
            colors[clr.ResizeGrip]             = ImVec4(1.00, 0.28, 0.28, 1.00);
            colors[clr.ResizeGripHovered]      = ImVec4(1.00, 0.39, 0.39, 1.00);
            colors[clr.ResizeGripActive]       = ImVec4(1.00, 0.19, 0.19, 1.00);
            colors[clr.CloseButton]            = ImVec4(0.40, 0.39, 0.38, 0.16);
            colors[clr.CloseButtonHovered]     = ImVec4(0.40, 0.39, 0.38, 0.39);
            colors[clr.CloseButtonActive]      = ImVec4(0.40, 0.39, 0.38, 1.00);
            colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
            colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00);
            colors[clr.PlotHistogram]          = ImVec4(1.00, 0.21, 0.21, 1.00);
            colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.18, 0.18, 1.00);
            colors[clr.TextSelectedBg]         = ImVec4(1.00, 0.32, 0.32, 1.00);
            colors[clr.ModalWindowDarkening]   = ImVec4(0.26, 0.26, 0.26, 0.60);
        end,
        [2] = function()
            colors[clr.Text]                   = ImVec4(0.90, 0.90, 0.90, 1.00);
            colors[clr.TextDisabled]           = ImVec4(0.60, 0.60, 0.60, 1.00);
            colors[clr.WindowBg]               = ImVec4(0.08, 0.08, 0.08, 0.95);
            colors[clr.ChildWindowBg]          = ImVec4(0.10, 0.10, 0.10, 1.00);
            colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 1.00);
            colors[clr.Border]                 = ImVec4(0.60, 0.60, 0.60, 0.40);
            colors[clr.BorderShadow]           = ImVec4(1.00, 1.00, 1.00, 0.00);
            colors[clr.FrameBg]                = ImVec4(0.36, 0.36, 0.36, 0.30);
            colors[clr.FrameBgHovered]         = ImVec4(0.53, 0.53, 0.53, 0.30);
            colors[clr.FrameBgActive]          = ImVec4(0.62, 0.62, 0.62, 0.30);
            colors[clr.TitleBg]                = ImVec4(0.12, 0.12, 0.12, 0.92);
            colors[clr.TitleBgActive]          = ImVec4(0.11, 0.11, 0.11, 1.00);
            colors[clr.TitleBgCollapsed]       = ImVec4(0.11, 0.11, 0.11, 0.85);
            colors[clr.MenuBarBg]              = ImVec4(0.20, 0.20, 0.20, 1.00);
            colors[clr.ScrollbarBg]            = ImVec4(0.13, 0.13, 0.13, 1.00);
            colors[clr.ScrollbarGrab]          = ImVec4(0.26, 0.26, 0.26, 1.00);
            colors[clr.ScrollbarGrabHovered]   = ImVec4(0.19, 0.19, 0.19, 1.00);
            colors[clr.ScrollbarGrabActive]    = ImVec4(0.40, 0.40, 0.40, 1.00);
            colors[clr.ComboBg]                = ImVec4(0.23, 0.23, 0.23, 1.00);
            colors[clr.CheckMark]              = ImVec4(0.90, 0.90, 0.90, 1.00);
            colors[clr.SliderGrab]             = ImVec4(0.27, 0.27, 0.27, 1.00);
            colors[clr.SliderGrabActive]       = ImVec4(0.24, 0.23, 0.23, 1.00);
            colors[clr.Button]                 = ImVec4(0.36, 0.36, 0.36, 0.40);
            colors[clr.ButtonHovered]          = ImVec4(0.47, 0.46, 0.46, 0.40);
            colors[clr.ButtonActive]           = ImVec4(0.64, 0.64, 0.64, 0.53);
            colors[clr.Header]                 = ImVec4(0.36, 0.36, 0.36, 0.30);
            colors[clr.HeaderHovered]          = ImVec4(0.49, 0.49, 0.49, 0.30);
            colors[clr.HeaderActive]           = ImVec4(0.42, 0.42, 0.42, 0.30);
            colors[clr.Separator]              = ImVec4(1.00, 1.00, 1.00, 0.30);
            colors[clr.SeparatorHovered]       = ImVec4(0.36, 0.36, 0.36, 0.30);
            colors[clr.SeparatorActive]        = ImVec4(0.23, 0.23, 0.23, 0.30);
            colors[clr.ResizeGrip]             = ImVec4(0.36, 0.36, 0.36, 0.30);
            colors[clr.ResizeGripHovered]      = ImVec4(0.49, 0.49, 0.49, 0.30);
            colors[clr.ResizeGripActive]       = ImVec4(0.25, 0.25, 0.25, 0.30);
            colors[clr.CloseButton]            = ImVec4(0.36, 0.36, 0.36, 0.30);
            colors[clr.CloseButtonHovered]     = ImVec4(0.51, 0.51, 0.51, 0.30);
            colors[clr.CloseButtonActive]      = ImVec4(0.22, 0.22, 0.22, 0.30);
            colors[clr.PlotLines]              = ImVec4(1.00, 1.00, 1.00, 1.00);
            colors[clr.PlotLinesHovered]       = ImVec4(0.90, 0.70, 0.00, 1.00);
            colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00);
            colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00);
            colors[clr.TextSelectedBg]         = ImVec4(0.25, 0.25, 0.25, 0.30);
            colors[clr.ModalWindowDarkening]   = ImVec4(0.21, 0.21, 0.21, 0.21);
        end
    }
    tableThemes[intTheme]()
end
imgui.Themes(themeNumber.v)
function imgui.ToggleButton(str_id, bool)

    local rBool = false
 
    if LastActiveTime == nil then
       LastActiveTime = {}
    end
    if LastActive == nil then
       LastActive = {}
    end
 
    local function ImSaturate(f)
       return f < 0.0 and 0.0 or (f > 1.0 and 1.0 or f)
    end
  
    local p = imgui.GetCursorScreenPos()
    local draw_list = imgui.GetWindowDrawList()
 
    local height = imgui.GetTextLineHeightWithSpacing() + (imgui.GetStyle().FramePadding.y / 2)
    local width = height * 1.55
    local radius = height * 0.45
    local ANIM_SPEED = 0.15
 
    if imgui.InvisibleButton(str_id, imgui.ImVec2(width, height)) then
       bool.v = not bool.v
       rBool = true
       LastActiveTime[tostring(str_id)] = os.clock()
       LastActive[str_id] = true
    end
 
    local t = bool.v and 1.0 or 0.0
 
    if LastActive[str_id] then
       local time = os.clock() - LastActiveTime[tostring(str_id)]
       if time <= ANIM_SPEED then
          local t_anim = ImSaturate(time / ANIM_SPEED)
          t = bool.v and t_anim or 1.0 - t_anim
       else
          LastActive[str_id] = false
       end
    end
 
    local col_bg
    if imgui.IsItemHovered() then
       col_bg = imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.FrameBgHovered])
    else
       col_bg = imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.FrameBg])
    end
 
    draw_list:AddRectFilled(p, imgui.ImVec2(p.x + width, p.y + height - 3), col_bg, height * 0.5)
    draw_list:AddCircleFilled(imgui.ImVec2(p.x + radius + t * (width - radius * 2.0), p.y + radius), radius - 1.5, imgui.GetColorU32(bool.v and imgui.GetStyle().Colors[imgui.Col.ButtonActive] or imgui.GetStyle().Colors[imgui.Col.Button]))
 
    return rBool
end
function imgui.TextColoredRGB(text)
    local width = imgui.GetWindowWidth()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end

    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImColor(r, g, b, a):GetVec4()
    end

    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local textsize = w:gsub('{.-}', '')
            local text_width = imgui.CalcTextSize(u8(textsize))
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else
                imgui.Text(u8(w))
            end
        end
    end
    render_text(text)
end
function imgui.TextQuestion(text)
    imgui.TextDisabled('(?)')
    if imgui.IsItemHovered() then
      imgui.BeginTooltip()
      imgui.PushTextWrapPos(450)
      imgui.TextUnformatted(text)
      imgui.PopTextWrapPos()
      imgui.EndTooltip()
    end
end