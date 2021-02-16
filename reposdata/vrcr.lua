script_name("VR Chat Remover")
script_version('3.1')
script_author("ronnyscripts")
local imgui = require('imgui')
local encoding = require("encoding")
encoding.default = 'CP1251'
u8 = encoding.UTF8
local inicfg = require("inicfg")
local sampev = require("samp.events")

local path = getWorkingDirectory() .. '\\config'
local file = 'vrchatremover.ini'
local mainIni = inicfg.load({
    config = {
        renderChat = false,
        removechat = false,
        tosampfuncs = false,
        sendmessageTime = false,
        posRenderX = 50,
        posRenderY = 300,
        stringsCount = 10,
        fontSize = 8.2,
        fontFlag = 5,
        offsetStrings = 4,
        fontName = 'Calibri'
    } 
},file)

if not doesDirectoryExist(path) then
    createDirectory(path)
end
if not doesFileExist(path..'\\'..file) then
    inicfg.save(mainIni,file)
end

local windowstate = imgui.ImBool(false)
local renderChat = imgui.ImBool(mainIni.config.renderChat)
local removechat = imgui.ImBool(mainIni.config.removechat)
local tosampfuncs = imgui.ImBool(mainIni.config.tosampfuncs)
local sendmessageTime = imgui.ImBool(mainIni.config.sendmessageTime)
local stringsCount = imgui.ImInt(mainIni.config.stringsCount)
local fontSize = imgui.ImFloat(mainIni.config.fontSize)
local fontName = imgui.ImBuffer(tostring(mainIni.config.fontName), 100)
local fontFlag = imgui.ImInt(mainIni.config.fontFlag)
local offsetStrings = imgui.ImInt(mainIni.config.offsetStrings)
local vrchatMessages = {}

function reCreateFont(intSize,nameFont,intFontFlag)
    if font then
        renderReleaseFont(font)
    end
    font = renderCreateFont(nameFont,intSize,intFontFlag)
end

reCreateFont(fontSize.v,fontName.v,fontFlag.v)

POSITION_SET = false
function saveini()
    mainIni.config.renderChat = renderChat.v
    mainIni.config.removechat = removechat.v
    mainIni.config.tosampfuncs = tosampfuncs.v
    mainIni.config.stringsCount = stringsCount.v
    mainIni.config.sendmessageTime = sendmessageTime.v
    mainIni.config.fontSize = fontSize.v
    mainIni.config.fontName = fontName.v
    mainIni.config.fontFlag = fontFlag.v
    mainIni.config.offsetStrings = offsetStrings.v
    inicfg.save(mainIni,file)
end


function main()
    while not isSampAvailable() do wait(0) end
    sampRegisterChatCommand('vrchat',function() 
        windowstate.v = not windowstate.v
    end)
    sampAddChatMessage('[VR Chat Remover] {ffffff}Скрипт успешно загружен! {FD1818}Активация:{ffffff} /vrchat. {FD1818}Автор:{ffffff} ronnyscripts',0xFD1818)
    while true do 
        wait(0)
        imgui.Process = windowstate.v
        imgui.ShowCursor = windowstate.v
        if renderChat.v then
            local POSITION_X, POSITION_Y
            if POSITION_SET then
                POSITION_X, POSITION_Y = getCursorPos()
                if isKeyJustPressed(0x01) then
                    mainIni.config.posRenderX, mainIni.config.posRenderY = POSITION_X, POSITION_Y
                    POSITION_SET = false
                end
            else 
                POSITION_X, POSITION_Y = mainIni.config.posRenderX, mainIni.config.posRenderY
            end
            local heightChatRender = POSITION_Y
            for i = 0, stringsCount.v -1  do
                local message = table.maxn(vrchatMessages) - i
                if vrchatMessages[message] then
                    local textForRender = vrchatMessages[message].msg 
                    if table.maxn(vrchatMessages) > 0 then
                        renderFontDrawText(font, (sendmessageTime.v and vrchatMessages[message].time ..' ' or '' ) .. textForRender,POSITION_X,heightChatRender,-1)
                        heightChatRender = heightChatRender - (renderGetFontDrawHeight(font) + offsetStrings.v)
                    end
                end
            end
        end
    end
end

function imgui.OnDrawFrame()
    local sw,sh = getScreenResolution()
    if windowstate.v and not POSITION_SET then
        imgui.SetNextWindowPos(imgui.ImVec2(sw/2,sh/2),imgui.Cond.FirstUseEver,imgui.ImVec2(0.5,0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(950,500),imgui.Cond.FirstUseEver)
        imgui.Begin(u8('VR Chat Remover | v'..thisScript().version),windowstate,imgui.WindowFlags.HorizontalScrollbar)
        imgui.BeginGroup()
        if imgui.Button(u8('Сохранить настройки'),imgui.ImVec2(170,20)) then
            saveini()
        end
        imgui.SameLine()
        if imgui.Button(u8('Очистить чат'),imgui.ImVec2(170,20)) then
            vrchatMessages = {}
        end
        if imgui.Button(u8('Перезагрузить скрипт'),imgui.ImVec2(170,20)) then
            thisScript():reload()
        end
        imgui.SameLine()
        if imgui.Button(u8('Рендер чата'),imgui.ImVec2(170,20)) then
            imgui.OpenPopup('chatrender')
        end
        if imgui.BeginPopup('chatrender') then
            imgui.Checkbox(u8('Рендер чата(как pluschat)'),renderChat)
            if renderChat.v then
                imgui.PushItemWidth(150)
                imgui.InputInt(u8('Кол-во строк'),stringsCount)
                if imgui.Button(u8('Сменить положение'),imgui.ImVec2(imgui.GetWindowWidth() - 16,20)) then
                    sampAddChatMessage('[VR Chat Remover] {ffffff}Переместите чат в нужное для вас место и нажмите {FD1818}ЛКМ',0xFD1818)
                    POSITION_SET = true
                end
                imgui.InputInt(u8('Расстояние между строками'),offsetStrings)
                
                imgui.SliderFloat(u8('Размер шрифта'),fontSize,1,30)  
                imgui.InputInt(u8('Флаги текста'),fontFlag)
                imgui.InputText(u8('Название шрифта'),fontName)

                if imgui.Button(u8('Обновить шрифт'),imgui.ImVec2(imgui.GetWindowWidth() - 16,20)) then
                    reCreateFont(fontSize.v,fontName.v,fontFlag.v)
                end
                imgui.PopItemWidth()
            end
            imgui.EndPopup()
        end
        imgui.EndGroup()
        imgui.SameLine()
        imgui.BeginGroup()
        imgui.Checkbox(u8('Выключить /vr чат'),removechat)
        imgui.SameLine()
        imgui.Checkbox(u8('Включить время отправки'),sendmessageTime)
        imgui.Checkbox(u8('Выводить сообщения в консоль SAMPFUNCS'),tosampfuncs)
        imgui.EndGroup()
        imgui.Separator()
        imgui.CenterTextColored(u8('{FF2B2B}Вип Чат'))
        imgui.Separator()
        imgui.BeginChild('rendertextimguivr',imgui.ImVec2(imgui.GetWindowSize().x - 20,imgui.GetWindowSize().y - 110),true, imgui.WindowFlags.HorizontalScrollbar)
        if #vrchatMessages > 0  then
            local clipper = imgui.ImGuiListClipper(#vrchatMessages)
            while clipper:Step() do
                for i = clipper.DisplayStart + 1, clipper.DisplayEnd do
                    imgui.TextColoredRGB(u8(vrchatMessages[i].time..' '..vrchatMessages[i].msg))
                end
            end
        else
            imgui.CenterWindowText(u8('Тут пусто как-то..'),imgui.TextDisabled)
        end
        imgui.EndChild()
        imgui.End()
    end
end

function sampev.onServerMessage(color,text)
    if text:find('{6495ED}%[VIP%] {FFFFFF}(.+)%[(%d+)%]:(.+)') or text:find('{F345FC}%[PREMIUM%] {FFFFFF}(.+)%[(%d+)%]:(.+)') or text:find('{FCC645}%[ADMIN%]{FFFFFF} (.+)%[%d+%]:(.+)') then
        table.insert(vrchatMessages, {
            time = os.date('[%H:%M:%S]'),
            msg = text
        })
        if tosampfuncs.v then
            print((sendmessageTime.v and  os.date('[%H:%M:%S]') ..' ' or '' ) ..text)
        end
        if removechat.v then
            return false
        end
    end
end

function imgui.CenterText(text) 
	local width = imgui.GetWindowWidth()
	local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(text)
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
            local text_width = imgui.CalcTextSize((textsize))
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
                    imgui.TextColored(colors_[i] or colors[1], (text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else
                imgui.Text((w))
            end
        end
    end
    render_text(text)
end

function imgui.CenterTextColored(text) 
    local text2 = text:gsub('{(......)}','') 
	local width = imgui.GetWindowWidth()
	local calc = imgui.CalcTextSize(text2)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.TextColoredRGB(text)
end

function imgui.CenterWindowText(text,typetext)
    typetext = typetext or imgui.Text
    local windSZ = imgui.GetWindowSize()
    if typetext == imgui.TextColoredRGB then
        local imguiRenderText = text
        text = text:gsub('{(......)}','')
        local txtSZ = imgui.CalcTextSize(text)
        imgui.SetCursorPos(imgui.ImVec2(windSZ.x/2 - txtSZ.x / 2,windSZ.y/2 - txtSZ.y / 2))
        typetext(imguiRenderText)
    else
        local txtSZ = imgui.CalcTextSize(text)
        imgui.SetCursorPos(imgui.ImVec2(windSZ.x/2 - txtSZ.x / 2,windSZ.y/2 - txtSZ.y / 2))
        typetext(text)
    end
end

function onWindowMessage(msg, wparam, lparam)
	if msg == 0x100 or msg == 0x101 then
		if (wparam == 0x1B and windowstate.v) and not isPauseMenuActive() then
			consumeWindowMessage(true, false)
			if msg == 0x101 then
				windowstate.v = false
			end
        end
    end
end

function theme()
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
end
theme()