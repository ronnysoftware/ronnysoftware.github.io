script_name('ARZ Assistant') 
script_author('Ronny_Wright or ronnysoftware')
script_version('25.0.3.winter1')
script_properties('work-pause')
--path script folder
local path = getWorkingDirectory() .. "\\ARZ Assistant"

print('Если у вас не запустился скрипт скачайте библиотеки для скрипта')
print('Ссылка находится в Telegram канале разработчика - https://t.me/ronnysoftware')

local dlstatus = require('moonloader').download_status
if not doesDirectoryExist(path) then
	createDirectory(path)
end
if not doesFileExist(path..'\\fontawesome-webfont.ttf') then
	print('Скачиваю шрифт для fIcons.lua')
	downloadUrlToFile('https://ronnysoftware.github.io/reposdata/addons/fontawesome-webfont.ttf',path..'\\fontawesome-webfont.ttf')
end 
if not doesFileExist(path..'\\azlogo160px.png') then
	print('Скачиваю лого для скрипта')
	downloadUrlToFile('https://ronnysoftware.github.io/reposdata/addons/azlogo160px.png',path..'\\azlogo160px.png')
end 
local code_notifications = [[local imgui_notf = require 'imgui'
local style = imgui_notf.GetStyle()
local colors = style.Colors
local clr = imgui_notf.Col
local ImVec4 = imgui_notf.ImVec4
local encoding = require 'encoding'
u8 = encoding.UTF8
encoding.default = 'CP1251'
imgui_notf.GetStyle().WindowMinSize = imgui_notf.ImVec2(1.0, 1.0)
local ToScreen = convertGameScreenCoordsToWindowScreenCoords
local sX, sY = ToScreen(630, 438)
local message = {}
local msxMsg = 3
local notfList = {
	pos = {
		x = sX - 200,
		y = sY
	},
	npos = {
		x = sX - 200,
		y = sY
	},
	size = {
		x = 200,
		y = 0
	}
}
function setstyle()
	style.WindowRounding = 2.0
	style.WindowTitleAlign = imgui_notf.ImVec2(0.5, 0.5)
	style.ChildWindowRounding = 2.0
	style.FrameRounding = 2.0
	style.ItemSpacing = imgui_notf.ImVec2(5.0, 4.0)
	style.ScrollbarSize = 13.0
	style.ScrollbarRounding = 0
	style.GrabMinSize = 8.0
	style.GrabRounding = 1.0
	-- style.Alpha =
	style.WindowPadding = imgui_notf.ImVec2(4.0, 4.0)
	style.WindowMinSize = imgui_notf.ImVec2(1.0, 1.0)
	style.FramePadding = imgui_notf.ImVec2(3.5, 3.5)
	-- style.ItemInnerSpacing =
	-- style.TouchExtraPadding =
	-- style.IndentSpacing =
	-- style.ColumnsMinSpacing = ?
	style.ButtonTextAlign = imgui_notf.ImVec2(0.0, 0.5)
	-- style.DisplayWindowPadding =
	-- style.DisplaySafeAreaPadding =
	-- style.AntiAliasedLines =
	-- style.AntiAliasedShapes =
	-- style.CurveTessellationTol =

	colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
	colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.71)
	colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
	colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
	colors[clr.ComboBg]                = colors[clr.PopupBg]
	colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
	colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.FrameBg]                = ImVec4(0.12, 0.12, 0.12, 0.94)
	colors[clr.FrameBgHovered]         = ImVec4(0.45, 0.45, 0.45, 0.85)
	colors[clr.FrameBgActive]          = ImVec4(0.63, 0.63, 0.63, 0.63)
	colors[clr.TitleBg]                = ImVec4(0.13, 0.13, 0.13, 0.99)
	colors[clr.TitleBgActive]          = ImVec4(0.13, 0.13, 0.13, 0.99)
	colors[clr.TitleBgCollapsed]       = ImVec4(0.05, 0.05, 0.05, 0.79)
	colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
	colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
	colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
	colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
	colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
	colors[clr.CheckMark]              = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.SliderGrab]             = ImVec4(0.28, 0.28, 0.28, 1.00)
	colors[clr.SliderGrabActive]       = ImVec4(0.35, 0.35, 0.35, 1.00)
	colors[clr.Button]                 = ImVec4(0.12, 0.12, 0.12, 0.94)
	colors[clr.ButtonHovered]          = ImVec4(0.34, 0.34, 0.35, 0.89)
	colors[clr.ButtonActive]           = ImVec4(0.21, 0.21, 0.21, 0.81)
	colors[clr.Header]                 = ImVec4(0.12, 0.12, 0.12, 0.94)
	colors[clr.HeaderHovered]          = ImVec4(0.34, 0.34, 0.35, 0.89)
	colors[clr.HeaderActive]           = ImVec4(0.12, 0.12, 0.12, 0.94)
	colors[clr.Separator]              = colors[clr.Border]
	colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
	colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
	colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
	colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
	colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
	colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
	colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
	colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
	colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
	colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
	colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end
setstyle()
function main()
	while true do
		wait(0)
		imgui_notf.ShowCursor = false
		imgui_notf.Process = true
	end
end
function imgui_notf.OnDrawFrame()
	onRenderNotification()
end
function onRenderNotification()
	local count = 0
	for k, v in ipairs(message) do
		local push = false
		if v.active and v.time < os.clock() then
			v.active = false
		end
		if count < 10 then
			if not v.active then
				if v.showtime > 0 then
					v.active = true
					v.time = os.clock() + v.showtime
					v.showtime = 0
				end
			end
			if v.active then
				count = count + 1
				if v.time + 3.000 >= os.clock() then
					imgui_notf.PushStyleVar(imgui_notf.StyleVar.Alpha, (v.time - os.clock()) / 1.0)
					push = true
				end
				local nText = u8(tostring(v.text))
				notfList.size = imgui_notf.GetFont():CalcTextSizeA(imgui_notf.GetFont().FontSize, 200.0, 196.0, nText)
				notfList.pos = imgui_notf.ImVec2(notfList.pos.x, notfList.pos.y - (notfList.size.y + (count == 1 and 8 or 13)))
				imgui_notf.SetNextWindowPos(notfList.pos, _, imgui_notf.ImVec2(0.0, 0.0))
				imgui_notf.SetNextWindowSize(imgui_notf.ImVec2(200, notfList.size.y + imgui_notf.GetStyle().ItemSpacing.y + imgui_notf.GetStyle().WindowPadding.y))
				imgui_notf.Begin(u8'##msg' .. k, _, imgui_notf.WindowFlags.NoCollapse + imgui_notf.WindowFlags.NoResize + imgui_notf.WindowFlags.NoScrollbar + imgui_notf.WindowFlags.NoMove + imgui_notf.WindowFlags.NoTitleBar)
				imgui_notf.TextWrapped(nText)
				imgui_notf.End()
				if push then
					imgui_notf.PopStyleVar()
				end
			end
		end
	end
	sX, sY = ToScreen(630, 438)
	notfList = {
		pos = {
			x = sX - 200,
			y = sY
		},
		npos = {
			x = sX - 200,
			y = sY
		},
		size = {
			x = 200,
			y = 0
		}
	}
end
function EXPORTS.addNotification(text, time)
	message[#message+1] = {active = false, time = 0, showtime = time, text = text}
end]]

function load_notf_lib()
	bNotf, notf = pcall(import, "ARZ Assistant\\arz_imgui_notf.lua")
	return bNotf
end

function whileNotLoad()
	local is_load = load_notf_lib()
	if not is_load then
		load_notf_lib()
		return
	end
end

if not doesFileExist('moonloader/ARZ Assistant/arz_imgui_notf.lua') then
	local f = io.open('moonloader/ARZ Assistant/arz_imgui_notf.lua', "w")
	if f then
		f:write(code_notifications)
		f:close()
		whileNotLoad()
	else
		whileNotLoad()
	end
else
	load_notf_lib()
end

--Libs---------------------
--эти вроде в самом луа есть
local ffi = require("ffi")
local bit = require("bit")
local inicfg = require ('inicfg')
local memory = require('memory')
local encoding = require('encoding') 
local vkeys = require("vkeys")
--а эти над докачивать
local bSocket, socket = pcall(require,"socket")
print('[check libs] socket '..tostring(bSocket))
local bEffil, effil = pcall(require,'effil')
print('[check libs] effil '..tostring(bEffil))
local bImgui, imgui = pcall(require, 'imgui')
print('[check libs] imgui '..tostring(bImgui))
local bFa,fa = pcall(require,'faIcons')
print('[check libs] faicons for imgui'..tostring(bFa))
local bMad, mad = pcall(require,'MoonAdditions')
print('[check libs] moonadditions '..tostring(bMad))
local bPie,pie = pcall(require,'imgui_piemenu')
print('[check libs] piemenu for imgui '..tostring(bPie))
local bImadd,imadd = pcall(require, 'imgui_addons')
print('[check libs] addons for imgui '..tostring(bImadd))
local bSampev,sampev = pcall(require,'lib.samp.events')
print('[check libs] samp.lua '..tostring(bSampev))

--sets encode for imgui and other
encoding.default = 'CP1251'
u8 = encoding.UTF8

--sets font awesome 
local fa_font = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })

--path accs for autofill
local file = path .. "\\accs.json"
--table with data for autofill
dialogChecker = {
	check = false,
	id = -1,
	title = ""
}
editpass = {
	numedit = -1,
	input = imgui.ImBuffer('',500)
}

temppass = {} --tempary passwords
savepass = {} --saved pass
--read passwords
if doesFileExist(file) then
	local f = io.open(file, "r")
	if f then
		savepass = decodeJson(f:read("a*"))
		f:close()
	end
end
-- input helper / ffi
ffi.cdef[[
	short GetKeyState(int nVirtKey);
	bool GetKeyboardLayoutNameA(char* pwszKLID);
	int GetLocaleInfoA(int Locale, int LCType, char* lpLCData, int cchData);
]]
local BuffSize = 32
local KeyboardLayoutName = ffi.new("char[?]", BuffSize)
local LocalInfo = ffi.new("char[?]", BuffSize)
chars = {
	["й"] = "q", ["ц"] = "w", ["у"] = "e", ["к"] = "r", ["е"] = "t", ["н"] = "y", ["г"] = "u", ["ш"] = "i", ["щ"] = "o", ["з"] = "p", ["х"] = "[", ["ъ"] = "]", ["ф"] = "a",
	["ы"] = "s", ["в"] = "d", ["а"] = "f", ["п"] = "g", ["р"] = "h", ["о"] = "j", ["л"] = "k", ["д"] = "l", ["ж"] = ";", ["э"] = "'", ["я"] = "z", ["ч"] = "x", ["с"] = "c", ["м"] = "v",
	["и"] = "b", ["т"] = "n", ["ь"] = "m", ["б"] = ",", ["ю"] = ".", ["Й"] = "Q", ["Ц"] = "W", ["У"] = "E", ["К"] = "R", ["Е"] = "T", ["Н"] = "Y", ["Г"] = "U", ["Ш"] = "I",
	["Щ"] = "O", ["З"] = "P", ["Х"] = "{", ["Ъ"] = "}", ["Ф"] = "A", ["Ы"] = "S", ["В"] = "D", ["А"] = "F", ["П"] = "G", ["Р"] = "H", ["О"] = "J", ["Л"] = "K", ["Д"] = "L",
	["Ж"] = ":", ["Э"] = "\"", ["Я"] = "Z", ["Ч"] = "X", ["С"] = "C", ["М"] = "V", ["И"] = "B", ["Т"] = "N", ["Ь"] = "M", ["Б"] = "<", ["Ю"] = ">"
}

--all text for VK, TG, ChangeLog and other
howsetVK = [[
Где взять Token?
1. Создайте группу VK для уведомлений
2. Зайдите в Управление -> Настройки -> Работа с API -> Ключи доступа
3. Нажмите создать ключ
4. Выберите 2 пункта:
Разрешить приложению доступ к управлению сообществом
Разрешить приложению доступ к сообщениям сообщества
5. Нажмите "Создать"
6. Если требуется подтвердите действие
7. После этого у вас появится токен, скопируйте его и вставьте в поле "Ваш Token Группы"

Как настроить команды !getstats, !getinfo и др.?

Переходим во вкладку "Long Poll API", в подвкладке "Настройки" включаем его, выбираем версию 5.80
В "Типы событий" ставим галочку на входящее сообщение. Готово!
Во вкладке "Сообщения" справа включаем сообщения сообщества и не забываем сразу же разрешить 
сообщения от сообщества с главной страницы группы или просто что-то пишем в сообщения группы.
Теперь необходимо так-же активировать возможности ботов в группе: 
Управление - Сообщения - Настройки ботов - Возможности ботов - Включены
В скрипте нужно будет заполнить ID группы, которой мы создали выше.
p.s если ID группы не в виде числа, вы можете его добыть в диалоге с группой
	Например: ссылка на диалог: https://vk.com/im?sel=-194187813, где 194187813 это ID группы 
p.s.s если у вас не было до этого ID группы, сохраните настройки и нажмите "Переподключение к серверам"

Где взять VK ID?
Самый простой способ
1. Зайдите в "Настройки"
2. В поле "Адрес страницы" нажмите "Изменить"
3. Над кнопкой "Сохранить" будет текст - "Номер страницы - (цифры)". Эти цифры и есть ваш VK ID
4. Перепишите эти цифры в поле "Ваш VK ID" 

Сохраните
Напишите что-то в вашу группу
Теперь, вы можете проверить уведомления нажав кнопку "Проверить" 
]]
howsetTG = [[
Где взять Token?
1. Заходим в Telegram и находим бота @BotFather, ждем или пишем /start
2. Далее пишем /newbot
3. Пишем название бота, например: Notf Bot Arz
4. Пишем имя бота, например: arznotf_bot
5. Копируем токен который нам вывел бот и вставляем в поле Token


Где взять ChatID?
1. Заходим в Telegram и находим бота @userinfobot, жмём или пишем /start	
Далее, он нам отправил сообщение, в котором вам нужно скопировать циферки после слова Id. Пример: Id: 184844834
2. Вставляем циферки в поле ChatID


Сохраните
Напишите что-то своему боту
Теперь, вы можете проверить уведомления нажав кнопку "Проверить"]]
helplist = [[
Данный скрипт был создан для упрощения игры на Arizona RP.
В нем собрано много полезных функций которые упростят вам игру, большинство вы можете настроить в левой 
части меню
Команды скрипта:
	/arz - открыть это окно
	/calc - калькулятор. Пример: /calc 2+2*2
	/rep - быстрый репорт
	/nid - модифицированный /id. Пример: /nid Ronny
	/de, m4, sh, rf - быстро достать ган из инвентаря(ган должен быть на 1 странице инвентаря)
	/stoprec - остановить reconnect и autoreconnct
	/cload - загрузить кар по его номеру в /cars. Пример: /cload 2
	/cloadstop - остановить загрузку кара
	/aeat, /aheal - похавать/похиллится через текстдрав(уже не работает, только в доме из минибара)
	/fc - зареспавнить кар по его номеру в /cars. Пример: /fc 2
	/pis - вызывает опкод 0afd:68(поссать)
	/bizpiar - активирует Пиар Бизнесов
	/cc - очистка чата
	/rc - реконнект, если нет аргумента перезайдет через 1 сек. Пример: /rc 15
	/rcn - реконнект под новым ником с задержкой 1 сек. Пример: /rcn Ronny_Wright
	/getid - Узнает ID игрока по его полному нику. Пример: /getid Ronny_Wright
	/ahrl - перезагружает скрипт
	/arzunload - выгружает скрипт
	/fh - сокращенная команда /findihouse
	/fbiz - сокращенная команда /findibiz
	/phn - сокращенная команда /phone(если включен пункт "Телефон")
	/chatoff - выключает чат

Функции о которых можно узнать только в этой вкладке:
	Копировать ник нажав на него 2 раза в табе
]]
changeloglist =[[
{color}Версия v25.0.3.winter1
•С обновой владельцы Premium VIP могут иметь 20 каров, поэтому сменил лимит max каров для /cload и /fc(с 5 до 20)
{color}Версия v25.0.3
•Фиксы говна
{color}Версия v25.0.2
•Фикс некоторых настроек
•Добавлен режим выбора когда хавать для автохавки
•Добавлен центр обновлений
{color}Версия v25.0.1 
•Фикс краша скрипта при автохиле
{color}Версия v25 - Global
•Был изменен конфиг, теперь, настройки хранятся в папке "ARZ Assistant" в файле "arz_assistant_settings.ini"
•Изменен дизайн скрипта
•При скипе диалогов оправляется RPC о том, что вы нажали кнопку 0(отмена), нейкий фикс когда нельзя нажать на текстдравы
•Добавлен тихий режим - вместо обычных уведомлений они отправляются в консоль SAMPFUNCS(если у вас есть скрипт SF Integration, а так их просто не будет видно)
•Оптимизированы диалоги
	и много другое но мне лень писать
{color}Версия v24
•В управление игрой через Telegram / VK добавлена команда !gethun(узнать голод). А в VK еще и кнопка
{color}Версия v23.6
•Новые функции: Кто меня убил?
{color}Версия v23.4
•Новые функции: AntiLomka
•Фикс Telegram
{color}Версия v23.3
•Новые команды: /calc(калькулятор)
•Теперь, для телеграма тоже есть управление игрой!
	Команды:
		!getstats - статистика персонажа /stats 
		!getinfo - получение кол-во хп и арм
		!lastchat (кол-во) - получение строк из чата
		!sendchat (текст) - отправить сообщение из Telegram в чат
{color}Версия v23.2
•Новые функции: AntiScare
•Переписал функцию принятия уведомлений
•Теперь автохилл не флудит
{color}Версия v23
•Теперь библиотека для уведомлений не скачивается, а сама записывается(технологии...)
•Добавил событие в уведомления - Если игрок нанесёт персонажу дамаг 
•Автоподключение при "You are banned from this server" если включен автореконнект
•Загрузка авто на хуке диалога(еееее)
•В Пиар бизнесов добавлен антинпвр
•Новые функции:
	ReSend /vr(смотреть в /arz) 
	New Marker Color(смена цвета маркера) 
	Fisheye
•Новые команды: 
	/nid(модифицированный ид(только на ники)) 
	/cloadstop(останавливает загрузку авто)
	/stoprec(стопает реконнект)
•Получение информации из игры через вк: 
	!getstats - статистика персонажа /stats 
	!getinfo - получение кол-во хп и арм
	!lastchat (кол-во) - получение строк из чата
	!sendchat (текст) - отправить сообщение из VK в чат
•Так-же в диалоге в ВК вашего сообщества появятся кнопки WASD - управление персонажем. 
	При нажатии кнопки она остается зажатой на 2 сек 
	Используйте их не часто(раз в пару секнуд) дабы не вызвать краш	
{color}Версия v22.5
	•Новые функции: Рендер открытых/закрытых авто
	•Добавил новую тему - Dark BlastHack
	•Добавил событие в уведомления - При смерти
{color}Версия v22.4
	•Новые функции: Уведомления ВК
	•Новые команды: /rep(заменяет серверную команду /rep), Fastgun: /de,/m4,/sh,/rf
	•В уведомления добавлено новое событие отправки уведомлений
	•Фиксы багов
{color}Версия v22.3
	Внимание! Т.к. токен бота был сменён, добавьте токен в окне настроек
	•Новые команды: /cload
{color}Версия v22.2
	•Hot-fix иконок
{color}Версия v22.1
	•Меню теперь на русском
	•Смена шрифта для иконок
	•В уведомления Telegram добавлено 1 новое событие отправки уведомления
	•Добавлены новые темы и стили в меню
{color}Версия v22
	•Новые функции: Bhop 
	•В AutoEat добавлен Разраб. мод(показ ид текстдравов на экране)
	•В Autofill добавлены кнопки "Подключиться" и "Сменить пароль"
{color}Версия v21
	•Новые функции: 
	•Autofill(автозаполнение в диалоги, можно юзать как автологин),
	•InputHelper(скрипт от DonHomka), AutoEat(обычная автохавка)
	•Новые команды /aheal и /aeat
	•Фикс Reconnect'a(вроде точно фикс) 
{color}Версия v21 beta
	•Сменён способ авторекона(с строк на хук, вроде должно работать с лаунчером Аризоны)
	•Немного оптимизировал
{color}Версия v20.2
	•Hot-fix багов
{color}Версия v20
	•Новые функции: AutoBreak, Акцент, Бесконечный бег, Очистка фигни от сервера в чате
	•Новые команды: /chatoff 
	•Оптимизация AdminSpec
	•Теперь онлайн за день сохраняется при краше игры(если краш игры не связан с крашем скрипта)
{color}Версия v19
	•Changelog теперь на ImGui
	•Новые функции: ShieldControl, Fastconnect
	•Изменена функция "Быстрое нажатие шифт" на "Быстрый бег"
	•Новый раздел: Репозиторий
	•Теперь все сообщения от скрипта будут уведомлениями
{color}Версия v18
	•Добавлен новый способ оповещения
	•Секундомер на маску и таймер кд для армора
	•Автосбив анимации из /anim
	•Уведомления в Telegram
	•Фиксы и маленькие нововведения
{color}Версия v17
	•Обновлено основное окно
	•Добавлена смена кнопок для PieMenu и RPDM
	•Обновлён селектор PieMenu
	•Для AdminSpec добавлена возможность сменить уведомление о слежке
	•Поссать - /pis (Для деактивации нажмите "Enter")
{color}Версия v16
	•AntiAFK теперь работает не в оконном режиме
	•Фикс поздравлялки в VR
{color}Версия v14
	•Фикс багов с онлайном за день(при краше не сохранятется онлайн ну ачё)
	•AntiBlockedPlayer
	•AntiAFK
	•HPHUD
	•AdminSpec
	•Автозаправка
	•Исправление багов
]]


-------------------------FIXES----------------------------------
-- Фикс зеркального бага alt+tab(черный экран или же какая то хуйня в виде зеркал на экране после разворота в инте)
writeMemory(0x555854, 4, -1869574000, true)
writeMemory(0x555858, 1, 144, true)
-------------------------FIXES----------------------------------


--Переменные------
local path_ini = '..\\ARZ Assistant\\arz_assistant_settings.ini'

local mainIni = inicfg.load({
    config = { -- основные
        silentmode = false, -- тихий режим
        autoupdateenable = true, -- автообновление
        theme = 0, -- тема скрипта
        styletheme = 0, -- стиль скрипта
        antilomka = false, -- антиломка
        antiscare = false, -- антимаска
        send_sms_if_vip = false, -- отправлять сообщение в /vr если чел купит вип
        sms_vr_vip = '', -- сообщение при покупке титанки
        sms_vr_prem = '', -- сообщение при покупке премиум
        time_act = false, -- врубить отыгровку часов
        time_text = '', -- текст отыгровки
        message_catch_state = false, -- врубить сообщение после ловли
        message_catch = '', -- сообщение после ловли
        fam_messages = false, -- отправлять сообщения при инвайте|получении нового уровня в семье
        fam_invite = '', -- сообщение при инвайте в фаму
        fam_lvlup = '', -- сообщение при получении нового уровня в семье
        accent_state = false, -- активация акцента 
        accent_text = '', -- текст акцента
        rpdm_act = false, -- rpdm
        rpdm_text = '', -- текст RPDM
        rpdm_keys = encodeJson({0x5A}), -- активация RPDM
        piemenu_act = false, --piemenu
        piemenu_keys = encodeJson({0x58}), -- активация piemenu
        fastrun_act = false, --быстрый бег
        fastrun_keys = encodeJson({0x72}), -- активация быстрого бега
        render_cardoors_state = false, -- рендер состояния дверей
        armour_info = false, -- Таймер Брони
        mask_timer = false, -- таймер маски
        infrun = false, -- бесконечный бег 
        fastconnect = false, -- фастконнект
        auto_knock = false, --автосбив /anim
        light_from_lanterns = false, -- свет от фонарей
        auto_fill_gas = false, -- автозаправка
        phone_cheatcode = false, -- достать телефон читкодом PH
        binds_lock = false, -- закрыть авто /lock на L
        binds_olock = false, -- закрыть авто /olock на O
        binds_jlock = false, -- закрыть авто /jlock на J
        binds_key = false, --/key на K
        binds_mask = false, -- бинд /mask читкодом MASK
        binds_armour = false, -- бинд /armour читкодом ARMOUR 
        binds_text_armour = false, -- бинды /do если надел/снял/нет бронижилет(а)
        returnmessageforvr = false, -- переотправка сообщения /vr если там ошибка с 1 сек
        enable_autofill = true, -- автоввод сохраненного текста в диалоги
        fisheye = false, -- рыбий глаз
        fisheye_rad = 101, -- радиус глаза
        newmarkercolor = false, -- новый цвет маркера
        newmarkercolor_rainbow = false, -- маркер: режим затухания
        fromSecToMinInDemoran = false, -- форматирование времени в деморгане из "x SEC." в "x SEC. = x MIN."
        shieldcontrol = false, -- авто зажатие alt + c для щита
		auto_rec = false,	--авторекон
		auto_rec_if_banned = false, -- авторек при you are banned
        auto_rec_wait = 30, -- задержка для автореконнекта
        autobreak = false, -- автовзлом кара
        hp_hud = false, -- хпхуд
        floodclear = false, -- очистка флуда в чате
        inputhelper = false, -- inputhelper
        bhop = false, -- bunnyhop
        antiblockplayer = false, -- легко выйти из чела в больке
        whokillme = false -- кто убил меня
	},
	info = {
		date = '0',
		timeonline = 0
	},
	markcolor = {
		r=190,
		g=0,
		b=0
	},
	eat = { -- автохавка
		checkmethod = 0, -- выбор как будет определять что надо жрать
		eat2met = 0, -- при скольки % голода жрать
        eatmetod = 0, -- выбор будет жрать или нет и какм способом
        setmetod = 0, -- каким способом жрать вне дома
	    arztextdrawid = '648', -- ид хавки через текстдрав( ТОЛЬКО ДОМА )
	    arztextdrawidheal = '646', -- ид хила через текстдрав ( ТОЛЬКО ДОМА)
	    healstate = false, -- врубить автохил
	    hplvl = 30, -- уровень хп при котором надо хиллится
	    hpmetod = 0, -- метод каким будет хиллит
	    drugsquen = 1 -- кол-во нарко для хила
	},
    notifications = { --настройки уведомлений
        --vk
        send_vk = false,
        vk_token = '', --токен группы
        user_id = '', -- ваш VKID
        group_id = '', -- VKID вашей группы
        --telegram
        send_tg = false,
        tg_token = '', -- токен вашего бота
        chat_id = '', -- ваш chatid
        --send sets
        if_join = false,
        if_kick = false,
        if_hungry = false,
        if_admin = false,
        if_script_err = false,
        if_dead = false,
        if_damage = false
    }, 
    skipdialogs = { -- настройки скипа диалогов
        state_skips = false,
        tradedialog = false,
        admin_report = false,
        pizza = false,
        dmzz = false,
        taxes = false,
        military_base = false,
        pin_code = false
    },
    arz_assistant_window = { -- настройки доп. окна
        show_window = false,
        position = encodeJson({50,50}),
        showname = false, 
        showlvl = false,
        showping = false,
        showfps = false,
        show_hp_and_arm = false,
        show_session_time = false,
        show_day_time = false,
        showdate = false
    },
    biz_piar = { --настройки бизпиара
        anti_mute = false,
        piar_string_1 = '',
        add_2_str = false,
        piar_string_2 = '',
        add_3_str = false,
        piar_string_3 = '',
        wait = 30
    }
},path_ini)

function saveIniFile()
    local inicfgsaveparam = inicfg.save(mainIni,path_ini)
end
saveIniFile()


-- создание переменных
-- функция создания таблицы 
function imgui.ImHotKey(tableHotKeys)
	if type(tableHotKeys) == 'table' then
		return {v = tableHotKeys}
	else
		return {v = {}}	
	end
end
--silentmode
local silentmode 				= 	imgui.ImBool(mainIni.config.silentmode)
--автообнова вкл выкл
local autoupdateenable 			= 	imgui.ImBool(mainIni.config.autoupdateenable)
-- тема скрипта
local imgui_theme 				= 	imgui.ImInt(mainIni.config.theme)
local imgui_theme_style 		= 	imgui.ImInt(mainIni.config.styletheme)
-- настройки, секция [config]
local antilomka 				= 	imgui.ImBool(mainIni.config.antilomka)
local antiscare 				= 	imgui.ImBool(mainIni.config.antiscare)

local send_sms_if_vip 			=	imgui.ImBool(mainIni.config.send_sms_if_vip)
local sms_vr_vip				= 	imgui.ImBuffer(u8(tostring(mainIni.config.sms_vr_vip)),256)
local sms_vr_prem				= 	imgui.ImBuffer(u8(tostring(mainIni.config.sms_vr_prem)),256)

local time_act 					= 	imgui.ImBool(mainIni.config.time_act)
local time_text 				= 	imgui.ImBuffer(u8(tostring(mainIni.config.time_text)),256)

local message_catch_state 		=	imgui.ImBool(mainIni.config.message_catch_state)
local message_catch				=	imgui.ImBuffer(u8(tostring(mainIni.config.message_catch)),256)

local fam_messages 				= 	imgui.ImBool(mainIni.config.fam_messages)
local fam_invite				= 	imgui.ImBuffer(u8(tostring(mainIni.config.fam_invite)),256)
local fam_lvlup					= 	imgui.ImBuffer(u8(tostring(mainIni.config.fam_lvlup)),256)

local accent_state				=	imgui.ImBool(mainIni.config.accent_state)
local accent_text				= 	imgui.ImBuffer(u8(tostring(mainIni.config.accent_text)),256)

local rpdm_act					=	imgui.ImBool(mainIni.config.rpdm_act)
local rpdm_text 				= 	imgui.ImBuffer(u8(tostring(mainIni.config.rpdm_text)),256)
local rpdm_keys					= 	imgui.ImHotKey(decodeJson(mainIni.config.rpdm_keys))

local piemenu_act				=	imgui.ImBool(mainIni.config.piemenu_act)
local piemenu_keys				=	imgui.ImHotKey(decodeJson(mainIni.config.piemenu_keys))

local fastrun_act				=	imgui.ImBool(mainIni.config.fastrun_act)
local fastrun_keys				=	imgui.ImHotKey(decodeJson(mainIni.config.fastrun_keys))

local render_cardoors_state		=	imgui.ImBool(mainIni.config.render_cardoors_state)

local armour_info				=	imgui.ImBool(mainIni.config.armour_info)
local mask_timer				=	imgui.ImBool(mainIni.config.mask_timer)

local infrun					=	imgui.ImBool(mainIni.config.infrun)

local fastconnect				= 	imgui.ImBool(mainIni.config.fastconnect)

local auto_knock				=	imgui.ImBool(mainIni.config.auto_knock)

local light_from_lanterns		=	imgui.ImBool(mainIni.config.light_from_lanterns)

local auto_fill_gas				=	imgui.ImBool(mainIni.config.auto_fill_gas)

local phone_cheatcode			=	imgui.ImBool(mainIni.config.phone_cheatcode)

local binds_lock				=	imgui.ImBool(mainIni.config.binds_lock)
local binds_olock				=	imgui.ImBool(mainIni.config.binds_olock)
local binds_jlock				=	imgui.ImBool(mainIni.config.binds_jlock)
local binds_key					=	imgui.ImBool(mainIni.config.binds_key)
local binds_mask				=	imgui.ImBool(mainIni.config.binds_mask)
local binds_armour				=	imgui.ImBool(mainIni.config.binds_armour)
local binds_text_armour			=	imgui.ImBool(mainIni.config.binds_text_armour)

local returnmessageforvr		=	imgui.ImBool(mainIni.config.returnmessageforvr)

local enable_autofill			=	imgui.ImBool(mainIni.config.enable_autofill)

local fisheye					=	imgui.ImBool(mainIni.config.fisheye)
local fisheye_rad				=	imgui.ImInt(mainIni.config.fisheye_rad)

local newmarkercolor			=	imgui.ImBool(mainIni.config.newmarkercolor)
local markcolor 				=	imgui.ImFloat3(mainIni.markcolor.r / 255, mainIni.markcolor.g / 255, mainIni.markcolor.b / 255)
local newmarkercolor_rainbow	=	imgui.ImBool(mainIni.config.newmarkercolor_rainbow)

local fromSecToMinInDemoran		=	imgui.ImBool(mainIni.config.fromSecToMinInDemoran)

local shieldcontrol				=	imgui.ImBool(mainIni.config.shieldcontrol)

local auto_rec					=	imgui.ImBool(mainIni.config.auto_rec)
local auto_rec_if_banned		=	imgui.ImBool(mainIni.config.auto_rec_if_banned)
local auto_rec_wait				=	imgui.ImInt(mainIni.config.auto_rec_wait)

local autobreak					=	imgui.ImBool(mainIni.config.autobreak)

local hp_hud					=	imgui.ImBool(mainIni.config.hp_hud)

local floodclear 				=	imgui.ImBool(mainIni.config.floodclear)

local inputhelper				=	imgui.ImBool(mainIni.config.inputhelper)

local bhop						=	imgui.ImBool(mainIni.config.bhop)

local antiblockplayer			=	imgui.ImBool(mainIni.config.antiblockplayer)

local whokillme					=	imgui.ImBool(mainIni.config.whokillme)

--автоеда, секция [eat]
local checkmethod				= 	imgui.ImInt(mainIni.eat.checkmethod)
local eat2met					= 	imgui.ImInt(mainIni.eat.eat2met)
local eatmetod					= 	imgui.ImInt(mainIni.eat.eatmetod)
local setmetod					= 	imgui.ImInt(mainIni.eat.setmetod)

local arztextdrawid				= 	imgui.ImInt(mainIni.eat.arztextdrawid)
local arztextdrawidheal			= 	imgui.ImInt(mainIni.eat.arztextdrawidheal)

local healstate					=	imgui.ImBool(mainIni.eat.healstate)
local hplvl						= 	imgui.ImInt(mainIni.eat.hplvl)
local hpmetod					= 	imgui.ImInt(mainIni.eat.hpmetod)
local drugsquen					= 	imgui.ImInt(mainIni.eat.drugsquen)

--уведомления, секция [notifications]
local send_vk 					= 	imgui.ImBool(mainIni.notifications.send_vk)
local vk_token 					= 	imgui.ImBuffer(tostring(mainIni.notifications.vk_token),300) 
local user_id 					= 	imgui.ImBuffer(tostring(mainIni.notifications.user_id),300) 
local group_id 					= 	imgui.ImBuffer(tostring(mainIni.notifications.group_id),300)

local send_tg 					= 	imgui.ImBool(mainIni.notifications.send_tg)
local tg_token 					= 	imgui.ImBuffer(tostring(mainIni.notifications.tg_token),300) 
local chat_id 					= 	imgui.ImBuffer(tostring(mainIni.notifications.chat_id ),300)
 
local if_join 					= 	imgui.ImBool(mainIni.notifications.if_join)
local if_kick 					= 	imgui.ImBool(mainIni.notifications.if_kick)
local if_hungry 				= 	imgui.ImBool(mainIni.notifications.if_hungry)
local if_admin 					= 	imgui.ImBool(mainIni.notifications.if_admin)
local if_script_err 			= 	imgui.ImBool(mainIni.notifications.if_script_err)
local if_dead 					= 	imgui.ImBool(mainIni.notifications.if_dead)
local if_damage 				= 	imgui.ImBool(mainIni.notifications.if_damage)

--скип диалогов, секция [skipdialogs]
local state_skips 				=	imgui.ImBool(mainIni.skipdialogs.state_skips)		
local tradedialog 				=	imgui.ImBool(mainIni.skipdialogs.tradedialog)		
local admin_report 				=	imgui.ImBool(mainIni.skipdialogs.admin_report)		
local pizza 					=	imgui.ImBool(mainIni.skipdialogs.pizza)
local dmzz 						=	imgui.ImBool(mainIni.skipdialogs.dmzz)
local taxes 					=	imgui.ImBool(mainIni.skipdialogs.taxes)
local military_base				=	imgui.ImBool(mainIni.skipdialogs.military_base)
local pin_code 					=	imgui.ImBool(mainIni.skipdialogs.pin_code)

--окно статистики перса, секция [arz_assistant_window]
local show_window 				= 	imgui.ImBool(mainIni.arz_assistant_window.show_window) 
local position 					= 	decodeJson(mainIni.arz_assistant_window.position)
local showname 					= 	imgui.ImBool(mainIni.arz_assistant_window.showname) 
local showlvl 					= 	imgui.ImBool(mainIni.arz_assistant_window.showlvl) 
local showping					= 	imgui.ImBool(mainIni.arz_assistant_window.showping) 
local showfps 					= 	imgui.ImBool(mainIni.arz_assistant_window.showfps) 
local show_hp_and_arm 			= 	imgui.ImBool(mainIni.arz_assistant_window.show_hp_and_arm) 
local show_session_time 		= 	imgui.ImBool(mainIni.arz_assistant_window.show_session_time) 
local show_day_time 			= 	imgui.ImBool(mainIni.arz_assistant_window.show_day_time) 
local showdate 					= 	imgui.ImBool(mainIni.arz_assistant_window.showdate) 

--пиар бизнесов, секция [biz_piar]
local anti_mute 				=	imgui.ImBool(mainIni.biz_piar.anti_mute)

local add_2_str 				= 	imgui.ImBool(mainIni.biz_piar.add_2_str)
local add_3_str 				= 	imgui.ImBool(mainIni.biz_piar.add_3_str)

local piar_string_1 			=	imgui.ImBuffer(u8(tostring(mainIni.biz_piar.piar_string_1)),300)
local piar_string_2 			=	imgui.ImBuffer(u8(tostring(mainIni.biz_piar.piar_string_2)),300)
local piar_string_3 			=	imgui.ImBuffer(u8(tostring(mainIni.biz_piar.piar_string_3)),300)

local biz_piar_wait 			= 	imgui.ImInt(mainIni.biz_piar.wait)

-- создание шрифтов
font1 = renderCreateFont('Arial', 7, 13)
font2 = renderCreateFont('Arial', 8, 5)
font3 = renderCreateFont('Arial', 8.5, 5)
inputHelpText = renderCreateFont("Arial", 9, FCR_BORDER + FCR_BOLD)
-- функция создание текстуры лого
lua_thread.create(function()
	while not doesFileExist(path..'\\azlogo160px.png') do wait(100) end
	arzlogo = imgui.CreateTextureFromFile(path..'\\azlogo160px.png')
end)

function arzmessage(message)
	if bNotf then
		if silentmode.v then 
			print(('[ARZ Assistant] [silentmode] %s'):format(message))
		else
			notf.addNotification(('ARZ Assistant\n%s'):format(message),5)
		end
	else
		print(('[ARZ Assistant] [not found notification file] %s'):format(message))
	end
end

-- Метка: переменные на 1 запуск скрипта
local key, server, ts
local vkerr, vkerrsend -- сообщение с текстом ошибки, nil если все ок
local updateid, tgerr
local fisheye_lock = false -- Метка: FishEye - это на один запуск да но тип да

local shieldState = false
local ShowListId = 0
local main_window_state = imgui.ImBool(false)
local piemenu = imgui.ImBool(false)
local antiafk = imgui.ImBool(false)
local devmode = imgui.ImBool(false)

local recstand = imgui.ImInt(15)
local recname = imgui.ImBuffer(256)	

timekd = 0
tex = os.clock()
armkd = false
maskedtm = nil
carloadnumber = -1
carfixnumber = -1

piemenuIsAct = false
bizpiaron = false
textrep = ''
lastvrmessage = ''

gname, ammoclip, findedgun = 'nothing', -1, false

local metod = {
	u8'Чипсы',
	u8'Рыба',
	u8'Оленина',
	u8'TextDraw',
	u8'Мешок'
}
local healmetod = {
	u8'Аптечка',
	u8'Наркотики',
	u8'Андреналин',
	u8'Пиво',
	u8'TextDraw'
}

local onPlayerHungry = lua_thread.create_suspended(function()
	if eatmetod.v == 1 then
		arzmessage('Реагирую, кушаю')
		gotoeatinhouse = true
		sampSendChat('/home')
	elseif eatmetod.v == 3 then
		arzmessage('Реагирую, кушаю')
		setVirtualKeyDown(0x12, false)
		while not sampIsDialogActive() do wait(0) end
		sampSendDialogResponse(1825, 1, 6, false)
		while not sampIsDialogActive() do wait(0) end
		wait(500)
		sampCloseCurrentDialogWithButton(0)
	elseif eatmetod.v == 2 then 
		arzmessage('Реагирую, кушаю')
		if setmetod.v == 0 then
			for i = 1,30 do
				sampSendChat('/cheeps')
				wait(4000)
			end    
		elseif setmetod.v == 1 then
			for k = 1,10 do
				sampSendChat('/jfish')
				wait(3000)
			end    
		elseif setmetod.v == 2 then
			sampSendChat('/jmeat')  
		elseif setmetod.v == 3 then
			sampSendClickTextdraw(arztextdrawid.v)
			sampSendClickTextdraw(arztextdrawid.v)
		elseif setmetod.v == 4 then
			sampSendChat('/meatbag') 
		end
	end
end)

local showtoken = {
	vk = 32768,
	tg = 32768
}
onlineday_TEMP = 0
onlineday_TEMP_DATE = 0

-- события игры и скрипты
function onScriptTerminate(scr,qgame)
	if scr == thisScript() then
		if if_script_err.v then
			sendnotification('Скрипт умер :(')
		end	
	end
end
function onSystemInitialized()
	if mainIni.info.timeonline < 0 then
		print('Значение онлайна за день отрицательное')
		print('Обнуляю')
		mainIni.info.timeonline = 0 
		saveIniFile()
	end
end
function onQuitGame()	
	print("Сохраняю онлайн за день "..FormatTime(onlineday_TEMP))
	mainIni.info.date = onlineday_TEMP_DATE
	mainIni.info.timeonline = onlineday_TEMP
	saveIniFile()
	print("Успешно!")
end

function onWindowMessage(msg, wparam, lparam)
	if msg == 0x100 or msg == 0x101 then
		if wparam == 0x1B and not isPauseMenuActive() then
			if main_window_state.v then
				consumeWindowMessage(true, false)
				if msg == 0x101 then
					main_window_state.v = false
				end
			end
		end
	end
end

function requestRunner() -- создание effil потока с функцией https запроса
	return effil.thread(function(u, a)
		local https = require 'ssl.https'
		local ok, result = pcall(https.request, u, a)
		if ok then
			return {true, result}
		else
			return {false, result}
		end
	end)
end

function threadHandle(runner, url, args, resolve, reject) -- обработка effil потока без блокировок
	-- print('start '..url)
	-- print(encodeJson(runner))
	local t = runner(url, args)
	-- print(t)
	local r = t:get(0)
	while not r do
		r = t:get(0)
		wait(0)
	end
	local status = t:status()
	if status == 'completed' then
		local ok, result = r[1], r[2]
		if ok then resolve(result) else reject(result) end
	elseif err then
		reject(err)
	elseif status == 'canceled' then
		reject(status)
	end
	t:cancel(0)
	-- print('end: '..url)
end

function async_http_request(url, args, resolve, reject)
	local runner = requestRunner()
	if not reject then 
		reject = function() 
			print('-----------error async-----------')
		end 
	end
	lua_thread.create(threadHandle,runner, url, args, resolve, reject)
end


--функа для хоткея вместо rkeys
function isKeysDown(keylist,alwaysdown)
    local tKeys = keylist
    local bool = false
	local func_check = alwaysdown and isKeyDown or wasKeyPressed
	local key = #tKeys < 2 and tonumber(tKeys[1]) or tonumber(tKeys[#tKeys])
    if #tKeys == 1 then
        local istrue = (isKeyDown(0x12) or isKeyDown(0x10) or isKeyDown(0x11))
        if not istrue then
            if func_check(key) then
                bool = true
            end
        end
    else
        if isKeyDown(tKeys[1])  then
            -- sampAddChatMessage('1',-1)
            if isKeyDown(tKeys[2]) then
                if tKeys[3] ~= nil then
                    if isKeyDown(tKeys[3]) then
                        if tKeys[4] ~= nil then
                            if isKeyDown(tKeys[4]) then
                                if tKeys[5] ~= nil then
                                    if isKeyDown(tKeys[5]) then
                                        if func_check(key) then
                                            bool = true
                                        end
                                    end
                                else
                                    if func_check(key) then
                                        bool = true
                                    end
                                end
                            end
                        else
                            if func_check(key) then
                                bool = true
                            end
                        end
                    end
                else
                    if func_check(key) then
                        bool = true
                    end
                end
            end
        end
    end
    return bool
end
function getKeysName(tKeys)
	local tKeysName = {}
	for k, v in ipairs(tKeys) do
		tKeysName[k] = vkeys.id_to_name(v)
	end
	return tKeysName
end
-- // полезные таблицы 

local items = { -- темы имгуи
	u8"Тёмная", --1
	u8"Синяя", --2
	u8"Красная", --3
	u8"Голубая", --4
	u8"Оранжевая", --5
	u8"Фиолетовая", --6
	u8"Темно-красная", --7 
	u8"Dark BlastHack", --8
	u8"Белая", --9
	u8"Темно-салатовая" -- 10
}
local styles = { -- стили
	u8'Строгий',
	u8'Мягкий'
}

tablegunsmodels = {
	['de'] = 348,
	['m4'] = 356,
	['sh'] = 349,
	['rf'] = 357
}

tableguns = {
	['de'] = 'Desert Eagle',
	['m4'] = 'M4',
	['sh'] = 'Shotgun',
	['rf'] = 'Country Rifle'
}

arz_servers = {
    ['185.169.134.3:7777'] 		= 'Arizona Phoenix',
    ['185.169.134.4:7777'] 		= 'Arizona Tucson',
    ['185.169.134.43:7777'] 	= 'Arizona Scottdale',
    ['185.169.134.44:7777'] 	= 'Arizona Chandler',
    ['185.169.134.45:7777'] 	= 'Arizona Brainburg',
    ['185.169.134.5:7777'] 		= 'Arizona Saint Rose',
    ['185.169.134.59:7777'] 	= 'Arizona Mesa',
    ['185.169.134.61:7777'] 	= 'Arizona Red Rock',
    ['185.169.134.107:7777'] 	= 'Arizona Yuma',
    ['185.169.134.109:7777'] 	= 'Arizona Surprise',
    ['185.169.134.166:7777'] 	= 'Arizona Presscott',
    ['185.169.134.171:7777'] 	= 'Arizona Glendale',
    ['185.169.134.172:7777'] 	= 'Arizona Kingman'
}

-- web notf


-- веб функи
function char_to_hex(str)
	return string.format("%%%02X", string.byte(str))
end
  
function url_encode(str)
    local str = string.gsub(str, "\\", "\\")
    local str = string.gsub(str, "([^%w])", char_to_hex)
    return str
end

function encodeUrl(str)
	str = str:gsub(' ', '%+')
	str = str:gsub('\n', '%%0A')
	return u8:encode(str, 'CP1251')
end 
function tblfromstr(str)--ваще она не ток для веба но мне похуй она ток тут юзается
	local a = {}
	for b in str:gmatch('%S+') do
		a[#a+1] = b
	end
	return a
end

-- ПИЗДА ЩА НАЧНЕТСЯ РАЗДЕЛ ВК И ТГ
function longpollResolve(result)
	if result then
		if not result:sub(1,1) == '{' then
			vkerr = 'Ошибка!\nПричина: Нет соединения с VK!'
			-- print('Debug: longpoll: vkerr'.. vkerr)
			return
		end
		local t = decodeJson(result)
		if t.failed then
			if t.failed == 1 then
				ts = t.ts
			else
				key = nil
				longpollGetKey()
			end
			return
		end
		if t.ts then
			ts = t.ts
		end
		if send_vk.v and t.updates then
			for k, v in ipairs(t.updates) do
				if v.type == 'message_new' and tonumber(v.object.from_id) == tonumber(user_id.v) and v.object.text then
					if v.object.payload then
						local pl = decodeJson(v.object.payload)
						if pl.button then
							if pl.button == 'getstats' then
								getPlayerArzStats(sendnotificationVK)
							elseif pl.button == 'gethun' then
								getPlayerArzHun(sendnotificationVK)
							elseif pl.button == 'getinfo' then
								getPlayerInfo(sendnotificationVK)
							elseif pl.button == 'lastchat10' then
								lastchatmessage(10,sendnotificationVK)
							elseif pl.button == 'support' then
								sendnotificationVK('Команды:\n!sendchat - Отправить сообщение из VK в Игру\n!getstats - получить статистику персонажа\n!getinfo - получить информацию о персонаже\n!lastchat - строки из чата в игру\nПоддержка: t.me/ronnysoftware')
							elseif pl.button == 'keyW' then
								setKeyFrom('go',sendnotificationVK)
							elseif pl.button == 'keyA' then
								setKeyFrom('left',sendnotificationVK)
							elseif pl.button == 'keyS' then
								setKeyFrom('back',sendnotificationVK)
							elseif pl.button == 'keyD' then
								setKeyFrom('right',sendnotificationVK)
							end
						end
						return
					end
					local text = u8:decode(v.object.text)
					local arguments = tblfromstr(text)
					local cmd,args = arguments[1],table.concat(arguments, " ", 2, #arguments)
					if cmd == '!getstats' then
						getPlayerArzStats(sendnotificationVK)
						return
					elseif cmd == '!getinfo' then
						getPlayerInfo(sendnotificationVK)
						return
					elseif cmd == '!gethun' then
						getPlayerArzHun(sendnotificationVK)
						return
					elseif cmd == '!lastchat' then
						local lines = tonumber(args)
						if lines and lines < 52 and lines > 0 then
							lastchatmessage(text,sendnotificationVK)
						else
							sendnotificationVK('Неверное значение! Аргумент должен быть больше 0 и меньше 52')
						end
						return
					elseif cmd == '!sendchat' then
						if args:len() > 0 then
							local sendtogame = args
							sampProcessChatInput(sendtogame)
							sendnotificationVK('Сообщение "' .. sendtogame .. '" было успешно отправлено в игру')
						else
							sendnotificationVK('Неправильный аргумент! Пример: !sendchat [строка]')
						end
						return
					elseif cmd =='!support' then
						sendnotificationVK('Команды:\n!sendchat - Отправить сообщение из VK в Игру\n!getstats - получить статистику персонажа\n!getinfo - получить информацию о персонаже\n!lastchat - строки из чата в игру\nПоддержка: @ronnysoftware')
						return
					end
				end
			end
		end
	end
end
function longpollGetKey()
	async_http_request('https://api.vk.com/method/groups.getLongPollServer?group_id=' .. group_id.v .. '&access_token=' .. vk_token.v .. '&v=5.80', '', function (result)
		if result then
			if not result:sub(1,1) == '{' then
				vkerr = 'Ошибка!\nПричина: Нет соединения с VK!'
				return
			end
			local t = decodeJson(result)
			if t then
				if t.error then
					vkerr = 'Ошибка!\nКод: ' .. t.error.error_code .. ' Причина: ' .. t.error.error_msg
					return
				end
				server = u8:decode(t.response.server)
				ts = u8:decode(t.response.ts)
				key = u8:decode(t.response.key)
				vkerr = nil
			end
		end
	end)
end

function sendnotificationVK(msg, host,sendID)
	sendID = sendID or select(2,sampGetPlayerIdByCharHandle(PLAYER_PED))
	host = host or sampGetCurrentServerName()
	-- _, myid = sampGetPlayerIdByCharHandle(playerPed)
	msg = '[ARZ Assistant]\n'..msg..'\nНик: '..sampGetPlayerNickname(myid)..'['..sendID..']\nСервер: '..host
	msg = msg:gsub('{......}', '')
	msg = u8(msg)
	msg = url_encode(msg)
	local keyboard = vkKeyboard()
	keyboard = u8(keyboard)
	keyboard = url_encode(keyboard)
	msg = msg .. '&keyboard=' .. keyboard
	if send_vk.v and user_id.v:len() > 0 then
		async_http_request('https://api.vk.com/method/messages.send', 'user_id=' .. user_id.v .. '&message=' .. msg .. '&access_token=' .. vk_token.v .. '&v=5.80',
		function (result)
			local t = decodeJson(result)
			if not t then
				return
			end
			if t.error then
				vkerrsend = 'Ошибка!\nКод: ' .. t.error.error_code .. ' Причина: ' .. t.error.error_msg
				-- print('Debug: sendnotf vkerrsend:' .. vkerrsend)
				return
			end
			vkerrsend = nil
		end)
	end
end
function vkKeyboard() --создает конкретную клавиатуру для бота VK
	local keyboard = {}
	keyboard.one_time = false
	keyboard.buttons = {}
	keyboard.buttons[1] = {}
	keyboard.buttons[2] = {}
	keyboard.buttons[3] = {}
	keyboard.buttons[4] = {}
	keyboard.buttons[5] = {}
	local row = keyboard.buttons[1]
	local row2 = keyboard.buttons[2]
	local row3 = keyboard.buttons[3]
	local row4 = keyboard.buttons[4]
	local row5 = keyboard.buttons[5]
	row[1] = {}
	row[1].action = {}
	row[1].color = 'positive'
	row[1].action.type = 'text'
	row[1].action.payload = '{"button": "getinfo"}'
	row[1].action.label = 'Информация'
	row[2] = {}
	row[2].action = {}
	row[2].color = 'positive'
	row[2].action.type = 'text'
	row[2].action.payload = '{"button": "getstats"}'
	row[2].action.label = 'Статистика'
	row[3] = {}
	row[3].action = {}
	row[3].color = 'positive'
	row[3].action.type = 'text'
	row[3].action.payload = '{"button": "gethun"}'
	row[3].action.label = 'Голод'
	row2[1] = {}
	row2[1].action = {}
	row2[1].color = 'positive'
	row2[1].action.type = 'text'
	row2[1].action.payload = '{"button": "lastchat10"}'
	row2[1].action.label = 'Последние 10 строк с чата'
	row3[1] = {}
	row3[1].action = {}
	row3[1].color = 'positive'
	row3[1].action.type = 'text'
	row3[1].action.payload = '{"button": "support"}'
	row3[1].action.label = 'Поддержка'
	row4[1] = {}
	row4[1].action = {}
	row4[1].color = 'positive'
	row4[1].action.type = 'text'
	row4[1].action.payload = '{"button": "keyW"}'
	row4[1].action.label = 'W'
	row5[1] = {}
	row5[1].action = {}
	row5[1].color = 'positive'
	row5[1].action.type = 'text'
	row5[1].action.payload = '{"button": "keyA"}'
	row5[1].action.label = 'A'
	row5[2] = {}
	row5[2].action = {}
	row5[2].color = 'positive'
	row5[2].action.type = 'text'
	row5[2].action.payload = '{"button": "keyS"}'
	row5[2].action.label = 'S'
	row5[3] = {}
	row5[3].action = {}
	row5[3].color = 'positive'
	row5[3].action.type = 'text'
	row5[3].action.payload = '{"button": "keyD"}'
	row5[3].action.label = 'D'
	return encodeJson(keyboard)
end

function vkget()
	longpollGetKey()
	local reject, args = function() 
		print('-----------error reject handle-----------')
	end, ''
	local runner = requestRunner()
	requestForVk = true
	while not key do 
		wait(1)
	end
	while true do
		if send_vk.v then
			while not key do wait(1) end
			local url = server .. '?act=a_check&key=' .. key .. '&ts=' .. ts .. '&wait=25' --меняем url каждый новый запрос потокa, так как server/key/ts могут изменяться
			if url then
				threadHandle(runner, url, args, longpollResolve, reject)
			end
		end
		wait(100)
	end
end

-- все что надо для телеги
function sendnotificationTG(msg,host,sendID)
	if send_tg.v then
		sendID = sendID or select(2,sampGetPlayerIdByCharHandle(PLAYER_PED))
		host = host or sampGetCurrentServerName()
		_, myid = sampGetPlayerIdByCharHandle(playerPed)
		msg = '[ARZ Assistant]\n'..msg..'\nНик: '..sampGetPlayerNickname(myid)..'['..sendID..']\nСервер: '..host
		msg = msg:gsub('{......}', '')
		msg = u8(msg)
		msg = url_encode(msg)
		async_http_request('https://api.telegram.org/bot' .. tg_token.v .. '/sendMessage?chat_id=' .. chat_id.v .. '&text='..msg,'',function(result) 
			if result then
				local data = decodeJson(result)
				if data.ok then
					tgerr = nil
				else
					if data.error_code and data.error_msg then
						tgerr = data.error_code .. ' | '.. data.error_msg
					end
				end
			end
		end)
		print('send tg')
	end
end
function getLastUpdate() -- тут мы получаем последний ID сообщения, если же у вас в коде будет настройка токена и chat_id, вызовите эту функцию для того чтоб получить последнее сообщение
	local url = 'https://api.telegram.org/bot'..tg_token.v..'/getUpdates?chat_id='..chat_id.v..'&offset=-1'
	async_http_request(url,'',function(result)
        if result then
            local proc_table = decodeJson(result)
			if proc_table then
				if proc_table.ok then
					if #proc_table.result > 0 then
						local res_table = proc_table.result[1]
						if res_table then
							updateid = res_table.update_id
						end
					else
						updateid = 1 -- тут зададим значение 1, если таблица будет пустая
					end
				else
					updateid = nil
				end
			end
        end
	end)
end
function get_telegram_updates() -- функция получения сообщений от юзера
	while not requestForVk do wait(100) end
	print('sets telegram')
	getLastUpdate()
	wait(200)
	local runnertelega = requestRunner()
	while not updateid do wait(1) end -- ждем пока не узнаем последний ID 
    local rejecttelega, args = function() 
		print('-----------error reject handle-----------')
	end, ''
	while true do
		if send_tg.v then
			while not updateid do wait(1) end
			local url = 'https://api.telegram.org/bot'..tg_token.v..'/getUpdates?chat_id='..chat_id.v..'&offset=-1' -- создаем ссылку
			if url then	
				threadHandle(runnertelega, url, args, processing_telegram_messages, rejecttelega)
			end
		end
        wait(100)
    end
end
function processing_telegram_messages(result) -- функция проверОчки того что отправил чел
	if send_tg.v then
		if result then
		    local proc_table = decodeJson(result)
			if proc_table.ok then
				tgerr = nil
		        if #proc_table.result > 0 then
		            local res_table = proc_table.result[1]
		            if res_table then
		                if res_table.update_id ~= updateid then
		                    updateid = res_table.update_id
		                    local message_from_user = res_table.message.text
							if message_from_user then
								message_from_user = u8:decode(message_from_user)
								local arguments = tblfromstr(message_from_user)
								local cmd,args = arguments[1],table.concat(arguments, " ", 2, #arguments)
								if cmd == '!getstats' then
									getPlayerArzStats(sendnotificationTG)
									return
								elseif cmd == '!getinfo' then
									getPlayerInfo(sendnotificationTG)
									return
								elseif cmd == '!gethun' then
									getPlayerArzHun(sendnotificationTG)
									return
								elseif cmd == '!lastchat' then
									local lines = tonumber(args)
									if lines and lines < 52 and lines > 0 then
										lastchatmessage(text,sendnotificationTG)
									else
										sendnotificationTG('Неверное значение! Аргумент должен быть больше 0 и меньше 52')
									end
									return
								elseif cmd == '!sendchat' then
									if args:len() > 0 then
										local sendtogame = args
										sampProcessChatInput(sendtogame)
										sendnotificationTG('Сообщение "' .. sendtogame .. '" было успешно отправлено в игру')
									else
										sendnotificationTG('Неправильный аргумент! Пример: !sendchat [строка]')
									end
									return
								elseif cmd =='!support' then
									sendnotificationTG('Команды:\n!sendchat - Отправить сообщение из VK в Игру\n!getstats - получить статистику персонажа\n!getinfo - получить информацию о персонаже\n!lastchat - строки из чата в игру\nПоддержка: @ronnysoftware_support_bot')
									return
								end
		                    end
		                end
		            end
				end
			else
				tgerr = proc_table.error_code .. ' | '..proc_table.description
			end
		end
	end
end
-- отправка уведомлений всем (ну и в вк и в тг)
function sendnotification(message_send,hostname,myidjoin)
	hostname = hostname or sampGetCurrentServerName()
	myidjoin = myidjoin or select(2,sampGetPlayerIdByCharHandle(PLAYER_PED))
	print('[notf] call sendnotification')
	sendnotificationVK(message_send,hostname,myidjoin)
	sendnotificationTG(message_send,hostname,myidjoin)
end
-- управление игрой и все такое
function setKeyFrom(getkey, tochat)
	if sampIsLocalPlayerSpawned() then
		tochat('Отправлено нажатие на клавишу '..getkey)
		local timepress = os.time()
		if getkey == 'go' then
			print('key set go')
			while os.time() - timepress < 2 do wait(0) setGameKeyState(1,-1024) end
			setGameKeyState(1,0)
		elseif getkey == 'back' then
			print('key set back')
			while os.time() - timepress < 2 do wait(0) setGameKeyState(1,1024) end
			setGameKeyState(1,0)
		elseif getkey == 'left' then
			print('key set left')
			while os.time() - timepress < 2 do wait(0) setGameKeyState(0,-1024) end
			setGameKeyState(0,0)
		elseif getkey == 'right' then
			print('key set right')
			while os.time() - timepress < 2 do wait(0) setGameKeyState(0,1024) end
			setGameKeyState(0,0)
		end
	else
		tochat('(error) Персонаж не заспавнен')
	end
end
function lastchatmessage(intchat, tochat)
	if sampIsLocalPlayerSpawned() then
		print('use: lastchat')
		local allchat = '\n'
		for i = 100-intchat, 99 do
			local getstr = select(1,sampGetChatString(i))
			allchat = allchat .. getstr .. '\n'
		end
		tochat(allchat)
	else
		tochat('(error) Персонаж не заспавнен')
	end
end
function getPlayerArzHun(tochat)
	print('use: getplayerarzhun')
	if sampIsLocalPlayerSpawned() then
		gethunstate = true
		sampSendChat('/satiety')
		local timesendrequest = os.clock()
		while os.clock() - timesendrequest <= 10 do
			wait(0)
			if gethunstate ~= true then
				timesendrequest = 0
			end 
		end
		tochat(gethunstate == true and 'Ошибка! В течении 10 секунд скрипт не получил информацию!' or tostring(gethunstate))
		gethunstate = false
	else
		tochat('(error) Персонаж не заспавнен')
	end
end
function getPlayerArzStats(tochat)
	print('use: getplayerarzstats')
	if sampIsLocalPlayerSpawned() then
		sendstatsstate = true
		sampSendChat('/stats')
		local timesendrequest = os.clock()
		while os.clock() - timesendrequest <= 10 do
			wait(0)
			if sendstatsstate ~= true then
				timesendrequest = 0
			end 
		end
		tochat(sendstatsstate == true and 'Ошибка! В течении 10 секунд скрипт не получил информацию!' or tostring(sendstatsstate))
		sendstatsstate = false
	else
		tochat('(error) Персонаж не заспавнен')
	end
end
function getPlayerInfo(tochat)
	print('use: getplayerinfo')
	if sampIsLocalPlayerSpawned() then
		local response = ''
		response = response .. 'HP: ' .. getCharHealth(PLAYER_PED) .. '\n'
		response = response .. 'Armor: ' .. getCharArmour(PLAYER_PED) .. '\n'
		local x, y, z = getCharCoordinates(PLAYER_PED)
		response = response .. 'Coords: X: ' .. math.floor(x) .. ' | Y: ' .. math.floor(y) .. ' | Z: ' .. math.floor(z)
		tochat(response)
	else
		tochat('(error) Персонаж не заспавнен')
	end
end
-- ну все бля :(
-- end web notf

function main()
	-- thisScript():unload()
	-- wait(-1)
	while not isSampAvailable() do wait(100) end
	while not doesFileExist('moonloader/ARZ Assistant/arz_imgui_notf.lua') do wait(100) end
	arzmessage("Скрипт успешно загружен!\nОткрыть меню - /arz!\nАвтор: ronnysoftware\nИнформация об обнове - /updinf\nВерсия "..thisScript().version, 5)
	if autoupdateenable.v then
		updates:autoupdate()
	else
		updates:getlast()
	end
	lua_thread.create(getPlayerOnline)
	_, myid = sampGetPlayerIdByCharHandle(playerPed)
	myname = sampGetPlayerNickname(myid)
	myping = sampGetPlayerPing(myid)
	mylvl = sampGetPlayerScore(myid)
	myarm = sampGetPlayerArmor(myid)
	myheal = sampGetPlayerHealth(myid)
	imgui.ShowCursor = false
	if fastconnect.v then
		sampFastConnect(fastconnect.v)
	end
	lua_thread.create(inputChat)
	lua_thread.create(waitsthr)
	lua_thread.create(renderthr)
	sampRegisterChatCommand("arz", function() main_window_state.v = not main_window_state.v end)
	sampRegisterChatCommand('calc', function(str)
		if str:len() > 0 then
			local calc = load("return "..str)
			local bReturned, returned = pcall(calc)
			if bReturned then
				sampAddChatMessage('[ARZ Assistant] {ffffff}Результат: '..returned, 0xFF2F2F)
			else
				sampAddChatMessage('[ARZ Assistant] {ffffff}Ошибка при вызове функции calc! Введи корректный пример!', 0xFF2F2F)
			end
		else
			sampAddChatMessage('[ARZ Assistant] {ffffff}Используй {FF2F2F}/calc [пример]', 0xFF2F2F)
		end
	end)
	sampRegisterChatCommand('rep', function(reptext)
		if reptext:len() > 0 then
			sampSendChat('/rep')
			textrep = reptext
		else
			arzmessage('Введите /rep [сообщение]')
		end
	end)
	sampRegisterChatCommand('nid',function(findname) 
		local prefcmd = '[Модифицированный /id]'
		if findname:len() > 0 then
			if type(findname) == 'string' then
				findname = findname:gsub(' ','')
				-- sampAddChatMessage(prefcmd .. '{ffffff} Тип стринг',0x06495ED)
				local findedplayers = 0
				for i = 0, 1001 do
					if sampIsPlayerConnected(i) then
						local name = sampGetPlayerNickname(i)
						local tempname = string.lower(name)
						local tempfindname = string.lower(findname)
						if tempname:find(tempfindname) then
							sampAddChatMessage(prefcmd .. '{ffffff} '..name..'['..i..']',0x06495ED)
							findedplayers = findedplayers + 1
						end
					end
				end
				if findedplayers < 1 then
					sampAddChatMessage(prefcmd .. '{ffffff} Игроков в нике которых содержится "'..findname..'" не найдено!',0x06495ED)
				end
			else
				sampAddChatMessage(prefcmd .. '{ffffff} [Ошибка] Аргумент не является строкой',0x06495ED)
			end
		else
			sampAddChatMessage(prefcmd .. '{ffffff} Введите /nid [часть ника]',0x06495ED)
		end
	end)
	sampRegisterChatCommand('de',function(arg) 
		if arg:len() > 0 and tonumber(arg) ~= nil then 
			arg = tonumber(arg) 
			getguninvent('de',arg) 
		else 
			arzmessage('Неверное значение патрон!') 
		end 
	end)
	sampRegisterChatCommand('m4',function(arg) 
		if arg:len() > 0 and tonumber(arg) ~= nil then 
			arg = tonumber(arg) 
			getguninvent('m4',arg) 
		else 
			arzmessage('Неверное значение патрон!') 
		end 
	end)
	sampRegisterChatCommand('sh',function(arg) 
		if arg:len() > 0 and tonumber(arg) ~= nil then 
			arg = tonumber(arg) 
			getguninvent('sh',arg) 
		else 
			arzmessage('Неверное значение патрон!') 
		end 
	end)
	sampRegisterChatCommand('rf',function(arg) 
		if arg:len() > 0 and tonumber(arg) ~= nil then 
			arg = tonumber(arg) 
			getguninvent('rf',arg) 
		else 
			arzmessage('Неверное значение патрон!') 
		end 
	end)
	sampRegisterChatCommand('stoprec', function() 
		if handle_aurc then
			handle_aurc:terminate()
			handle_aurc = nil
			arzmessage('АвтоРеконнект остановлен!')
		else
			arzmessage('Вы сейчас не ожидаете автореконнекта!')
		end
		if handle_rc then
			handle_rc:terminate()
			handle_rc = nil
			arzmessage('Реконнект остановлен!')
		else
			arzmessage('Вы сейчас не ожидаете реконнекта!')
		end
	end)
	sampRegisterChatCommand('cloadstop', function() 
		if carloadnumber ~= -1 then
			arzmessage('Стопаем загрузку авто №'..carloadnumber)
			carloadnumber = -1
		else
			arzmessage('Авто не загружается! Начать загрузку: /cload')
		end
	end)
	sampRegisterChatCommand("cload", function(carnum) 
		carnum = tonumber(carnum)
		if carnum and carnum >= 1 and carnum <= 20 then 
			arzmessage('Загружаю авто №'..carnum..'\nТак-же вы можете остановить загрузку командой /cloadstop')
			carloadnumber = carnum
			sampSendChat('/cars')
		else
			arzmessage('Введите /cload [номер авто(от 1 до 20)]')
		end
	end)
	sampRegisterChatCommand('aeat', function()
        sampSendClickTextdraw(arztextdrawid.v)
    end)
    sampRegisterChatCommand('aheal', function()
        sampSendClickTextdraw(arztextdrawidheal.v)
    end)
	sampRegisterChatCommand('chatoff', function()
		chatoffthread = chatoffthread or lua_thread.create_suspended(function()
			while sampIsChatInputActive() do wait(0) end 
			wait(50)
			local address = sampGetBase() + 0x71480
			local get = {
				[0xEB] = 0x74,
				[0x74] = 0xEB
			}
			local state_chat = memory.getuint8(address,true)
			local switch = get[state_chat]
			memory.setuint8(address, switch, true)
		end)
		if chatoffthread then
			chatoffthread:run()
		end
	end)
	sampRegisterChatCommand('pis', function()
		runSampfuncsConsoleCommand('0afd:68')
	end)
	sampRegisterChatCommand('bizpiar', function()
		bizpiaron = not bizpiaron
		arzmessage(bizpiaron and 'Пиар включён!' or 'Пиар выключен!',5)
		if bizpiaron then 
			bizpiarhandle = lua_thread.create(bizpiar) 
		else 
			lua_thread.terminate(bizpiarhandle) 
		end
	end)
	sampRegisterChatCommand('arzunload', function()
		arzmessage('Выгружаю скрипт')
		thisScript():unload()
	end)
	sampRegisterChatCommand('cc', clearchat)
	sampRegisterChatCommand('rc', function (arg)
		reconstandart(arg)
	end)
	sampRegisterChatCommand('rcn', function (arg)
		reconname(arg)
	end)
	sampRegisterChatCommand('getid', function(nickname)
		local id = sampGetPlayerIdByNickname(nickname)
		if nickname:len() <= 0 then
			arzmessage('Введите ник игрока - /getid <nick>', 5)
		else
			if id == nil then
				arzmessage('Данного игрока нет на сервере', 5)
			else
				arzmessage("ID игрока "..nickname.." ["..id.."]", 5)
			end
		end	
	end)
	sampRegisterChatCommand('ahrl', function(luaScript, quitGame)
		thisScript():reload()
	end)
	sampRegisterChatCommand('fh', function(arg) 
        if arg ~= nil then 
			sampSendChat('/findihouse '..arg)
		end
	end)
	sampRegisterChatCommand('phn', function()
		if phone_cheatcode.v then
			sampSendChat('/phone')
		else
			print('phone cheatcode is off -> send server cmd /phn')
			sampSendChat('/phn')
		end
	end)
	sampRegisterChatCommand('fc', function(arg)
		arg = tonumber(arg)
		if arg and arg >= 1 and arg <= 5 then
			carfixnumber = arg
			sampSendChat('/cars')
		else 
			arzmessage("Введите номер авто из списка /cars[от 1 до 5]",5)
		end
	end)
	sampRegisterChatCommand('atesteat', function(arg) 
		gotoeatinhouse = true;
		sampSendChat('/home')
	end)
	sampRegisterChatCommand('us', function(arg) 
		if arg ~= nil then
			sampSendChat('/usedrugs '..arg)
		end
	end)
	sampRegisterChatCommand('fbiz', function(arg) 
    	if arg ~= nil then 
            sampSendChat('/findibiz '..arg)
        end
	end)
	lua_thread.create(vkget)
	lua_thread.create(get_telegram_updates)
	while true do
		wait(0)
		onlineday_TEMP_DATE = os.date('%D')
		onlineday_TEMP = mainIni.info.timeonline + os.clock()
		tex = os.clock() 
		_, myid = sampGetPlayerIdByCharHandle(playerPed)
		myname = sampGetPlayerNickname(myid)
		myping = sampGetPlayerPing(myid)
		mylvl = sampGetPlayerScore(myid)
		myarm = sampGetPlayerArmor(myid)
		myheal = sampGetPlayerHealth(myid)
		ip, port = sampGetCurrentServerAddress()
		-- tdtext = sampTextdrawGetString(613)
		btext = sampTextdrawGetString(2052)
		if isKeysDown(piemenu_keys.v) then
			if piemenu_act.v and not sampIsCursorActive() then
				piemenu.v = not piemenu.v
			end	
		end
		if isKeysDown(rpdm_keys.v) then
			local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
			local result, id = sampGetPlayerIdByCharHandle(ped)
			local myweap = getCurrentCharWeapon(playerPed)
			if rpdm_act.v and valid and doesCharExist(ped) then
				if result then
					local tgname = sampGetPlayerNickname(id)
					if myweap == 24 then
						sampSendChat('/me достал из-за пояса заряженый Desert Eagle')
						wait(1200)
						sampSendChat(u8:decode('/do '..rpdm_text.v..' '..tgname))
					end
					if myweap == 25 then
						sampSendChat('/me достал из-за спины дробовик')
						wait(1200)
						sampSendChat(u8:decode('/do '..rpdm_text.v..' '..tgname))
					end
					if myweap == 31 then
						sampSendChat('/me достал из-за спины M4')
						wait(1200)
						sampSendChat(u8:decode('/do '..rpdm_text.v..' '..tgname))
					end
					if myweap == 33 then
						sampSendChat('/me достал из-за спины винтовку')
						wait(1200)
						sampSendChat(u8:decode('/do '..rpdm_text.v..' '..tgname))
					end
				end
			end
		end
		if doesFileExist('moonloader/ARZ Assistant/fontawesome-webfont.ttf') then
			imgui.Process = main_window_state.v or piemenu.v or show_window.v
		end
		setPlayerNeverTried(infrun.v)
		if fisheye.v then
			if isCurrentCharWeapon(PLAYER_PED, 34) and isKeyDown(2) then
				if not fisheye_lock then 
					cameraSetLerpFov(70.0, 70.0, 1000, 1)
					fisheye_lock = true
				end
			else
				cameraSetLerpFov(fisheye_rad.v, fisheye_rad.v, 1000, 1)
				fisheye_lock = false
			end
		end
		if newmarkercolor.v then
			if setMarkerColor then
				local alpha = newmarkercolor_rainbow.v and math.floor(math.sin(os.clock() * 3) * 127 + 128) or 255
				setMarkerColor(markcolor.v[1],markcolor.v[2],markcolor.v[3],alpha)
			end
		end
		if antiblockplayer.v then
			for k,v in pairs(getAllChars()) do
				if v ~= PLAYER_PED then
					if doesCharExist(v) then
						local x, y, z = getCharCoordinates(v)
						local mX, mY, mZ = getCharCoordinates(playerPed)
						if 0.4 > getDistanceBetweenCoords3d(x, y, z, mX, mY, mZ) then
							setCharCollision(v, false)
						end
					end
				end
			end
		end
		
		if autobreak.v then
			if btext:find('PRESS ~r~~k~~SNEAK_ABOUT~') then
				setGameKeyState(21,256)
			end
			if btext:find('PRESS ~r~~k~~PED_JUMPING~') then
				setGameKeyState(14,256)
			end
		end
		
		if shieldcontrol.v then
			if isKeyJustPressed(0x49) and not sampIsCursorActive() then
				shieldState = not shieldState
				arzmessage(shieldState and 'АвтоЩит включён ' or 'АвтоЩит выключен')
			end
			if shieldState then
				setGameKeyState(21,1)
				setGameKeyState(16,1)
			end
		end
		if inputhelper.v and (isKeyDown(VK_T) and wasKeyPressed(VK_T)) then
			if(not sampIsChatInputActive() and not sampIsDialogActive()) and not isSampfuncsConsoleActive() then
				sampSetChatInputEnabled(true)
			end
		end
		if phone_cheatcode.v then
			if testCheat("PH") and not sampIsCursorActive() then
				sampSendChat("/phone")
			end
		end
		if binds_armour.v then
			if testCheat("arm") and not sampIsCursorActive() then
				sampSendChat("/armour")
			end
		end
		if binds_mask.v then
			if testCheat("mask") and not sampIsCursorActive() then
				sampSendChat("/mask")
			end
		end
		if binds_lock.v then
			if testCheat("L") and not sampIsCursorActive() then
				sampSendChat("/lock")
			end
		end
		if binds_olock.v then
			if testCheat("O") and not sampIsCursorActive() then
				sampSendChat("/olock")
			end
		end
		if binds_jlock.v then
			if testCheat("J") and not sampIsCursorActive() then
				sampSendChat("/jlock")
			end
		end
		if binds_key.v then
			if testCheat("K") and not sampIsCursorActive() then
				sampSendChat("/key")   
			end
		end
	end
end
-- // кастомные функции
--new функа беск бега
function setPlayerNeverTried(bool)
	memory.setint8(0xB7CEE4, bool and 1 or 0)
end
--получить ARGB радужный-цвет
function getrainbowcolors(speed, alpha)
	local r = math.floor(math.sin(os.clock() * speed) * 127 + 128)
	local g = math.floor(math.sin(os.clock() * speed + 2) * 127 + 128)
	local b = math.floor(math.sin(os.clock() * speed + 4) * 127 + 128)
	return r,g,b,alpha
end
-- установить новый цвет маркеру
function setMarkerColor(r,g,b,alp)
	memory.write(7392527, r * 255, 4, true)
	memory.write(7392525, g * 255, 1, true)
	memory.write(7392523, b * 255, 1, true)
	memory.write(7392518, alp, 4, true)
	memory.write(7392604,r * 255, 4, true)
	memory.write(7392602,g * 255, 1, true)
	memory.write(7392600,b * 255, 1, true)
	memory.write(7392595, alp, 4, true)
	memory.write(7392687, r * 255, 4, true)
	memory.write(7392685, g * 255, 1, true)
	memory.write(7392683, b * 255, 1, true)
	memory.write(7392678, alp, 4, true)
	memory.write(0x48110F, r * 255, 4, true)
	memory.write(0x48110B, g * 255, 1, true)
	memory.write(0x48110D, b * 255, 1, true)
	memory.write(0x481106, alp, 4, true)
end
--форматирование времени в 
function FormatTime(time)
	time = math.floor( time )
    local timezone_offset = 86400 - os.date('%H', 0) * 3600
    local time = time + timezone_offset
	return  os.date((os.date("%H",time) == "00" and '%M:%S' or '%H:%M:%S'), time)
end
--samp 
-- получить ID всех текстдравов
function sampGetAllTextDraws()
	local tds = {}
	pTd = sampGetTextdrawPoolPtr() + 9216
	for i = 0,2303 do
		if readMemory(pTd + i*4,4) ~= 0 then
			table.insert(tds,i)
		end
	end
	return tds
end
-- получить ID игрока по Full нику
function sampGetPlayerIdByNickname(nick)
	local _, myidd = sampGetPlayerIdByCharHandle(playerPed)
	if tostring(nick) == sampGetPlayerNickname(myidd) then return myidd end
	for i = 0, 1000 do if sampIsPlayerConnected(i) and sampGetPlayerNickname(i) == tostring(nick) then return i end end
end		
-- fast connect
function sampFastConnect(bool)
	if bool then 
		writeMemory(sampGetBase() + 0x2D3C45, 2, 0, true)
	else
		writeMemory(sampGetBase() + 0x2D3C45, 2, 8228, true)
	end
end

--colors funcs
function explode_argb(argb)
	local a = bit.band(bit.rshift(argb, 24), 0xFF)
	local r = bit.band(bit.rshift(argb, 16), 0xFF)
	local g = bit.band(bit.rshift(argb, 8), 0xFF)
	local b = bit.band(argb, 0xFF)
	return a, r, g, b
end
function join_argb(a, r, g, b)
	local argb = b  -- b
	argb = bit.bor(argb, bit.lshift(g, 8))  -- g
	argb = bit.bor(argb, bit.lshift(r, 16)) -- r
	argb = bit.bor(argb, bit.lshift(a, 24)) -- a
	return argb
end
function argb_to_rgba(argb)
	local a, r, g, b = explode_argb(argb)
	return join_argb(r, g, b, a)
end


-- // только для авто заполения
function savejson()
	if doesFileExist(file) then
		os.remove(file)
	end
	if table.maxn(savepass) > 0 then
		local f = io.open(file, "w")
		if f then
			f:write(encodeJson(savepass))
			f:close()
		end
	end
	print('[ARZ Assistant Accounts] Saved!')
end
function findDialog(id, dialog)
	for k, v in pairs(savepass[id][3]) do
		if v.id == dialog then
			return k
		end
	end
	return -1
end

function findAcc(nick, ip)
	for k, v in pairs(savepass) do
		if nick == v[1] and ip == v[2] then
			return k
		end
	end
	return -1
end

function getAcc()
	local nick = tostring(sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))))
	local ip, port = sampGetCurrentServerAddress()
	local ip = ip .. ":" .. port
	local acc = findAcc(nick, ip)
	return acc
end
-- только для fastgun
function getguninvent(gunname, ammo)
	gname, ammoclip, findedgun = gunname, ammo, false
	arzmessage('Достаю '..ammo..' пт '..tableguns[gunname])
	sampSendChat('/invent')
end
-- антиафк
function workpaus(bool)	
	if bool then
		memory.setuint8(7634870, 1, false)
		memory.setuint8(7635034, 1, false)
		memory.fill(7623723, 144, 8, false)
		memory.fill(5499528, 144, 6, false)
	else
		memory.setuint8(7634870, 0, false)
		memory.setuint8(7635034, 0, false)
		memory.hex2bin('0F 84 7B 01 00 00', 7623723, 8)
		memory.hex2bin('50 51 FF 15 00 83 85 00', 5499528, 6)
	end
end


function getPlayerOnline()
	while true do wait(0)
	if os.date('%D') ~= mainIni.info.date then
		print('Новый день! Онлайн сброшен')
		mainIni.info.date = os.date('%D')
		if sampIsLocalPlayerSpawned() then
			mainIni.info.timeonline = 0 - os.clock()
		else
			mainIni.info.timeonline = 0
		end
		saveIniFile()
	end
	end
end
-- рекон 
function reconstandart(timewait,bool_close)
	if handle_aurc then
		handle_aurc:terminate()
		handle_aurc = nil
		arzmessage('Автореконнект остановлен т.к вы использовали обычный реконнект')
	end
	if handle_rc then
		handle_rc:terminate()
		handle_rc = nil
		arzmessage('Предыдущий реконнект был остановлен')
	end
	handle_rc = lua_thread.create(function(timewait2, bclose)
		bclose = bclose or true
		if bclose then
			closeConnect()
		end
		agada, recid = sampGetPlayerIdByCharHandle(playerPed)
		timewait2 = tonumber(timewait2)
		if timewait2 then	
			if timewait2 >= 0 then
				recwaitim = timewait2*1000
				arzmessage('Реконнект через '..timewait2..' секунд')
				wait(recwaitim)
				sampSetLocalPlayerName(sampGetPlayerNickname(recid))
				sampConnectToServer(ip,port)
			end
		else
			arzmessage('Реконнект...')
			wait(0)
			sampSetLocalPlayerName(sampGetPlayerNickname(recid))
			sampConnectToServer(ip,port)
		end  
		handle_rc = nil
	end,timewait, bool_close)
end
--рекон с ником 
function reconname(playername,ips,ports)
	if handle_aurc then
		handle_aurc:terminate()
		handle_aurc = nil
		arzmessage('Автореконнект остановлен т.к вы использовали реконнект с ником')
	end
	if handle_rc then
		handle_rc:terminate()
		handle_rc = nil
		arzmessage('Предыдущий реконнект был остановлен')
	end
	handle_rc = lua_thread.create(function()
		if #playername == 0 then
			arzmessage('Введите ник для реконнекта')
		else
			closeConnect()
			sampSetLocalPlayerName(playername)
			arzmessage('Реконнект с новым ником\n'..playername)
			ips,ports = ips or ip, ports or port
			sampConnectToServer(ips,ports)
		end 
	end)
end
-- создать autorecon
function goaurc()
	if if_kick.v then
		sendnotification('Потеряно соединение с сервером')
	end
	if auto_rec.v then
		if handle_aurc then
			handle_aurc:terminate()
			handle_aurc = nil
			arzmessage('Предыдущий автореконнект был остановлен')
		end
		if handle_rc then
			handle_rc:terminate()
			handle_rc = nil
			arzmessage('Обычный автореконнект был остановлен т.к сработал автореконнект')
		end
		handle_aurc = lua_thread.create(function()
			local ip, port = sampGetCurrentServerAddress()
			local rnick = myname
			arzmessage('Соединение потеряно. Реконнект через '..auto_rec_wait.v..' секунд')
			wait(auto_rec_wait.v * 1000)
			sampSetLocalPlayerName(rnick)
			sampConnectToServer(ip,port)
			handle_aurc = nil
		end)
	end
end
--закрыть соединение
function closeConnect()
	raknetEmulPacketReceiveBitStream(PACKET_DISCONNECTION_NOTIFICATION, raknetNewBitStream())
	raknetDeleteBitStream(raknetNewBitStream())
end
--очитска чата
function clearchat()
	memory.fill(sampGetChatInfoPtr() + 306, 0x0, 25200)
	memory.write(sampGetChatInfoPtr() + 306, 25562, 4, 0x0)
	memory.write(sampGetChatInfoPtr() + 0x63DA, 1, 1)
	arzmessage("Чат очищен!", 5)
end

--Сделать пропинговку серверу
function ping(ip,port)
	local data
	ip, port = sampGetCurrentServerAddress()
	local commonPattern = generateCommonPattern(ip, port)
	local upd = socket.upd()
	upd:settimeout(3)
	upd:setsockname("*",0)

	upd:sendto(commonPattern.."i",ip,port)
	upd:sendto(commonPattern.."p".."aaaa",ip,port)
	upd:sendto(commonPattern.."c",ip,port)
	upd:sendto(commonPattern.."r",ip,port)
	upd:close()
end
function generateCommonPattern(ip, port)
    local separatedIp = explode(".", ip)
    local firstPortByte = bit.band(port, 0xFF)
    local secondPortByte = bit.band(bit.rshift(port, 8), 0xFF)
    return "SAMP" ..
        string.char(separatedIp[1]) ..
            string.char(separatedIp[2]) ..
                string.char(separatedIp[3]) ..
                    string.char(separatedIp[4]) ..
                        string.char(firstPortByte) .. string.char(secondPortByte)
end
function explode(div, str)
    if (div == "") then
        return false
    end
    local pos, arr = 0, {}
    for st, sp in function()
        return string.find(str, div, pos, true)
    end do
        table.insert(arr, string.sub(str, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(str, pos))
    return arr
end

-- узнать состояние CapsLock \ inhelp
function getStrByState(keyState)
	if keyState == 0 then
		return "{ffeeaa}Выкл{ffffff}"
	end
	return "{9EC73D}Вкл{ffffff}"
end
--перевод rus в eng \ inhelp
function translite(text)
	for k, v in pairs(chars) do
		text = string.gsub(text, k, v)
	end
	return text
end

-- функции созданные lua_thread.create
function bizpiar()
	local piarkolvo = 0
	while true do 
		wait(0)
		if bizpiaron then
			local sendpiar1 = u8:decode(piar_string_1.v)
			local sendpiar2 = u8:decode(piar_string_2.v)
			local sendpiar3 = u8:decode(piar_string_3.v)
			piarkolvo = piarkolvo + 1
			if anti_mute.v then
				sendpiar1 = sendpiar1:gsub('{getsendmessagescount}',piarkolvo)
				sendpiar2 = sendpiar2:gsub('{getsendmessagescount}',piarkolvo)
				sendpiar3 = sendpiar3:gsub('{getsendmessagescount}',piarkolvo)
			end
			sampSendChat(sendpiar1)
			if add_2_str.v then
				wait(1200)
				sampSendChat(sendpiar2)
			end
			if add_3_str.v then
				wait(1200)
				sampSendChat(sendpiar3)
			end
			wait(biz_piar_wait.v * 1000)
		end
	end
end
function waitsthr()
	while true do
		wait(0)
		if time_act.v then      
			if testCheat("ez") and not sampIsCursorActive() then
				timeotigr()
			end
		end
		if isKeysDown(fastrun_keys.v,true) then
			if fastrun_act.v and not sampIsCursorActive() then
				setGameKeyState(16,1)
				wait(10)
				setGameKeyState(16,0)
			end
		end
	end
end
function renderthr()
	while true do wait(0)
		if not isPauseMenuActive() then
			renderposX, renderposY = getScreenResolution()
			local chat = sampIsChatInputActive()
			if inputhelper.v and chat == true then
				local in1 = sampGetInputInfoPtr()
				local in1 = getStructElement(in1, 0x8, 4)
				local in2 = getStructElement(in1, 0x8, 4)
				local in3 = getStructElement(in1, 0xC, 4)
				fib = in3 + 41
				fib2 = in2 + 10
				local _, pID = sampGetPlayerIdByCharHandle(playerPed)
				local name = sampGetPlayerNickname(pID)
				local score = sampGetPlayerScore(pID)
				local color = sampGetPlayerColor(pID)
				local capsState = ffi.C.GetKeyState(20)
				local success = ffi.C.GetKeyboardLayoutNameA(KeyboardLayoutName)
				local errorCode = ffi.C.GetLocaleInfoA(tonumber(ffi.string(KeyboardLayoutName), 16), 0x00000002, LocalInfo, BuffSize)
				local localName = ffi.string(LocalInfo)
				local text = string.format(
					"%s :: {%0.6x}%s[%d] {ffffff}:: Капс: %s {FFFFFF}:: Язык: {ffeeaa}%s{ffffff}",
					os.date("%H:%M:%S"), bit.band(color,0xffffff), name, pID, getStrByState(capsState), string.match(localName, "([^%(]*)")
				)
				-- print(localName)
				renderFontDrawText(inputHelpText, text, fib2, fib, 0xD7FFFFFF)
			end
			if devmode.v then
				local alltextdraws = sampGetAllTextDraws()
				for _, v in pairs(alltextdraws) do
					local fX,fY = sampTextdrawGetPos(v)
					local fX,fY = convertGameScreenCoordsToWindowScreenCoords(fX,fY)
					renderFontDrawText(font2,tostring(v),tonumber(fX),tonumber(fY),0xD7FFFFFF)
				end
			end
			if render_cardoors_state.v and sampIsLocalPlayerSpawned() then
				for k,v in pairs(getAllVehicles()) do
					local x,y,z = getCarCoordinates(v)
					local positionX, positionY, positionZ = getCharCoordinates(PLAYER_PED)
					local carbool, carid = sampGetVehicleIdByCarHandle(v)
					local DoorsStats = getCarDoorLockStatus(v)
					local wposX, wposY = convert3DCoordsToScreen(x,y,z)
					local statusstr = ''
					if DoorsStats == 0 then
						statusstr = '[open]'
					elseif DoorsStats == 2 then
						statusstr = '[close]'
					end
					local dist = getDistanceBetweenCoords3d(positionX, positionY, positionZ,x,y,z)
					if isPointOnScreen(x,y,z,0) and dist < 15 then
						renderFontDrawText(font1,statusstr,wposX,wposY,-255878787)
					end
				end
			end
			if light_from_lanterns.v then
				if isPlayerPlaying(PLAYER_HANDLE) then
					local x, y, z = getCharCoordinates(PLAYER_PED)
					for _, object in ipairs(mad.get_all_objects(x, y, z, 300)) do
						local model = getObjectModel(object)
						if model == 1226 and getObjectHealth(object) > 0 then
							local matrix = mad.get_object_matrix(object)
							if matrix then
								local objx, objy, objz = matrix:get_coords_with_offset(-1.3, 0.165, 3.69)
								local ground_z = getGroundZFor3dCoord(objx, objy, objz)
								mad.draw_spotlight(objx, objy, objz, objx, objy, ground_z, 0.065, 27)
							end
						end
					end
				end
			end
			local centerY = renderposY / 2
			local datarender = {
				box_mask = {
					size = {x=130,y=50},
					pos = {x=renderposX-130,y=centerY-50}
				},
				box_arm = {
					size = {x=130,y=50},
					pos = {x=renderposX-130,y=centerY}
				},
				text_mask = {
					pos = {x=renderposX-120, y = (centerY-25) - (renderGetFontDrawHeight(font3)/2)}
				},
				text_arm = {
					pos = {x=renderposX-120, y = (centerY+25) - (renderGetFontDrawHeight(font3)/2)}
				}
			}
			if mask_timer.v then
				if sampGetPlayerColor(myid) == 23486046 then
					if maskedtm == nil then
						maskedtm = os.time()
					end
					--render
					--mask
					renderDrawBox(datarender.box_mask.pos.x, datarender.box_mask.pos.y, datarender.box_mask.size.x, datarender.box_mask.size.y, 0x90000000)
					renderFontDrawText(font3,'Mask Time: '..os.time()-maskedtm, datarender.text_mask.pos.x, datarender.text_mask.pos.y, 0xFFFFFFFF, 0x90000000)
				else
					if maskedtm ~= nil then
						maskedtm = nil
						arzmessage('Вы сняли маску или время использования истекло!')
					end
				end
			end
			if armour_info.v and armkd then
				if os.time() - timekd < 60 then
					--render
					--arm
					renderDrawBox(datarender.box_arm.pos.x, datarender.box_arm.pos.y, datarender.box_arm.size.x, datarender.box_arm.size.y, 0x90000000)
					renderFontDrawText(font3,'Use Arm: '..60 - (os.time() - timekd), datarender.text_arm.pos.x, datarender.text_arm.pos.y, 0xFFFFFFFF, 0x90000000)
				else
					arzmessage('Вы можете снова использовать бронижилет!')
					timekd = 0
					armkd = false
				end
			end
			if hp_hud.v then
				if myarm ~= 0 then
					renderFontDrawText(font2,myarm,renderposX - 30,58,-1)
				end	
				renderFontDrawText(font2,myheal,renderposX - 30,88,-1)
			end
		end
	end
end
function inputChat()
	while true do
		wait(0)
		if inputhelper.v and sampIsChatInputActive() then
			local getInput = sampGetChatInputText()
			if(oldText ~= getInput and #getInput > 0)then
				local firstChar = string.sub(getInput, 1, 1)
				if(firstChar == "." or firstChar == "/")then
					local cmd, text = string.match(getInput, "^([^ ]+)(.*)")
					local nText = "/" .. translite(string.sub(cmd, 2)) .. text
					local chatInfoPtr = sampGetInputInfoPtr()
					local chatBoxInfo = getStructElement(chatInfoPtr, 0x8, 4)
					local lastPos = memory.getint8(chatBoxInfo + 0x11E)
					sampSetChatInputText(nText)
					memory.setint8(chatBoxInfo + 0x11E, lastPos)
					memory.setint8(chatBoxInfo + 0x119, lastPos)
					oldText = nText
				end
			end
		end
	end
end
--imgui сила твоя мать пидрила 
function imgui.RenderMenuItems()
	imgui.SetCursorPos(imgui.ImVec2(80,10))
	imgui.BeginGroup()
	local bsz = imgui.ImVec2(140,40)
	if imgui.Button(fa.ICON_COG..u8(' Настройки'),bsz) then
		ShowListId = 1
	end
	imgui.SameLine()
	if imgui.Button(fa.ICON_BULLHORN..u8(' Уведомления'),bsz) then
		ShowListId = 2
	end
	imgui.SameLine()
	if imgui.Button(fa.ICON_KEYBOARD_O..u8(' Автозаполнение'),bsz) then
		ShowListId = 4
	end
	imgui.SameLine()
	if imgui.Button(fa.ICON_INFO_CIRCLE..u8(' Информация'),bsz) then
		ShowListId = 3
	end
	imgui.SameLine()
	if imgui.Button(fa.ICON_LIST_ALT..u8(' Список изменений'),bsz) then
		ShowListId = 6
	end
	imgui.EndGroup()
end
function imgui.CreatePaddingX(padding_custom)
	padding_custom = padding_custom or 8 
	imgui.SetCursorPosX(imgui.GetCursorPos().x + padding_custom)
end
function imgui.CreatePaddingY(padding_custom)
	padding_custom = padding_custom or 8
	imgui.SetCursorPosY(imgui.GetCursorPos().y + padding_custom)
end
function imgui.CreatePadding(padding_custom,padding_custom2)
	padding_custom, padding_custom2 = padding_custom or 8, padding_custom2 or 8
	imgui.CreatePaddingX(padding_custom)
	imgui.CreatePaddingY(padding_custom2)
end
function imgui.TextColoredRGB(text)
    local width = imgui.GetWindowWidth()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

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
--[[
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
]]
function imgui.TextQuestion(text)
  imgui.TextDisabled(fa.ICON_QUESTION)
  if imgui.IsItemHovered() then
	imgui.BeginTooltip()
	local p = imgui.GetCursorScreenPos()
	imgui.SetCursorScreenPos(imgui.ImVec2(p.x + 14,p.y + 14))
    imgui.PushTextWrapPos(450)
	imgui.TextUnformatted(text)
	local p = imgui.GetCursorScreenPos()
	local obrez = imgui.GetFont():CalcTextSizeA(imgui.GetFont().FontSize,450,450,text).x
	imgui.SetCursorScreenPos(imgui.ImVec2(p.x + obrez + 28,p.y + 14))
    imgui.PopTextWrapPos()
    imgui.EndTooltip()
  end
end
function imgui.ButtonDisabled(...)

    local r, g, b, a = imgui.ImColor(imgui.GetStyle().Colors[imgui.Col.Button]):GetFloat4()

    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(r, g, b, a/2) )
    imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(r, g, b, a/2))
    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(r, g, b, a/2))
    imgui.PushStyleColor(imgui.Col.Text, imgui.GetStyle().Colors[imgui.Col.TextDisabled])

        local result = imgui.Button(...)

    imgui.PopStyleColor()
    imgui.PopStyleColor()
    imgui.PopStyleColor()
    imgui.PopStyleColor()

    return result
end
function imgui.CenterText(text) 
	local width = imgui.GetWindowWidth()
	local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(text)
end
function imgui.CenterColumnText(text)
    imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text).x / 2)
    imgui.Text(text)
end
local cc = {}
function cc:hex(hex,alpha)
    alpha = tonumber(alpha) or 255
    local methods = {}
    function methods:rgb()
        return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
    end
    function methods:rgba()
        local r,g,b = methods:rgb()
        return r,g,b,alpha
    end
    function methods:ImVec4()
        local r,g,b,a = methods:rgba()
        return imgui.ImVec4(r/255,g/255,b/255,a/255)
    end
    function methods:ImColor()
        return imgui.ImColor(methods:ImVec4())
    end
    function methods:U32()
        return methods:ImColor():GetU32()
    end
    return methods
end
function imgui.CloseButton(rad,bool)
	local pos = imgui.GetCursorScreenPos()
	local poss = imgui.GetCursorPos()
	local a,b,c,d = pos.x - rad, pos.x + rad, pos.y - rad, pos.y + rad
	local e,f = poss.x - rad, poss.y - rad
    local list = imgui.GetWindowDrawList()
    local white = cc:hex('ffffff'):U32()
	list:AddLine(imgui.ImVec2(a,d),imgui.ImVec2(b,c),white)
	list:AddLine(imgui.ImVec2(b,d),imgui.ImVec2(a,c),white)
	imgui.SetCursorPos(imgui.ImVec2(e,f))
	if imgui.InvisibleButton('##closebutolo',imgui.ImVec2(rad*2,rad*2)) then
        if type(bool) == 'userdata' then
            bool.v = false
        elseif type(bool) == 'function' then
            bool()
        end
	end
end
function imgui.OnDrawFrame()
	if not doesFileExist(path..'\\fontawesome-webfont.ttf') or not doesFileExist(path..'\\azlogo160px.png') then return end
	imgui.ShowCursor = main_window_state.v 
	local sw, sh = getScreenResolution()
	if main_window_state.v then
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(1000,500), imgui.Cond.FirstUseEver)
		imgui.PushStyleVar(imgui.StyleVar.WindowPadding, imgui.ImVec2(0,0))
		imgui.Begin('ARZ Assistant',main_window_state,imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoTitleBar)
        local pos = imgui.GetCursorScreenPos()
		local color_menu = imgui.ImColor(imgui.GetStyle().Colors[imgui.Col.Button]):GetU32()
        imgui.GetWindowDrawList():AddRectFilled(imgui.ImVec2(pos.x, pos.y), imgui.ImVec2(pos.x + 1000, pos.y + 60), color_menu, imgui_theme_style.v * 6, 3)
		imgui.SetCursorPos(imgui.ImVec2(25,10))
		imgui.Image(arzlogo,imgui.ImVec2(40,40))
		if imgui.IsItemHovered() and imgui.IsItemClicked() then
			ShowListId = 0
		end
		imgui.RenderMenuItems()
		imgui.SetCursorPos(imgui.ImVec2(970,30))
		imgui.CloseButton(5.5,main_window_state)
		imgui.SetCursorPos(imgui.ImVec2(0,61))
		imgui.BeginGroup()
		if ShowListId == 0 then
			imgui.CreatePaddingY(12)
			imgui.CenterText(u8('Добро пожаловать, '..myname:gsub('_',' ')))
			imgui.Separator()
			imgui.CenterText(u8('Главное меню'))
			imgui.Separator()
			imgui.CreatePaddingX(20)
			imgui.BeginGroup()
			if imgui.Checkbox(u8('Тихий режим'),silentmode) then
				arzmessage('Тихий режим был '..(silentmode.v and 'включен' or 'выключен'))
				mainIni.config.silentmode = silentmode.v
				saveIniFile()	
			end
			imgui.SameLine()
			imgui.TextQuestion(u8('При включении тихого режмима все сообщения от скрипта будут в консоле SampFuncs(если у вас есть SF Integration.lua)'))
			if imgui.Checkbox(u8('Автообновление'),autoupdateenable) then
				mainIni.config.autoupdateenable = autoupdateenable.v
				saveIniFile()
			end
			imgui.SameLine()
			imgui.TextQuestion(u8('Автообновление автоматически проверит, есть ли обновление для скрипта и установит'))
			imgui.Text(fa.ICON_ADJUST..u8' Тема')
			imgui.PushItemWidth(120)
			if imgui.Combo('##_set|theme', imgui_theme, items, -1)then
				mainIni.config.theme = imgui_theme.v
				saveIniFile()
				setstyleandtheme()
			end
			imgui.Text(fa.ICON_ADJUST..u8' Стиль')
			if imgui.Combo('##_set|style', imgui_theme_style, styles, -1)then
				mainIni.config.styletheme = imgui_theme_style.v
				saveIniFile()	
				setstyleandtheme()
			end
			imgui.EndGroup()
			imgui.CreatePaddingY(5)
			imgui.Separator()
			imgui.CenterText(u8('Центр обновлений'))
			imgui.Separator()
			imgui.CreatePaddingX(20)
			imgui.BeginGroup()
			imgui.Text(u8('Результат проверки обновлений: '..(updates.data.result and 'успешно' or 'откланено')))
			imgui.Text(u8('Статус'))
			imgui.CreatePaddingX(20)
			imgui.Text(u8(tostring(updates.data.status)))
			if updates.data.result then
				imgui.Text(u8('Текущая версия скрипта: '..thisScript().version))
				imgui.Text(u8('Актуальная версия скрипта: '..updates.data.relevant_version))
			end
			if imgui.Button(u8('Проверить обновление'),imgui.ImVec2(150,20)) then
				updates:getlast()
			end
			imgui.SameLine()
			local renderdownloadupd = (updates.data.result and updates.data.relevant_version ~= thisScript().version) and imgui.Button or imgui.ButtonDisabled
			if renderdownloadupd(u8('Загрузить обновление'),imgui.ImVec2(150,20)) then
				if updates.data.result and updates.data.relevant_version ~= thisScript().version then
					updates:download()
				end
			end
			imgui.EndGroup()
			imgui.SetCursorPosY(470)
			imgui.Separator()
			imgui.CenterText(u8('made by ronnysoftware with love <3'))
		elseif ShowListId == 1 then
			imgui.BeginChild('##settings_elements',imgui.ImVec2(1000,440))
			setselements()
			imgui.EndChild()
		elseif ShowListId == 2 then
			imgui.BeginChild('##notf_elements',imgui.ImVec2(1000,440))
			notfelements()
			imgui.EndChild()
		elseif ShowListId == 3 then
			imgui.BeginChild('##info_elements',imgui.ImVec2(1000,440))
			infobarelements()
			imgui.EndChild()
		elseif ShowListId == 4 then
			imgui.BeginChild('##afill_accs_elements',imgui.ImVec2(1000,440))
			autofillelementsaccs()
			imgui.EndChild()
		elseif ShowListId == 5 then
			imgui.BeginChild('##afill_save_elements',imgui.ImVec2(1000,440))
			autofillelementssave()
			imgui.EndChild()
		elseif ShowListId == 6 then
			imgui.BeginChild('##changelog',imgui.ImVec2(1000,440),false,imgui.WindowFlags.HorizontalScrollbar)
			for n in changeloglist:gmatch('[^\r\n]+') do
				imgui.CreatePaddingX(8)
				if n:find('%{color%}') then
					n = n:gsub('%{color%}','')
					imgui.TextColored(cc:hex('A1A1A1'):ImVec4(),u8(n))
				else
					-- imgui.CreatePaddingX(8)
					-- imgui.Text(u8(n))
					imgui.Text(u8(n))
				end
			end
			-- imgui.TextColoredRGB(u8(changeloglist))
			imgui.EndChild()
		end
		imgui.EndGroup()
		imgui.End()
		imgui.PopStyleVar(1)
	end
	if show_window.v then
		local s1,s2 = position[1],position[2]
		imgui.SetNextWindowPos(imgui.ImVec2(s1,s2),imgui.Cond.FirstUseEver)
		imgui.Begin('ARZ Assistant##info',show_window,imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.ShowBorders)
		if arzwindelements then	
			arzwindelements()
		end
		imgui.End()
	end
	if piemenu.v then
		piemenuelements()
	end		
end
function imgui.BeforeDrawFrame()
	if fa_font == nil and doesFileExist(path..'\\fontawesome-webfont.ttf') then
		local font_config = imgui.ImFontConfig()
		font_config.MergeMode = true
		fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/ARZ Assistant/fontawesome-webfont.ttf', 11.0, font_config, fa_glyph_ranges)
	end
end
function autoeatelements()
	imgui.Separator()
	imgui.CenterText(u8'Автохавка')
	imgui.SameLine()
	imgui.TextQuestion(u8('Автоматически кушает еду способом, который вы укажете\nБудет кушать когда появится текст "You are hungry" или "You are very hungry"'))
	imgui.Separator()
	imgui.CreatePaddingX(10)
	imgui.BeginGroup()
	if imgui.RadioButton(u8'Оффнуть',eatmetod,0) then
		mainIni.eat.eatmetod = eatmetod.v
		saveIniFile()
	end
	if imgui.RadioButton(u8'Кушать Дома',eatmetod,1) then
		mainIni.eat.eatmetod = eatmetod.v
		saveIniFile()
	end
    imgui.SameLine()
	imgui.TextQuestion(u8'Ваш персонаж будет кушать дома из холодильника')
	
	if imgui.RadioButton(u8'Кушать вне Дома',eatmetod,2) then
		mainIni.eat.eatmetod = eatmetod.v
		saveIniFile()
	end
    imgui.SameLine()
    imgui.TextQuestion(u8'Ваш персонаж будет кушать вне дома способом из списка')
	
	if imgui.RadioButton(u8'Кушать в Фам КВ',eatmetod,3) then
		mainIni.eat.eatmetod = eatmetod.v
		saveIniFile()
	end
    imgui.SameLine()
    imgui.TextQuestion(u8'Ваш персонаж будет кушать из холодильника в семейной квартире. Для использования встаньте на место, где при нажатии ALT появится диалог с выбором еды')
	imgui.EndGroup()
	imgui.SameLine(250)
	imgui.BeginGroup()
	if eatmetod.v > 0 then
		imgui.PushItemWidth(140)
		if imgui.Combo(u8('Способ проверки голода'), checkmethod, {u8('You are hungry!'),u8('Полоска голода')}, -1) then
			mainIni.eat.checkmethod = checkmethod.v
			saveIniFile()
		end
		if checkmethod.v == 1 then
			imgui.PushItemWidth(80)
			if imgui.InputInt(u8('При скольки процентах голода надо кушать'),eat2met,0) then
				mainIni.eat.eat2met = eat2met.v
				saveIniFile()
			end
			imgui.PopItemWidth()
		end
		imgui.PopItemWidth()

		if eatmetod.v == 2 then
			imgui.Text(u8'Выбор метода еды:')
			imgui.PushItemWidth(100)
			if imgui.Combo('##ladnasd', setmetod, metod, -1) then mainIni.eat.setmetod = setmetod.v; saveIniFile() end
			imgui.PopItemWidth()
		end
	end
	imgui.EndGroup()
	imgui.SameLine()
	
	imgui.BeginGroup()
	if imgui.Checkbox(u8'АвтоХил', healstate) then
		mainIni.eat.healstate = healstate.v
		saveIniFile()
	end
    if healstate.v then
        imgui.PushItemWidth(30)
		if imgui.InputInt(u8('HP для Хила'), hplvl, 0) then
			mainIni.eat.hplvl = hplvl.v
			saveIniFile()
		end
        imgui.PopItemWidth()
        imgui.Text(u8'Выбор метода хила:')
        imgui.PushItemWidth(100)
        if imgui.Combo('##ban',hpmetod,healmetod,-1) then
			mainIni.eat.hpmetod = hpmetod.v
			saveIniFile()
		end
		imgui.PopItemWidth()
        if hpmetod.v == 1 then
			imgui.PushItemWidth(30)
			if imgui.InputInt(u8("Кол-во нарко"),drugsquen,0) then
				mainIni.eat.drugsquen = drugsquen.v
				saveIniFile()
			end
            imgui.PopItemWidth()
		end
    end
	imgui.EndGroup()
	imgui.CreatePaddingX(10)
	imgui.BeginGroup() 
	imgui.PushItemWidth(40)
	if imgui.InputInt(u8("TextDraw'a Еды"), arztextdrawid,0) then
		mainIni.eat.arztextdrawid = arztextdrawid.v
		saveIniFile()	
	end
	if imgui.InputInt(u8("TextDraw'a Хила"),arztextdrawidheal,0) then
		mainIni.eat.arztextdrawidheal = arztextdrawidheal.v
		saveIniFile()	
	end
	imgui.PopItemWidth()
	imgui.EndGroup()
	imgui.SameLine(250)
	imgui.Checkbox(u8'Разраб. мод', devmode); imgui.SameLine(); imgui.TextQuestion(u8'Показывает ID текстдравов')
end
function autofillelementsaccs()
	imgui.Separator()
	imgui.CreatePaddingX(10)
	if imgui.Button(u8'Сохранить аккаунт') then ShowListId = 5 end
	imgui.SameLine()
	if imgui.Button('Refresh') then
		local f = io.open(file, "r")
		if f then
			savepass = decodeJson(f:read("a*"))
			f:close()
		end
		arzmessage('Обновлено')
	end
	imgui.SameLine()
	if imgui.Checkbox(u8('Включить автозаполнение'),enable_autofill) then
		mainIni.config.enable_autofill = enable_autofill.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.CenterText(u8'Автозаполнение | Аккаунты')
	imgui.SameLine()
	imgui.TextQuestion(u8('Тут, вы можете просмотреть аккаунты и пароли которые вы сохранили'))
	imgui.Columns(3, _, true)
	imgui.Separator()
	imgui.CreatePaddingX(5)
	imgui.SetColumnWidth(-1, 150); imgui.Text(u8"Никнейм"); imgui.NextColumn()
	imgui.SetColumnWidth(-1, 180); imgui.Text(u8"Сервер"); imgui.NextColumn()
	imgui.SetColumnWidth(-1, 420); imgui.Text(u8"Пароли"); imgui.NextColumn()
	for k, v in pairs(savepass) do
		imgui.Separator()
		passcount = #v[3]
		-- print()
		imgui.CreatePaddingX(5)
		if imgui.Selectable(u8(v[1]..'##'..k), false, imgui.SelectableFlags.SpanAllColumns) then imgui.OpenPopup('##acc'..k) end
		-- imgui.SetNextWindowSize(imgui.ImVec2(400,250))
		if imgui.BeginPopupModal('##acc'..k,true,imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize) then
			btnWidth = imgui.GetWindowWidth() - 20
			btnWidth2 = imgui.GetWindowWidth() - 25
			imgui.CreatePaddingY(8)
			imgui.CenterText(u8('Аккаунт '..v[1]))
			imgui.Separator()
			for f,t in pairs(v[3]) do
				imgui.CreatePaddingX(8)
				imgui.Text(u8('Диалог[ID]: '..v[3][f].id..' Введённые данные: '..v[3][f].text))
				imgui.SameLine()
				imgui.CreatePaddingX(8)
				imgui.InvisibleButton('##'..f,imgui.ImVec2(0,0))
				if editpass.numedit == f then
					imgui.CreatePaddingX(8)
					imgui.PushItemWidth(btnWidth+2)
					imgui.InputText(u8'##pass'..f,editpass.input)
					imgui.PopItemWidth()
				end
				if editpass.numedit == -1 then
					imgui.SetCursorPosX(10)
					if imgui.Button(u8("Сменить пароль##"..f), imgui.ImVec2(btnWidth, 0)) then
						editpass.input.v = v[3][f].text
						editpass.numedit = f
						arzmessage('Введите в поле новый пароль и нажмите кнопку "Подтвердить"')
					end
				elseif editpass.numedit == f then
					imgui.SetCursorPosX(10)
					if imgui.Button(u8("Подтвердить##"..f), imgui.ImVec2(btnWidth, 0)) then
						v[3][f].text = editpass.input.v
						editpass.input.v = ''
						editpass.numedit = -1
						arzmessage('Пароль изменён!')
						savejson()
					end
				end
				imgui.SetCursorPosX(10)
				if imgui.Button(u8("Копировать пароль##"..f), imgui.ImVec2(btnWidth2/2, 0)) then
					setClipboardText(v[3][f].text)
					arzmessage('Пароль скопирован!')
					imgui.CloseCurrentPopup()
				end
				imgui.SameLine()
				if imgui.Button(u8("Удалить пароль##"..f), imgui.ImVec2(btnWidth2/2, 0)) then
					v[3][f] = nil
					arzmessage('Пароль удален!')
					if #v[3] == 0 then
						savepass[k] = nil
					end
					imgui.CloseCurrentPopup()
					savejson()
				end
				imgui.Separator()
			end
			imgui.SetCursorPosX(10)
			if imgui.Button(u8("Подключиться"), imgui.ImVec2(btnWidth, 0)) then
				local ip2, port2 = string.match(v[2], "(.+)%:(%d+)")
				reconname(v[1],ip2, tonumber(port2))

			end
			imgui.SetCursorPosX(10)
			if imgui.Button(u8("Удалить все данные"), imgui.ImVec2(btnWidth, 0)) then
				savepass[k] = nil
				imgui.CloseCurrentPopup()
				savejson()
			end
			imgui.SetCursorPosX(10)
			if imgui.Button(u8("Закрыть"), imgui.ImVec2(btnWidth, 0)) then
				imgui.CloseCurrentPopup()
			end
			imgui.CreatePaddingY(8)
			imgui.EndPopup()
		end
		imgui.NextColumn()
		imgui.Text(tostring((arz_servers[v[2]] and arz_servers[v[2]] or v[2])))
		imgui.NextColumn()
		imgui.Text(u8('Кол-во паролей: '..passcount..'. Нажмите ЛКМ для управления паролями'))
		imgui.NextColumn()
	end
	imgui.Columns(1)
	imgui.Separator()
end
function autofillelementssave()
	imgui.Separator()
	if imgui.Button(u8'< Аккаунты') then ShowListId = 4 end
	imgui.SameLine(); 
	if imgui.Button('Clear') then temppass = {}; arzmessage('Буфер временных паролей очищен!') end
	imgui.SameLine()
	imgui.CenterText(u8'Автозаполнение | Введенные данные')
	imgui.SameLine()
	imgui.TextQuestion(u8('Здесь, вы можете найти все что вы вводили в диалоги\nНажав на строку с данными, они сохранятся в аккаунты'))
	imgui.Columns(5, _, true)
	imgui.Separator()
	imgui.CreatePaddingX(5)
	imgui.SetColumnWidth(-1, 160); imgui.Text(u8"Диалог[ID]"); imgui.NextColumn()
	imgui.SetColumnWidth(-1, 150); imgui.Text(u8"Никнейм"); imgui.NextColumn()
	imgui.SetColumnWidth(-1, 150); imgui.Text(u8"Сервер"); imgui.NextColumn()
	imgui.SetColumnWidth(-1, 170); imgui.Text(u8"Введенные данные"); imgui.NextColumn()
	imgui.SetColumnWidth(-1, 140); imgui.Text(u8"Время"); imgui.NextColumn()
	imgui.Separator()
	for k, v in pairs(temppass) do
		imgui.CreatePaddingX(5)
		if imgui.Selectable(tostring(u8(string.gsub(v.title, "%{.*%}", "") .. "[" .. v.id .. "]")) .. "##" .. k, false, imgui.SelectableFlags.SpanAllColumns) then
			local data = temppass[k]
			local id = findAcc(data.nick, data.ip)
			if id > -1 then
				local dId = findDialog(id, data.id)
				if dId == -1 then
					table.insert(savepass[id][3], {
						id = data.id,
						text = data.text
					})
				end
			else
				table.insert(savepass, {
					data.nick,
					data.ip,
					{
						{
							id = data.id,
							text = data.text
						}
					}
				})
			end
			savejson()
			arzmessage('Пароль '..v.text..' для аккаунта '..v.nick..' на сервере '..(arz_servers[v.ip] and arz_servers[v.ip] or v.ip)..' сохранён!')
		end
		imgui.NextColumn()
		imgui.Text(tostring(v.nick))
		imgui.NextColumn()
		imgui.Text(tostring((arz_servers[v.ip] and arz_servers[v.ip] or v.ip)))
		imgui.NextColumn()
		imgui.Text(tostring(u8(v.text)))
		imgui.NextColumn()
		imgui.Text(tostring(v.time))
		imgui.NextColumn()
	end
	imgui.Columns(1)
	imgui.Separator()
end
function notfelements()
	imgui.Separator()
	imgui.CenterText(u8'Уведомления')
	imgui.SameLine()
	imgui.TextQuestion(u8'Отправление уведомлений в Telegram и/или VK. Отправку уведомлений можно настроить ниже.')
	-- imgui.Separator()
	imgui.PushStyleVar(imgui.StyleVar.WindowPadding, imgui.ImVec2(8,8))
	imgui.PushStyleVar(imgui.StyleVar.WindowRounding, 6)
	if imgui.BeginPopupModal('##aboutTG',true,imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize) then 
		imgui.Text(u8(howsetTG))
		local wid = imgui.GetWindowWidth()
		imgui.SetCursorPosX(wid / 2 - 30)
		if imgui.Button(u8'Закрыть', imgui.ImVec2(60,20)) then
			imgui.CloseCurrentPopup()
		end
		imgui.EndPopup()
	end
	imgui.PopStyleVar(2)
	imgui.Separator()
	imgui.CenterText(fa.ICON_TELEGRAM..u8' Настройки для Telegram')
	imgui.Separator()
	imgui.CreatePaddingX(10)
	imgui.BeginGroup()
	imgui.Text(u8'Ваш Token: ') 
	imgui.PushItemWidth(220) 
	if imgui.InputText(u8'##ache2',tg_token, showtoken.tg, imgui.SameLine()) then 
		mainIni.notifications.tg_token = tg_token.v; 
		saveIniFile() 
	end 
	imgui.PopItemWidth(); 
	imgui.SameLine(); 
	if imgui.Button(u8'Показать токен##1') then 
		showtoken.tg = showtoken.tg == 0 and 32768 or 0
	end	
	imgui.Text(u8'Ваш ChatID: ') 
	imgui.PushItemWidth(120) 
	if imgui.InputText(u8'##ache',chat_id,imgui.SameLine()) then 
		mainIni.notifications.chat_id = chat_id.v; 
		saveIniFile() 
	end 
	imgui.PopItemWidth()
	if tgerr then
		imgui.Text(u8('Состояние: '..tgerr))
	else	
		imgui.Text(u8('Состояние: Активное!'))
	end
	if imgui.Button(u8('Переподключиться к Telegram')) then
		getLastUpdate()
	end
	if imgui.Checkbox(u8'Включить уведомления Telegram',send_tg) then
		mainIni.notifications.send_tg = send_tg.v
		saveIniFile()
	end
	imgui.SameLine()
	if imgui.Button(u8'Как настроить?##TG',imgui.ImVec2(120,20)) then
		imgui.OpenPopup('##aboutTG')
	end
	imgui.EndGroup()
	imgui.Separator()
	imgui.CenterText(fa.ICON_VK..u8' Настройки для VK')
	imgui.Separator()
	imgui.SetNextWindowSize(imgui.ImVec2(800,450))
	imgui.PushStyleVar(imgui.StyleVar.WindowPadding, imgui.ImVec2(8,8))
	imgui.PushStyleVar(imgui.StyleVar.WindowRounding, 6)
	if imgui.BeginPopupModal('##aboutVK',true,imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize) then
		imgui.Text(u8(howsetVK))
		local wid = imgui.GetWindowWidth()
		imgui.SetCursorPosX(wid / 2 - 30)
		if imgui.Button(u8'Закрыть', imgui.ImVec2(60,20)) then
			imgui.CloseCurrentPopup()
		end
		imgui.EndPopup()
	end
	imgui.PopStyleVar(2)
	imgui.CreatePaddingX(10)
	imgui.BeginGroup()
	imgui.Text(u8'Ваш Token Группы: ') 
	imgui.PushItemWidth(360) 
	if imgui.InputText(u8'##ache2vk',vk_token,showtoken.vk,imgui.SameLine()) then 
		mainIni.notifications.vk_token = vk_token.v;
		saveIniFile() 
	end 
	imgui.PopItemWidth() 
	imgui.SameLine()
	if imgui.Button(u8'Показать токен##2') then 
		showtoken.vk = showtoken.vk == 0 and 32768 or 0
	end	
	imgui.Text(u8'Ваш VK ID: ') imgui.PushItemWidth(120) if imgui.InputText(u8'##achevk',user_id,imgui.SameLine()) then mainIni.notifications.user_id = user_id.v; saveIniFile() end imgui.PopItemWidth()	
	imgui.Text(u8'VK ID Группы(требуется для команд !getstats, !getinfo и др.): ') imgui.PushItemWidth(120) if imgui.InputText(u8'##achevk1122',group_id,imgui.SameLine()) then mainIni.notifications.group_id = group_id.v; saveIniFile() end imgui.PopItemWidth()	
	if imgui.Checkbox(u8'Включить уведомления VK',send_vk) then 
		mainIni.notifications.send_vk = send_vk.v
		saveIniFile()
		if send_vk.v then
			arzmessage('Запрашиваю доступ к VK API')
			longpollGetKey()
		end 
	end 
	if vkerr then
		imgui.Text(u8'Состояние приёма: ' .. u8(vkerr))
		imgui.SameLine()
		if imgui.Button(u8('Переподключиться к серверам')) then longpollGetKey() end
	else
		imgui.Text(u8'Состояние приёма: Активно!')
	end
	if vkerrsend then
		imgui.Text(u8'Состояние отправки: ' .. u8(vkerrsend))
	else
		imgui.Text(u8'Состояние отправки: Активно!')
	end
	if imgui.Button(u8'Как настроить?##VK',imgui.ImVec2(120,20)) then
		imgui.OpenPopup('##aboutVK')
	end
	imgui.EndGroup()
	imgui.Separator()
	imgui.CenterText(fa.ICON_EXTERNAL_LINK_SQUARE .. u8' Что отправлять в уведомлениях?')
	imgui.Separator()
	imgui.CreatePaddingX(10)
	imgui.BeginGroup()
	if imgui.Checkbox(u8'При подключении к серверу',if_join) then
		mainIni.notifications.if_join = if_join.v
		saveIniFile()
	end
	if imgui.Checkbox(u8'При закрытии соединения',if_kick) then
		mainIni.notifications.if_kick = if_kick.v
		saveIniFile()
	end
	if imgui.Checkbox(u8'Вы голодны',if_hungry) then
		mainIni.notifications.if_hungry = if_hungry.v
		saveIniFile()
	end
	if imgui.Checkbox(u8'Если администратор что-то сделал с вами',if_admin) then
		mainIni.notifications.if_admin = if_admin.v
		saveIniFile()
	end
	if imgui.Checkbox(u8'Если скрипт умрет(крашнется)',if_script_err) then
		mainIni.notifications.if_script_err = if_script_err.v
		saveIniFile()
	end
	if imgui.Checkbox(u8'Если вы умрете',if_dead) then
		mainIni.notifications.if_dead = if_dead.v
		saveIniFile()
	end
	if imgui.Checkbox(u8'Если вам нанесут дамаг',if_damage) then
		mainIni.notifications.if_damage = if_damage.v
		saveIniFile()
	end
	if imgui.Button(u8'Проверить уведомления') then
		sendnotification('Проверка уведомлений!')
	end
	imgui.EndGroup()
end
function infobarelements()
	imgui.Separator()
	imgui.CenterText(u8'Информация о скрипте')
	imgui.Separator()
	imgui.CreatePadding(10,5)
	imgui.Text(u8(helplist))
	imgui.CreatePadding(10,15)
	imgui.BeginGroup()
	if imgui.Button(fa.ICON_VK..u8' ВК тестера') then
		arzmessage('Ссылка на ВК тестера скопирована в буфер обмена\nvk.com/a_kipu',5)
		setClipboardText('https://vk.com/a_kipu')
	end
	imgui.SameLine()
	if imgui.Button(fa.ICON_TELEGRAM..u8' Канал TG автора') then
		arzmessage('Ссылка на telegram канал автора скопирована в буфер обмена\nt.me/ronnysoftware',5)
		setClipboardText('https://t.me/ronnysoftware')
	end
	if imgui.Button(fa.ICON_FILES_O..u8' Discord') then
		arzmessage('Discord скопирован в буфер обмена\nronny#5509',5)
		setClipboardText('ronny#5509')
	end
	imgui.SameLine()
	if imgui.Button(fa.ICON_COMMENTS..u8' Поддержка') then 
		os.execute('explorer https://t.me/ronnysoftware_support_bot')
	end
	imgui.EndGroup()
end
function piemenuelements()
	local sww,shh = getScreenResolution()
	local pipisize = imgui.CalcTextSize(table.concat(getKeysName(piemenu_keys.v), " + "))
	imgui.SetNextWindowPos(imgui.ImVec2(sww - pipisize.x - 200,shh/2))
	imgui.Begin('##titlePie',_,imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.AlwaysAutoResize)
	imgui.Text(u8('Менюшка PieMenu активна!\nНажмите ПКМ чтобы открыть\nНажмите '..table.concat(getKeysName(piemenu_keys.v), " + ")..' чтобы выключить'))
	imgui.End()
	if imgui.IsMouseDown(1) then
		imgui.ShowCursor = true
		piemenuIsAct = true
		imgui.OpenPopup('PieMenu')
	else
		if piemenuIsAct then
			piemenuIsAct = false
			piemenu.v = false
		end
	end
	if pie.BeginPiePopup('PieMenu', 1) then
		if pie.BeginPieMenu('  '..fa.ICON_CAR..'  ') then --cars
				if pie.PieMenuItem(fa.ICON_TACHOMETER..' Style') then
					sampSendChat('/style')
					piemenu.v = false
				end
				if pie.PieMenuItem(fa.ICON_LOCK..' Lock') then
					sampSendChat('/lock')
					piemenu.v = false
				end
				if pie.PieMenuItem('Engine') then
					sampSendChat('/engine')
					piemenu.v = false
				end
				if pie.PieMenuItem(fa.ICON_KEY..' Keys') then
					sampSendChat('/key')
					piemenu.v = false
				end
			if pie.BeginPieMenu('Fill') then
				if pie.PieMenuItem('\tCanister\t') then
					sampSendChat('/fillcar')
					piemenu.v = false
				end
				if pie.PieMenuItem('Station') then
					sampSendChat('/fill')
					piemenu.v = false
				end
				pie.EndPieMenu()
			end
			if pie.PieMenuItem(fa.ICON_WRENCH..' Rep.') then
				sampSendChat('/repcar')
				piemenu.v = false
			end
			pie.EndPieMenu()
		end
		if pie.BeginPieMenu(fa.ICON_HOME..'') then
			if pie.PieMenuItem(fa.ICON_UNLOCK_ALT..' Doors') then
				piemenu.v = false
				lua_thread.create(function() sampSendChat('/home') wait(300) sampSendDialogResponse(174,1,0,false) while not sampIsDialogActive() do wait(0) end sampCloseCurrentDialogWithButton(0)  end)
			end
			if pie.PieMenuItem(fa.ICON_SHOPPING_CART..' Prods.') then
				piemenu.v = false
				lua_thread.create(function() sampSendChat('/home') wait(300) if sampGetListboxItemsCount() == 3 then arzmessage('Вы подселены и не можете проверить продукты!') while not sampIsDialogActive() do wait(0) end sampCloseCurrentDialogWithButton(0) else sampSendDialogResponse(174,1,7,false) end end)
			end
			if pie.PieMenuItem(fa.ICON_ID_CARD..' Taxes') then
				piemenu.v = false
				lua_thread.create(function() sampSendChat('/home') wait(300) if sampGetListboxItemsCount() == 3 then arzmessage('Вы подселены и не можете проверить налог!') while not sampIsDialogActive() do wait(0) end sampCloseCurrentDialogWithButton(0) else sampSendDialogResponse(174,1,6,false) end end)
			end
			if pie.PieMenuItem(fa.ICON_CUTLERY..' Eat') then
				piemenu.v = false
				lua_thread.create(function() sampSendChat('/home') wait(300) sampSendDialogResponse(174,1,1,false) wait(200) sampSendDialogResponse(2431,1,0,false) wait(200) sampSendDialogResponse(185,1,6,false) while not sampIsDialogActive() do wait(0) end sampCloseCurrentDialogWithButton(0) end)
			end
			pie.EndPieMenu()
		end
		if pie.BeginPieMenu(fa.ICON_MOUSE_POINTER..'') then
			local veh, ped = storeClosestEntities(PLAYER_PED)
			local getresult, id = sampGetPlayerIdByCharHandle(ped)
			if pie.PieMenuItem(fa.ICON_PHONE_SQUARE..' Phone') then
				piemenu.v = false
				sampSendChat('/phone')
			end
			if pie.PieMenuItem(fa.ICON_SHIELD..' Armour') then
				piemenu.v = false
				sampSendChat('/armour')
			end
			if pie.PieMenuItem(fa.ICON_USER_SECRET..' Mask') then
				piemenu.v = false
				sampSendChat('/mask')
			end
			pie.EndPieMenu()
		end	
		if pie.BeginPieMenu(fa.ICON_HEART..'') then
			if pie.PieMenuItem(fa.ICON_HEARTBEAT..' /us 1') then
				piemenu.v = false
				sampSendChat('/usedrugs 1')
			end
			if pie.PieMenuItem(fa.ICON_HEARTBEAT..' /us 2') then
				piemenu.v = false
				sampSendChat('/usedrugs 2')
			end
			if pie.PieMenuItem(fa.ICON_HEARTBEAT..' /us 3') then
				piemenu.v = false
				sampSendChat('/usedrugs 3')
			end
			if pie.PieMenuItem(fa.ICON_MEDKIT..' Medkit') then
				piemenu.v = false
				sampSendChat('/usemed')
			end
			pie.EndPieMenu()
		end
		if pie.BeginPieMenu(fa.ICON_USERS..'') then
			local veh, ped = storeClosestEntities(PLAYER_PED)
			local getresult, id = sampGetPlayerIdByCharHandle(ped)
			if pie.PieMenuItem(fa.ICON_HAND_PAPER_O..' Hi') then
				piemenu.v = false
				if getresult then
					sampSendChat('/hi '..id)
				end
			end
			if pie.PieMenuItem(fa.ICON_BRIEFCASE..' Trade') then
				piemenu.v = false
				if getresult then
					sampSendChat('/trade '..id)
				end
			end
			if pie.PieMenuItem(fa.ICON_USER_TIMES..' Free') then
				piemenu.v = false
				if getresult then
					sampSendChat('/free '..id)
				end
			end
			pie.EndPieMenu()
		end
		--[[
			if pie.BeginPieMenu('') then
				if pie.PieMenuItem('') then
	
				end
				pie.EndPieMenu()
			end
		]]
		pie.EndPiePopup()
	end		
end
function setselements()
	otherelements()
	autoeatelements() 
	vipelements()
	lovlyaelements()
	assistantelements()
	famelements()
	autorecelements()
	piarelements()
	autoelements()
	timeelements()
	-- checkerelements()
	skipdialogselements()
	reconelements()
	rpdmelements()
end
function otherelements()
	imgui.Separator()
	imgui.CenterText(u8('Основные'))
	imgui.Separator()
	imgui.CreatePaddingX(10)
	imgui.BeginGroup()

	if imgui.Checkbox(u8'AntiBlockedPlayer', antiblockplayer) then
		mainIni.config.antiblockplayer = antiblockplayer.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Если вы застряните в человеке, вы сможете спокойно из него выйти')
	if imgui.Checkbox(u8'ShieldControl', shieldcontrol) then
		mainIni.config.shieldcontrol = shieldcontrol.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'При нажатии на клавишу "I" скрипт зажмёт комбинацию для активации щита и будет держать её пока вы не отключите')
	if imgui.Checkbox(u8'Bunnyhop', bhop) then
		mainIni.config.bhop = bhop.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Если при беге вы нажмёте прыжок, ваш персонаж не упадет')
	if imgui.Checkbox(u8'Быстрый бег', fastrun_act) then
		mainIni.config.fastrun_act = fastrun_act.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'При нажатии на '..table.concat(getKeysName(fastrun_keys.v), " + ")..u8', скрипт будет быстро нажимать и отжимать клавишу бега')
	if fastrun_act.v then
		imgui.SameLine()
		if imadd.HotKey('##fastrun',fastrun_keys,{},100) then
			mainIni.config.fastrun_keys = encodeJson(fastrun_keys.v)
			saveIniFile()
		end
	end
	if imgui.Checkbox(u8'Бесконечный бег', infrun) then
		mainIni.config.infrun = infrun.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Ваш персонаж больше не будет уставать')
	if imgui.Checkbox(u8'InputHelper', inputhelper) then
		mainIni.config.inputhelper = inputhelper.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Функция которая поможет вам с чатом сампа.\nПри активации вам будет доступно:\nОткрывать чат на русской раскладке при помощи кнопки Т.\nПод чатом будет строка которая поможет вам при печати.\nПри русской раскладке в начале строки "." будет заменяться на "/" и после писать на англ. (только 1 слово)')
	if imgui.Checkbox(u8'AutoBreak', autobreak) then
		mainIni.config.autobreak = autobreak.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Если на экране будет надпись "РRЕSS <Кнопка>" то скрипт автоматически нажмёт её\nРаботает только для взлома авто')
	if imgui.Checkbox(u8'Свет от фонарей', light_from_lanterns) then
		mainIni.config.light_from_lanterns = light_from_lanterns.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'На фонари будет добавляться свет')
	if imgui.Checkbox(u8'Очистка чата от ерунды', floodclear) then
		mainIni.config.floodclear = floodclear.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Очистка чата от ненужной информации по типу оповещения о донате и т.д')
	if imgui.Checkbox(u8'Информация о кд для армора', armour_info) then
		mainIni.config.armour_info = armour_info.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Информация о том, когда вы можете надеть армор')
	if imgui.Checkbox(u8'Время маски', mask_timer) then
		mainIni.config.mask_timer = mask_timer.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Когда на вас будет маска, запустится секундомер')
	if imgui.Checkbox(u8'Акцент', accent_state) then
		mainIni.config.accent_state = accent_state.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Когда вы что-то напишите в чат, /s, /c то сообщение отправится с акцентом. Пример: [Котячий акцент] Прив')
	if accent_state.v then
		imgui.PushItemWidth(100)
		if imgui.InputText(u8'Ваш акцент', accent_text, imgui.SameLine()) then
			mainIni.config.accent_text = u8:decode(accent_text.v)
			saveIniFile()
		end
		imgui.PopItemWidth()
	end
	if imgui.Checkbox(u8'Fastconnect', fastconnect) then 
		sampFastConnect(fastconnect.v)
		mainIni.config.fastconnect = fastconnect.v
		saveIniFile()
	end 
	imgui.SameLine()
	imgui.TextQuestion(u8'Быстрое подключение к серверу')
	imgui.EndGroup()
	
	imgui.SameLine()
	
	imgui.BeginGroup()
	if imgui.Checkbox(u8'Сбив /anim', auto_knock) then
		mainIni.config.auto_knock = auto_knock.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Когда на экране будет написано "Press ENTER to stop animation" скрипт нажмёт Enter')
	if imgui.Checkbox(u8'AntiAFK', antiafk) then
		workpaus(antiafk.v)
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Если вы свернёте игру, вы не будете стоять в AFK')
	if imgui.Checkbox(u8'HPHUD', hp_hud) then
		mainIni.config.hp_hud = hp_hud.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Обычный HPHUD')
	if imgui.Checkbox(u8'PieMenu', piemenu_act) then
		mainIni.config.piemenu_act = piemenu_act.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8('Быстрое меню. Активация: Нажмите '..table.concat(getKeysName(piemenu_keys.v), " + ")..', после зажмите ПКМ. '))
	imgui.SameLine()
	if imadd.HotKey("##active", piemenu_keys, {}, 100) then
		mainIni.config.piemenu_keys = encodeJson(piemenu_keys.v)
		saveIniFile()
	end
	if imgui.Checkbox(u8'Автозаправка', auto_fill_gas) then
		mainIni.config.auto_fill_gas = auto_fill_gas.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'При заправке транспорта на АЗС, скрипт сам выберет тип топлива и заправит полный бак')
	if imgui.Checkbox(u8'Телефон', phone_cheatcode) then
		mainIni.config.phone_cheatcode = phone_cheatcode.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Достаёт телефон при вводе чит-кода PH или команды /phn.')
	if imgui.Checkbox(u8'Маска', binds_mask) then
		mainIni.config.binds_mask = binds_mask.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Надевает маску при вводе чит-кода MASK.')
	if imgui.Checkbox(u8'Бронижилет', binds_armour) then
		mainIni.config.binds_armour = binds_armour.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Надевает бронижилет при вводе чит-кода ARM.')
	imgui.EndGroup()
	imgui.SameLine()
	imgui.BeginGroup()
	if imgui.Checkbox(u8'Отыгровка бронижилета', binds_text_armour) then
		mainIni.config.binds_text_armour = binds_text_armour.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Если вы наденете/снимите бронижилет, отправится отыгровка в /do.')
	if imgui.Checkbox(u8'Рендер 3D о состоянии дверей авто', render_cardoors_state) then
		mainIni.config.render_cardoors_state = render_cardoors_state.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Будет рендерить 3D текст о открытых/закрытых дверях авто если находитесь в 15 метрах от авто')
	if imgui.Checkbox(u8'Переотправить сообщение в /vr', returnmessageforvr) then
		mainIni.config.returnmessageforvr = returnmessageforvr.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8('Если вы или скрипт отправит серверу какое-то сообщение в /vr и в чате будет найдено сообщение "После последнего сообщения в этом чате нужно подождать 1 секунду" от сервера(не от игрока) то скрипт переотправит то сообщение что вы/скрипт отправил'))
	if imgui.Checkbox(u8'New Marker Color', newmarkercolor) then
		mainIni.config.newmarkercolor = newmarkercolor.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Смена цвета маркера\nДля того чтобы цвет маркера поменялся требуется перезагрузить его(войдите в инту или отбегите от него)!')
	if newmarkercolor.v then
		imgui.Text(' ')
		imgui.SameLine(20)
		imgui.BeginGroup()
		imgui.Text(u8('Цвет маркера'))
		imgui.SameLine()
		imgui.PushStyleVar(imgui.StyleVar.WindowPadding, imgui.ImVec2(8,8))
		if imgui.ColorEdit3('##сolor123123', markcolor, imgui.ColorEditFlags.NoInputs) then
			mainIni.markcolor.r,mainIni.markcolor.g,mainIni.markcolor.b = markcolor.v[1]*255,markcolor.v[2]*255,markcolor.v[3]*255
			saveIniFile()
		end
		imgui.PopStyleVar()
		imgui.SameLine()
		imgui.TextQuestion(u8('При смене цвета перезагрузите маркер'))
		imgui.Text(u8('Режим затухания'))
		imgui.SameLine()
		if imadd.ToggleButton(u8('##rain'),newmarkercolor_rainbow) then
			mainIni.config.newmarkercolor_rainbow = newmarkercolor_rainbow.v
			saveIniFile()
		end
		imgui.SameLine()
		imgui.TextQuestion(u8('Маркер будет затухать и вновь появлятся'))
		imgui.EndGroup()
	end
	if imgui.Checkbox(u8('Перевод из секунд в минуты в деморгане'),fromSecToMinInDemoran) then
		mainIni.config.fromSecToMinInDemoran = fromSecToMinInDemoran.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8('Переводит из секунд в минуты в деморгане\nПример: Jailed 3600 sec. = 60 min'))
	if imgui.Checkbox(u8('Fisheye'),fisheye) then
		mainIni.config.fisheye = fisheye.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8('Обычный рыбий глаз'))
	if fisheye.v then
		imgui.SameLine()
		imgui.PushItemWidth(150)
		if imgui.SliderInt(u8('Радиус'),fisheye_rad,0,150) then
			mainIni.config.fisheye_rad = fisheye_rad.v
			saveIniFile()
		end
		imgui.PopItemWidth()
	end
	if imgui.Checkbox(u8('AntiScare'),antiscare) then mainIni.config.antiscare = antiscare.v saveIniFile() end imgui.SameLine() imgui.TextQuestion(u8('Убирает текстдрав маски при /scare'))
	if imgui.Checkbox(u8('AntiLomka'),antilomka) then mainIni.config.antilomka = antilomka.v saveIniFile() end imgui.SameLine() imgui.TextQuestion(u8('Убирает надпись в чате и камера не шатается'))
	if imgui.Checkbox(u8('Кто меня убил?'),whokillme) then mainIni.config.whokillme = whokillme.v saveIniFile() end imgui.SameLine() imgui.TextQuestion(u8('Если вас убъют, появится уведомление о человеке, который вас убил'))
	imgui.EndGroup()
end	
function autoelements()
	imgui.Separator()
	imgui.CenterText(u8 'Авто')
	imgui.Separator()
	imgui.CreatePaddingX(10)
	imgui.BeginGroup()
	if imgui.Checkbox(u8'Вставить/Достать ключи', binds_key) then
		mainIni.config.binds_key = binds_key.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'При нажатии на клавишу K вы вставите/достаните ключи из вашего авто.')
	if imgui.Checkbox(u8'Открыть/Закрыть личного авто', binds_lock) then
		mainIni.config.binds_lock = binds_lock.v
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'При нажатии на клавишу L ваше личное авто откроется/закроется.')
	if imgui.Checkbox(u8'Открыть/Закрыть орг. авто', binds_olock) then
		mainIni.config.binds_olock = binds_olock.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'При нажатии на клавишу O ваше орг. авто откроется/закроется.')		
	if imgui.Checkbox(u8'Открыть/Закрыть аренд. авто', binds_jlock) then
		mainIni.config.binds_jlock = binds_jlock.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'При нажатии на клавишу J ваше аренд. авто откроется/закроется.')
	imgui.EndGroup()	
end
function vipelements()
	imgui.Separator()
	imgui.CenterText(u8 'Вип Чат')
	imgui.Separator()
	imgui.CreatePaddingX(10)
	imgui.BeginGroup()
	if imgui.Checkbox(u8"Приветствовать Titan/Premium VIP'ов", send_sms_if_vip) then
		mainIni.config.send_sms_if_vip = send_sms_if_vip.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Когда игрок купит VIP в /vr отправится сообщение из окна настроек.')
	if send_sms_if_vip.v then
		if imgui.InputText(u8'Titan VIP', sms_vr_vip) then
			mainIni.config.sms_vr_vip = u8:decode(sms_vr_vip.v)
			saveIniFile()
		end
		if imgui.InputText(u8'Premium VIP', sms_vr_prem) then
			mainIni.config.sms_vr_prem = u8:decode(sms_vr_prem.v)
			saveIniFile()
		end
	end
	imgui.EndGroup()
end
function piarelements()
	imgui.Separator()
	imgui.CenterText(u8'Пиар бизнеса')
	imgui.SameLine()
	imgui.TextQuestion(u8'Пиар ваших бизнесов. Введите в одну из строчек куда хотите пиарить и что пиарить. Например: /vr (и ваш текст пиара). Активация: /bizpiar')	
	imgui.Separator()
	imgui.CreatePaddingX(10)
	imgui.BeginGroup()
	imgui.Text(u8('Режим антинпвр'))
	imgui.SameLine()
	if imadd.ToggleButton('##antivr',anti_mute) then
		mainIni.biz_piar.anti_mute = anti_mute.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8('Если в тексте будет найдено {getsendmessagescount} то оно заменится на количество отправленных пиаров\nЭто можно использовать для того чтобы вас не замутили'))
	
	if imgui.InputText(u8'Основной', piar_string_1) then
		mainIni.biz_piar.piar_string_1 = u8:decode(piar_string_1.v)
		saveIniFile()
	end
	if imgui.Checkbox(u8'Включить доп.пиар##1',add_2_str) then
		mainIni.biz_piar.add_2_str = add_2_str.v
		saveIniFile()
	end
	if imgui.InputText(u8'Доп.пиар', piar_string_2) then
		mainIni.biz_piar.piar_string_2 = u8:decode(piar_string_2.v)
		saveIniFile()
	end
	if imgui.Checkbox(u8'Включить доп.пиар##2',add_3_str) then
		mainIni.biz_piar.add_3_str = add_3_str.v
		saveIniFile()
	end
	
	if imgui.InputText(u8'Ещё доп.пиар', piar_string_3) then
		mainIni.biz_piar.piar_string_3 = u8:decode(piar_string_3.v)
		saveIniFile()
	end
	imgui.PushItemWidth(120)
	if imgui.InputInt(u8('Задержка####send'), biz_piar_wait) then
		if biz_piar_wait.v < 0 then biz_piar_wait.v = 0 end 
		mainIni.biz_piar.wait = biz_piar_wait.v
		saveIniFile()
	end
	imgui.PopItemWidth()
	imgui.SameLine()
	imgui.TextQuestion(u8'Задержка отправки сообщений пиара. Выставлять в секундах.')
	imgui.EndGroup()
end
function lovlyaelements()
	imgui.Separator()
	imgui.CenterText(u8'Ловля')
	imgui.Separator()
	imgui.CreatePaddingX(10)
	imgui.BeginGroup()
	if imgui.Checkbox(u8'Сообщение после ловли', message_catch_state) then
		mainIni.config.message_catch_state = message_catch_state.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Когда вы словите дом/авто/бизнес в чат отправится сообщение, которое вы установили ниже.')
	if message_catch_state.v then
		if imgui.InputText(u8('Сообщение'), message_catch) then
			mainIni.config.message_catch = u8:decode(message_catch.v)
			saveIniFile()
		end
		imgui.SameLine()
		imgui.TextQuestion(u8'Введите текст который будет писать скрипт после ловли дома/авто.')
	end
	imgui.EndGroup()	
end
function timeelements()
	imgui.Separator()
	imgui.CenterText(u8('Часы'))
	imgui.Separator()
	imgui.CreatePaddingX(10)
	imgui.BeginGroup()
	if imgui.Checkbox(u8('Часы##time'), time_act) then
		mainIni.config.time_act = time_act.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8('При вводе чит-кода EZ прописывает /time, если есть отыгровка то отыгрывает её.'))
	if time_act.v then
		if imgui.InputText(u8('Отыгровка##123'), time_text) then
			mainIni.config.time_text = u8:decode(time_text.v)
			saveIniFile()
		end
		imgui.SameLine()
		imgui.TextQuestion(u8('Отыгровка для часов /time, оставьте поле пустым если не хотите использовать отыгровку.'))
	end
	imgui.EndGroup()
end
function assistantelements()
	imgui.Separator()
	imgui.CenterText(u8'ARZ Assistant Information')
	imgui.Separator()
	imgui.CreatePaddingX(10)
	imgui.BeginGroup()
	if imgui.Checkbox(u8'Включить ARZ Assistant Information', show_window) then
		mainIni.arz_assistant_window.show_window = show_window.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Включает дополнительное окно с полезной информацией о персонаже. Информацию которую нужно отображать можно настроить.')
	if show_window.v then
		if imgui.Button(u8'Сменить местоположение окна') then
			main_window_state.v = false
			arzmessage('Переместите окно в нужно для вас место и нажмите на текст "Сохранить"',5)
			setcurpos = true
		end
		imgui.BeginGroup()
		if imgui.Checkbox(u8'Ник',showname) then
			mainIni.arz_assistant_window.showname = showname.v
			saveIniFile()
		end
		if imgui.Checkbox(u8'Уровень',showlvl) then
			mainIni.arz_assistant_window.showlvl = showlvl.v
			saveIniFile()
		end
		if imgui.Checkbox(u8'Пинг',showping) then
			mainIni.arz_assistant_window.showping = showping.v
			saveIniFile()
		end
		if imgui.Checkbox(u8'FPS',showfps) then
			mainIni.arz_assistant_window.showfps = showfps.v
			saveIniFile()
		end
		imgui.EndGroup()
		imgui.SameLine()
		imgui.BeginGroup()
		if imgui.Checkbox(u8'Уровень HP и ARM',show_hp_and_arm) then
			mainIni.arz_assistant_window.show_hp_and_arm = show_hp_and_arm.v
			saveIniFile()
		end
		if imgui.Checkbox(u8'Время сессии',show_session_time) then
			mainIni.arz_assistant_window.show_session_time = show_session_time.v
			saveIniFile()
		end
		if imgui.Checkbox(u8'Онлайн за день',show_day_time) then
			mainIni.arz_assistant_window.show_day_time = show_day_time.v
			saveIniFile()
		end
		if imgui.Checkbox(u8'Дата',showdate) then
			mainIni.arz_assistant_window.showdate = showdate.v
			saveIniFile()
		end
		imgui.EndGroup() 
	end
	imgui.EndGroup()
end
function famelements()
	imgui.Separator()
	imgui.CenterText(u8'Семейный чат')
	imgui.Separator()
	imgui.CreatePaddingX(10)
	imgui.BeginGroup()
	if imgui.Checkbox(u8'Включить автосообщения для /fam',fam_messages) then
		mainIni.config.fam_messages = fam_messages.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Если в фаму инвайтнут игрока, отправится сообщение ниже. Так-же, если игрок достигнет определённого лвла')
	if fam_messages.v then
		imgui.PushItemWidth(200)
		if imgui.InputText(u8'Инвайт',fam_invite) then
			mainIni.config.fam_invite = u8:decode(fam_invite.v)
			saveIniFile()
		end
		imgui.SameLine()
		if imgui.InputText(u8'Поздравление',fam_lvlup) then
			mainIni.config.fam_lvlup = u8:decode(fam_lvlup.v)
			saveIniFile()
		end
		imgui.PopItemWidth()
	end
	imgui.EndGroup()
end
function autorecelements()
	imgui.Separator()
	imgui.CenterText(u8'Autoreconnect')
	imgui.Separator()
	imgui.CreatePaddingX(10)
	imgui.BeginGroup()
	if imgui.Checkbox(u8'Включить',auto_rec) then
		mainIni.config.auto_rec = auto_rec.v
		saveIniFile()
	end
	imgui.SameLine()
	imgui.TextQuestion(u8'Если вас кикнет с сервера или произойдёт рестарт, вы автоматически переподключитесь к серверу')
	if auto_rec.v then 
		if imgui.Checkbox(u8'Включить переподключение через 1 сек. если будет "You are banned from this server"',auto_rec_if_banned) then
			mainIni.config.auto_rec_if_banned = auto_rec_if_banned.v
			saveIniFile()
		end
		imgui.PushItemWidth(90)
		if imgui.InputInt(u8'Задержка для реконнекта',auto_rec_wait) then
			if aurcwait.v < 0 then aurcwait.v = 0 end
			mainIni.config.auto_rec_wait = auto_rec_wait.v
			saveIniFile()
		end
		imgui.PopItemWidth()
	end
	imgui.EndGroup()
end
function rpdmelements()
	imgui.Separator()
	imgui.CenterText('RPDM')
	imgui.SameLine()
	imgui.TextQuestion(u8'Реализация клео от Black Jezus(pidorasa) в виде функции в скрипте с возможностью сменить отыгровку. Активация: ПКМ + '..table.concat(getKeysName(rpdm_keys.v), " + "))
	imgui.Separator()
	imgui.CreatePaddingX(10)
	imgui.BeginGroup()

	imgui.Text(u8'Включить: ')
	imgui.SameLine()
	if imadd.ToggleButton('##onoffodaq', rpdm_act) then
		mainIni.config.rpdm_act = rpdm_act.v
		saveIniFile()
	end
	if rpdm_act.v then
		imgui.Text(u8'Активация: ')
		imgui.SameLine()
		if imadd.HotKey("##active2", rpdm_keys, {}, 120) then
			mainIni.config.rpdm_keys = encodeJson(rpdm_keys.v)
			saveIniFile()
		end
		imgui.SameLine()
		imgui.Text(u8('+ ПКМ'))
		
		imgui.PushItemWidth(200)
		if imgui.InputText(u8"Отыгровка RPDM'a",rpdm_text) then
			mainIni.config.rpdm_text = u8:decode(rpdm_text.v)
			saveIniFile()
		end
		imgui.PopItemWidth()
		
		imgui.SameLine()

		imgui.CreatePaddingX(20)
		imgui.TextColoredRGB(u8'{4682b4}'..u8:decode(rpdm_text.v)..' '..'Ronny_Wright[1001] - | '..myname..'['..myid..']')
	end
	imgui.EndGroup()	
end
function reconelements()
	imgui.Separator()
	imgui.CenterText(u8'Reconnect')
	imgui.SameLine()
	imgui.TextQuestion(u8'Обычный реконнект, так-же можно использовать через команды /rc и /rcn. Подробнее в вкладке "Информация"')
	imgui.Separator()
	imgui.CreatePaddingX(10)
	imgui.BeginGroup()
	
	imgui.PushItemWidth(120)
	if recstand.v < 0 then recstand.v = 0 end
	imgui.InputInt(u8'Обычный реконнект',recstand)
	imgui.InputText(u8'Реконнект с сменой ника',recname)
	imgui.PopItemWidth()
	imgui.EndGroup()
	imgui.SameLine()
	imgui.BeginGroup()
	if imgui.Button(u8'Recon##1',imgui.ImVec2(50,20)) then
		reconstandart(recstand.v)
	end
	if imgui.Button(u8'Recon##2',imgui.ImVec2(50,20)) then
		reconname(recname.v)
	end
	imgui.EndGroup()
end
function skipdialogselements()
	imgui.Separator()
	imgui.CenterText(u8'Скип диалогов')
	imgui.SameLine()
	imgui.TextQuestion(u8'В данном окне вы можете настроить какие диалоги скрипт не будет показывать')
	imgui.Separator()
	imgui.CreatePaddingX(10)
	imgui.BeginGroup()
	if imgui.Checkbox(u8'Включить скип диалогов', state_skips) then 
		mainIni.skipdialogs.state_skips = state_skips.v
		saveIniFile()
	end
	if state_skips.v then
		if imgui.Checkbox(u8'Скипать диалог с подтверждением трейда',tradedialog) then
			mainIni.skipdialogs.tradedialog = tradedialog.v
			saveIniFile()
		end
		if imgui.Checkbox(u8'Скипать диалог с пиццей',pizza) then
			mainIni.skipdialogs.pizza = pizza.v
			saveIniFile()
		end
		if imgui.Checkbox(u8'Скипать диалог с ДМЗЗ',dmzz) then
			mainIni.skipdialogs.dmzz = dmzz.v
			saveIniFile()
		end
		if imgui.Checkbox(u8'Скипать диалог налоговой',taxes) then
			mainIni.skipdialogs.taxes = taxes.v
			saveIniFile()
		end
		if imgui.Checkbox(u8'Скипать диалог про квест "Грабим военную базу"',military_base) then
			mainIni.skipdialogs.military_base = military_base.v
			saveIniFile()
		end
		if imgui.Checkbox(u8'Скипать диалог о правильном пин-коде',pin_code) then
			mainIni.skipdialogs.pin_code = pin_code.v
			saveIniFile()
		end
		if imgui.Checkbox(u8'Скипать диалог с ответом на репорт от Администратора',admin_report) then
			mainIni.skipdialogs.admin_report = admin_report.v
			saveIniFile()
		end
		-- imgui.Checkbox(u8'',skipdialogs)
	end
	imgui.EndGroup()
end
function arzwindelements()
	local ppos = imgui.GetWindowPos()
	imgui.SetWindowFontScale(0.835)
	imgui.CenterText('ARZ Assistant')
	imgui.Separator()
	_, myid = sampGetPlayerIdByCharHandle(playerPed)
	myname = sampGetPlayerNickname(myid)
	myping = sampGetPlayerPing(myid)
	mylvl = sampGetPlayerScore(myid)
	myarm = sampGetPlayerArmor(myid)
	myheal = sampGetPlayerHealth(myid)
	if showname.v then
		imgui.CenterText(fa.ICON_USER_CIRCLE_O..u8' '..myname.."["..myid.."]")
	end
	if showlvl.v or showping.v or showfps.v then
		lvlPingFPSString = ''
		if showlvl.v then
			lvlPingFPSString = fa.ICON_CLOCK_O..u8' '..mylvl
		end
		if showping.v then
			if lvlPingFPSString ~= '' then
				lvlPingFPSString = lvlPingFPSString..' | '
			end
			lvlPingFPSString = lvlPingFPSString..fa.ICON_SPINNER..u8' '..myping
		end
		if showfps.v then
			if lvlPingFPSString ~= '' then
				lvlPingFPSString = lvlPingFPSString..' | '
			end
			lvlPingFPSString = lvlPingFPSString..fa.ICON_PICTURE_O..u8' '.. math.floor(imgui.GetIO().Framerate)
		end
		imgui.CenterText(lvlPingFPSString)
	end
	if show_hp_and_arm.v then
		imgui.CenterText(fa.ICON_HEART..u8' '..myheal..' | '..fa.ICON_SHIELD..u8' '..myarm)
	end
	-- [[
	if show_session_time.v or show_day_time.v then
		sessionAndDay = ''
		if show_session_time.v then
			sessionAndDay = fa.ICON_HOURGLASS_O..u8' '..FormatTime(os.clock())
		end
		if show_day_time.v then
			if sessionAndDay ~= '' then
				sessionAndDay = sessionAndDay..' | '
			end
			sessionAndDay = sessionAndDay..fa.ICON_HOURGLASS_O..u8' '..FormatTime(onlineday_TEMP)
		end
		imgui.CenterText(sessionAndDay)
	end
	if showdate.v then 
		imgui.CenterText(fa.ICON_CALENDAR..u8' '..os.date('%D | %H:%M:%S'))
	end
	if setcurpos then
		imgui.ShowCursor = true
		imgui.CenterText(fa.ICON_FLOPPY_O..u8(' Сохранить'))
		if imgui.IsItemHovered() then
			if imgui.IsMouseClicked(0,false) then
				mainIni.arz_assistant_window.position = encodeJson({ppos.x,ppos.y})
				saveIniFile()
				setcurpos = false
				main_window_state.v = true
				arzmessage('Местоположение окна сохранено!')
			end
		end
	end
end

-- ФУХ ПИЗДА ФУНКЦИИ ИМГУИ ЗАКОНЧИЛИСЬ

-- хук rpc и packet 
function onReceivePacket(id, bitStream)
	if (id == PACKET_DISCONNECTION_NOTIFICATION or id == PACKET_INVALID_PASSWORD) then
		goaurc()
	end
	if (id == PACKET_CONNECTION_BANNED) then
		if auto_rec.v and auto_rec_if_banned.v then
			lua_thread.create(function()
				wait(1000)
				local rnick = myname
				ip, port = sampGetCurrentServerAddress()
				sampSetLocalPlayerName(rnick)
				sampConnectToServer(ip,port)
			end)
		end
	end
	if (id == PACKET_CONNECTION_ATTEMP_FAILED) then
		lua_thread.create(function()
			wait(0)
			ip,port = sampGetCurrentServerAddress()
			ping(ip,port)
		end)
	end
end
function onReceiveRpc(id,bitStream)
	if (id == 130) then
		goaurc()
	end
end

-- хук на клик по челу в табе
function sampev.onSendClickPlayer(idpl) 
	setClipboardText(sampGetPlayerNickname(idpl)) 
	arzmessage("Вы скопировали никнейм игрока "..getClipboardText().." ["..idpl.."]", 5)
end
-- хук на установку бухого эффекта или че
function sampev.onSetPlayerDrunk(lvl)
	if antilomka.v then
		return false
	end	
end
-- хук на установку ХП
function sampev.onSetPlayerHealth(healthfloat)
	if healstate.v then
		if hplvl.v > 0 and healthfloat <= hplvl.v then
			if hpmetod.v == 0 then
				sampSendChat('/usemed')
			elseif hpmetod.v == 1 then
				sampSendChat('/usedrugs '..drugsquen.v)
			elseif hpmetod.v == 2 then
				sampSendChat('/adrenaline')
			elseif hpmetod.v == 3 then
				sampSendChat('/beer')
			elseif hpmetod.v == 4 then
				sampSendClickTextdraw(arztextdrawidheal.v)
			end 
		end   
	end
end
tblclosetest = {['50.83'] = 50.84, ['49.9'] = 50, ['49.05'] = 49.15, ['48.2'] = 48.4, ['47.4'] = 47.6, ['46.5'] = 46.7, ['45.81'] = '45.84',
['44.99'] = '45.01', ['44.09'] = '44.17', ['43.2'] = '43.4', ['42.49'] = '42.51', ['41.59'] = '41.7', ['40.7'] = '40.9', ['39.99'] = 40.01,
['39.09'] = 39.2, ['38.3'] = 38.4, ['37.49'] = '37.51', ['36.5'] = '36.7', ['35.7'] = '35.9', ['34.99'] = '35.01', ['34.1'] = '34.2';}
tblclose = {}
sendcloseinventory = function()
	sampSendClickTextdraw(tblclose[1])
end

-- хук на показ текстдрава
function sampev.onShowTextDraw(id,data)
	for w, q in pairs(tblclosetest) do
		if data.lineWidth >= tonumber(w) and data.lineWidth <= tonumber(q) and data.text:find('^LD_SPAC:white$') then
			for i=0, 2 do rawset(tblclose, #tblclose + 1, id) end
		end
	end
	if checkmethod.v == 1 then
		if data.boxColor == -1436898180 then 
			if data.position.x == 549.5 and data.position.y == 60 then
				print('get hun > its hungry')
				if math.floor(((data.lineWidth - 549.5) / 54.5) * 100) <= eat2met.v then
					onPlayerHungry:run()
				end
			end
		end
	end
	if antiscare.v and (id == 507 or id == 508) then -- антимаска /scare
		return false
	end
	if gname ~= 'nothing' then -- если есть название гана 
		if not findedgun  then -- пока не найден ган
			if data.modelId == tablegunsmodels[gname] then -- если ид модели в слоте == иду модели гана который выбран
				findedgun = true -- задаем что мы нашли ган
				sampSendClickTextdraw(id) -- нажимаем на ган
			end 
		else -- если же уже нашли
			if id == 2302 then -- если Id == 2302 то есть взаимодействие с ганом
				sampSendClickTextdraw(id) -- нажимаем использовать
			end
		end
	end
	if auto_knock.v and data.text:find('to stop animation') then -- автосбив аним
		setGameKeyState(15,256)
		return false
	end
	-- print(id,data.modelId)
end

-- хук на иницилизацию игры(вроде блять так)
function sampev.onInitGame(playerId, hostName, settings, vehicleModels, unknown)
	if if_join.v then
		sendnotification('Вы подключились к серверу!', hostName, playerId)
	end
end
--хук на отправку синхры или че бля
function sampev.onSendPlayerSync(data)
	if bhop.v and bit.band(data.keysData, 0x28) == 0x28 then
		data.keysData = bit.bxor(data.keysData,0x20)
	end
end
-- хук на получение дамага от игрока / сервера
function sampev.onSendTakeDamage(playerId, damage, weapon, bodypart)
	local killer
	if sampIsLocalPlayerSpawned() then
		if playerId > -1 and playerId < 1001 then
			killer = sampGetPlayerNickname(playerId)..'['..playerId..']'
			if if_damage.v  then
				sendnotification('[WARNING] [damage] Игрок '..killer..' нанес вам '..math.floor(damage)..' урона')
			end
		end
		if myheal - damage <= 0 then
			if whokillme.v and killer then
				arzmessage('Вы умерли от '..killer)
			end
			if if_dead.v then
				sendnotification('Ваш персонаж умер'..(killer and '\nУбийца: '..killer or ''))
			end
		end
	end
end
-- хук на показ текста на экране
function sampev.onDisplayGameText(style, time, text)
	if fromSecToMinInDemoran.v and text:find('~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~g~Jailed') then
		return {style,time,tostring(text .. ' = '.. math.floor(tonumber(text:match('Jailed (%d+)'))/60) .. ' min.')}
	end	
	if auto_fill_gas.v then
		if text == '~w~This type of fuel ~r~ is not suitable~w~~n~ for your vehicles!' then
			sampSendClickTextdraw(18)
		end
		if text == '~w~' then
			sampSendClickTextdraw(2106)
			sampSendClickTextdraw(32)
		end
	end
	if text == ('You are hungry!') or text == ('~r~You are very hungry!') then
		if if_hungry.v then
			sendnotification('Вы проголодались!')
		end
		if checkmethod.v == 0 then
			onPlayerHungry:run()
		end
	end
end

-- хук на показ диалога
function sampev.onShowDialog(dialogId, dialogStyle, dialogTitle, okButtonText, cancelButtonText, dialogText)
	if dialogStyle == 1 or dialogStyle == 3 then
		local acc = getAcc()
		local bool = true
		if acc > -1 then
			local dialog = findDialog(acc, dialogId)
			if dialog > -1 then
				if enable_autofill.v then
					sampSendDialogResponse(dialogId, 1, 0, tostring(savepass[acc][3][dialog].text))
					return false
				end
			else
				bool = true
			end
		else
			bool = true
		end
		if bool then
			dialogChecker.check = true
			dialogChecker.id = dialogId
			dialogChecker.title = dialogTitle
		end
	else
		dialogChecker.check = false
		dialogChecker.id = -1
		dialogChecker.title = ""
	end
	if gotoeatinhouse then
		local linelist = 0
		for n in dialogText:gmatch('[^\r\n]+') do
			if dialogId == 174 and n:find('Меню дома') then
				print('debug: 174 dialog')
				sampSendDialogResponse(174, 1, linelist, false)
			elseif dialogId == 2431 and n:find('Холодильник') then
				print('debug: 2431 dialog')
				sampSendDialogResponse(2431, 1, linelist, false)
			elseif dialogId == 185 and n:find('Комплексный Обед') then
				print('debug: 185 dialog')
				sampSendDialogResponse(185, 1, linelist-1, false)
				gotoeatinhouse = false
			end
			linelist = linelist + 1
		end
		return false
	end
	if dialogId == 162 then
		local listitem = 0
		for n in dialogText:gmatch('[^\r\n]+') do
			if n:find('Не загружено') then
				if carfixnumber > -1 and listitem == carfixnumber - 1 then
					arzmessage('Невозможно заспавнить авто №'..carfixnumber..' т.к оно не загружено!\nЗагружаю авто, для того чтобы остановить загрузку пропишите /cloadstop')
					carloadnumber = carfixnumber
					sampSendDialogResponse(162, 1, carloadnumber - 1, -1)
					carfixnumber = -1
					return false
				elseif carloadnumber > -1 and listitem == carloadnumber - 1 then
					sampSendDialogResponse(162, 1, carloadnumber - 1, -1)
					return false
				end
			else
				if carfixnumber > -1 and listitem == carfixnumber - 1 then
					sampSendDialogResponse(162, 1, carfixnumber - 1, -1)
					return false
				elseif carloadnumber > -1 and listitem == carloadnumber - 1 then
					arzmessage('Авто №'..carloadnumber..' загружено')
					carloadnumber = -1
					return false
				end
			end
			listitem = listitem + 1
		end
		-- print(listitem)
		if listitem > 0 then
			if carfixnumber > 0 and listitem < carfixnumber then
				arzmessage('Невозможно заспавнить авто №'..carfixnumber..' т.к его нет в списке /cars!')
				sampSendDialogResponse(162,0,0,'')
				carfixnumber = -1
				carloadnumber = -1
				return false
			elseif carloadnumber > 0 and listitem < carloadnumber - 1 then
				arzmessage('Невозможно загрузить авто №'..carfixnumber..' т.к его нет в списке /cars!')
				sampSendDialogResponse(162,0,0,'')
				carloadnumber = -1
				return false
			end
		else
			arzmessage('У вас нет авто в /cars!')
			carfixnumber = -1
			carloadnumber = -1
			return false
		end
	end
	if dialogId == 163 then
		if carfixnumber > -1 then
			sampSendDialogResponse(163, 1, 9, -1)
			carfixnumber = -1
			return false
		elseif carloadnumber > -1 then
			sampSendDialogResponse(163, 1, 0, -1)
			return false
		end
	end
	if sendstatsstate and dialogId == 235 then
		sendstatsstate = dialogText
		sampSendDialogResponse(dialogId,0,0,'')
		return false
	end
	if gethunstate and dialogId == 0 and dialogText:find('Ваша сытость') then
		gethunstate = dialogText
		sampSendDialogResponse(dialogId,0,0,'')
		return false
	end
	if dialogId == 32 and textrep:len() > 0 then
		sampSendDialogResponse(32,1,0,textrep)
		textrep = ''
		return false
	end
	if findedgun and gname ~= 'nothing' and dialogId == 3011 then
		sampSendDialogResponse(3011,1,0,ammoclip)
		sendcloseinventory()
		gname = 'nothing'
		return false
	end
	if state_skips.v then
		if tradedialog.v then
			if dialogText:find('Перед тем как подтвердить сделку')  then
				sampSendDialogResponse(id,0,0,'')
				return false
			end
		end
		if pizza.v then
			if dialogText:find('Будьте осторожны на дороге') then
				sampSendDialogResponse(id,0,0,'')
				return false
			end
		end
		if dmzz.v then
			if dialogText:find('этом месте запрещено') then
				sampSendDialogResponse(id,0,0,'')
				return false
			end
		end
		if taxes.v then
			if dialogTitle == '{BFBBBA}Налоговая' then
				sampSendDialogResponse(id,0,0,'')
				return false
			end
		end
		if military_base.v then
			if dialogText:find('Вы успешно украли 5 ящиков') then
				sampSendDialogResponse(id,0,0,'')
				return false
			end
		end
		if pin_code.v then
			if dialogId == 0 and dialogText:find('PIN%-код принят') then
				sampSendDialogResponse(id,0,0,'')
				sampAddChatMessage('[Информация] {ffffff}Ваш пин-код {00B711}успешно {ffffff}принят!', 0x00B711)
				return false
			end
		end
		if admin_report.v then
			if dialogId == 1333 then
				sampSendDialogResponse(1333,1,0,0)
				return false
			end
			if dialogId == 1332 then
				sampSendDialogResponse(1332,1,0,0)
				return false
			end
		end	
	end
	if phone_cheatcode.v then	
		if dialogId == 1000 then
			sampSendDialogResponse(1000,1,0,0)
			return false
		end
	end
end
--хук на отправку респонса диалога
function sampev.onSendDialogResponse(dialogid, button, list, text)
	if dialogChecker.check and dialogChecker.id == dialogid and button == 1 then
		local ip, port = sampGetCurrentServerAddress()
		table.insert(temppass, {
			id = dialogid,
			title = dialogChecker.title,
			text = text,
			time = os.date("%H:%M:%S"),
			ip = ip .. ":" .. port,
			nick = tostring(sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))))
		})
		dialogChecker.check = false
		dialogChecker.id = -1
		dialogChecker.title = ""
	end
end	

-- хук на отправку команды
function sampev.onSendCommand(mess)
	if mess:find('^/vr') then
		lastvrmessage = mess
	end
	if accent_state.v then
		local cmds, args = mess:match('/(%S+) (.+)')
		-- print(cmds, args)
		if cmds and args then
			if cmds == 'c' then
				return {'/c ['..u8:decode(accent_text.v)..'] '..args}
			end
			if cmds == 's' then
				return {'/s ['..u8:decode(accent_text.v)..'] '..args}
			end
		end
	end
end
-- хук на отправку сообщения в чат
function sampev.onSendChat(mess)
	if accent_state.v then
		if mess == ')' or mess == '))' or mess == 'xD' or mess == ':D' or mess == '>_<' then
			return {mess}
		elseif mess:match('^!') or mess:match('^@') then
			if mess:len() >= 2 then
				local tochat, argument = mess:sub(1,1), mess:sub(2, #mess)
				mess = tochat..'['..u8:decode(accent_text.v)..'] '..argument
			end
			return {mess}
		else
			return {'['..u8:decode(accent_text.v)..'] '..mess}
		end
	end
end
-- хук на чат
function sampev.onServerMessage(color, text)
	if gotoeatinhouse then
		if text:find('электроэнергию') then
			arzmessage('Невозможно покушать! Оплатите комуналку!')
			gotoeatinhouse = false
		end
	end
	if antilomka.v then
		if text:find('^%[Наркотики%] {FFFFFF}У вас началась сильная ломка!') or text:find('^%[Наркотики%] {FFFFFF}Вашему персонажу нужно принять') then
			return false
		end
	end
	aok, maid = sampGetPlayerIdByCharHandle(playerPed)
	name = sampGetPlayerNickname(maid)
	if fam_messages.v and color == -1178486529 then
		if text:find('пригласил') and text:find('в семью') and text:find('[Семья (Новости)]') and string.find(text,'Семья',1)then
			sampSendChat(u8:decode('/fam '..fam_invite.v))
			sampAddChatMessage(text,color)
		end
		if text:find('Член семьи:') and text:find('достиг') and string.find(text,'[Новости Семьи]',1) and not text:find('Семья')  then
			sampSendChat(u8:decode('/fam '..fam_lvlup.v))
			sampAddChatMessage(text,color)
		end
	end
	if send_sms_if_vip.v then
		if text:find('Игрок (.-) приобрел Titan VIP.') and text:find('%[Информация%]') and color == -10270721 then
			sampSendChat(u8:decode('/vr '..sms_vr_vip.v))
			sampAddChatMessage(text,color)
		end
		if text:find('Игрок (.-) приобрел PREMIUM VIP.') and text:find('%[Информация%]') and color == -10270721 then
		   sampSendChat(u8:decode('/vr '..sms_vr_prem.v))
		   sampAddChatMessage(text,color)
		end
	end
	if text:find('Вы надели бронежилет.') then
		if armour_info.v then
			timekd = os.time()
			armkd = true
		end
		if binds_text_armour.v then
			sampSendChat("/do Достал из запасов бронижилет и надел его.")
		end
	end
	if binds_text_armour.v then
		if text:find('Вы сняли') and text:find('бронежилет!') then
			sampSendChat("/do Бронижилет куда-то исчез.")
		end
	end
	if floodclear.v then  
		if text:find('В нашем магазине ты можешь приобрести нужное количество игровых денег') then 
			return false 
		end
		if text:find('их на желаемый тобой') then
			return false 
		end
		if text:find('имеют большие возможности, подробнее /help') then
			return false 
		end
		if text:find('В магазине') and text:find('автомобили') then
			return false 
		end
		if text:find('предметы, которые выделят тебя из толпы!') then 
			return false 
		end
		if text:find("~~~~~~~~~~~~~~~~~~~~~~~~~~") and not text:find('говорит') then
			return false
		end
		if text:find("- Основные команды") and not text:find('говорит') then
			return false
		end
		if text:find("- Пригласи друга") and not text:find('говорит') then
			return false
		end
		if text:find("- Донат и получение") and not text:find('говорит') then
			return false
		end
		if text:find("выехал") and not text:find('говорит') then
			return false
		end
		if text:find("убив его") and not text:find('говорит') then
			return false
		end
		if text:find("начал работу") and not text:find('говорит') then
			return false
		end
		if text:find("Убив его") and not text:find('говорит') then
			return false
		end
		if text:find("между использованием") and not text:find('говорит') then
			return false
		end
		if text:find("обновлениях сервера") and not text:find('говорит') then
			return false
		end
		if text:find("Пополнение игрового счета") and not text:find('говорит') then
			return false
		end
		if text:find("Наш сайт") and not text:find('говорит') then
			return false
		end
	end
	if if_admin.v and color == -10270721 and text:find('Администратор') and text:find(name) then
		sendnotification(text)
	end
	if returnmessageforvr.v then
		if text:find('После последнего сообщения в этом чате нужно подождать 1 секунду') and color == -10270721 then
			sampAddChatMessage("[ReSend /vr]{ffffff} Переотправляю...",-10270721)
			lua_thread.create(function() 
				wait(1000)
				sampSendChat(lastvrmessage)
			end)
		end
	end
	if message_catch_state.v then	
		if text:find("%{73B461%}Поздравляем! Теперь этот транспорт принадлежит вам!") then
			sampSendChat(u8:decode(message_catch.v))
		end	
		if text:find("%[Информация%] %{FFFFFF%}Поздравляю! Теперь этот дом ваш!") and not text:find('говорит') and not text:find('- |') then
			sampSendChat(u8:decode(message_catch.v))
		end
		if text:find("%[Информация%] %{FFFFFF%}Поздравляю! Теперь этот бизнес ваш!") and not text:find('говорит') and not text:find('- |') then
			sampSendChat(u8:decode(message_catch.v))
		end
	end	
end

-- Author: http://qrlk.me/samp, edit ronnysoftware

updates = {}
updates.data = {
	result = false,
	status = '',
	relevant_version = '',
	url_update = '',
	url_json = 'https://ronnysoftware.github.io/api/updates/arzassistant' 
}
function updates:getlast(autoupd)
	print('call getlast')
	self.data.status = 'Проверяю обновления'
	if autoupd then
		arzmessage(self.data.status)
	end
	local json = path .. '\\updatesarzassistant.json'
	if doesFileExist(json) then os.remove(json) end
	int_json_download = downloadUrlToFile(self.data.url_json, json,
	function(id, status, p1, p2)
		if status == dlstatus.STATUSEX_ENDDOWNLOAD and id == int_json_download then
			if doesFileExist(json) then
				local f = io.open(json, 'r')
				if f then
					local info = decodeJson(f:read('*a'))
					if not info then
						self.data.result = false
						self.data.status = '[decode] Ошибка при загрузке JSON файла!\nОбратитесь в тех.поддержку скрипта'
						if autoupd then
							arzmessage(self.data.status)
						end
						f:close()
						return false
					end
					self.data.result = true
					self.data.url_update = info.updateurl
					self.data.relevant_version = info.latest
					self.data.status = 'Данные получены'
					f:close()
					os.remove(json)
					return true
				else
					self.data.result = false
					self.data.status = '[io.open] Невозможно проверить обновление!\nЧто-то блокирует соединение с сервером\nОбратитесь в тех.поддержку скрипта'
					if autoupd then
						arzmessage(self.data.status)
					end
					return false
				end
			else
				self.data.result = false
				self.data.status = '[exist] Невозможно проверить обновление!\nЧто-то блокирует соединение с сервером\nОбратитесь в тех.поддержку скрипта'
				if autoupd then
					arzmessage(self.data.status)
				end
				return false
			end
		end
	end)
end

function updates:download()
	if self.data.result and #self.data.relevant_version > 0  then
		if self.data.relevant_version ~= thisScript().version then
			self.data.status = 'Пытаюсь обновиться c '..thisScript().version..' на '..self.data.relevant_version
			arzmessage(self.data.status)
			int_scr_download = downloadUrlToFile(self.data.url_update, thisScript().path, function(id3, status1, p13, p23)
				if status1 == dlstatus.STATUS_ENDDOWNLOADDATA and int_scr_download == id3 then
					arzmessage('Загрузка обновления завершена.')
					arzmessage('Обновление завершено!')
					goupdatestatus = true          
					lua_thread.create(function() wait(500) thisScript():reload() end)
				end
				if status1 == dlstatus.STATUSEX_ENDDOWNLOAD and int_scr_download == id3 then
					if goupdatestatus == nil then
						self.data.status = 'Обновление прошло неудачно. Запущена старая версия.'
						arzmessage(self.data.status)
					end
				end
			end)
		else
			self.data.status = 'Обновление не требуется.'
			arzmessage(self.data.status)
		end
	end
end

function updates:autoupdate()
	local result = self:getlast(true)
	if result then
		self:download()
	end
end

function timeotigr()
	sampSendChat("/time")
	if time_text.v:len() > 0 then
		sampSendChat(u8:decode('/me '..time_text.v))
		lua_thread.create(function()
			wait(1700)
			sampSendChat('/do На часах '..os.date('%H:%M:%S'))
		end)
	end
end

function theme1()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
	colors[clr.Text]                   = ImVec4(0.90, 0.90, 0.90, 1.00);
    colors[clr.TextDisabled]           = ImVec4(0.60, 0.60, 0.60, 1.00);
    colors[clr.WindowBg]               = ImVec4(0.08, 0.08, 0.08, 1.00);
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
    colors[clr.Button]                 = ImVec4(0.36, 0.36, 0.36, 1.90);
    colors[clr.ButtonHovered]          = ImVec4(0.47, 0.46, 0.46, 0.90);
    colors[clr.ButtonActive]           = ImVec4(0.64, 0.64, 0.64, 1.53);
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
    colors[clr.TextSelectedBg]         = ImVec4(0.25, 0.25, 0.25, 0.80);
    colors[clr.ModalWindowDarkening]   = ImVec4(0.21, 0.21, 0.21, 0.21);
end
function theme2()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
	colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
	colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
	colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
	colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
	colors[clr.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
	colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
	colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
	colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.Button]                 = ImVec4(0.26, 0.59, 0.98, 1.40)
	colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
	colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
	colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
	colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.Separator]              = colors[clr.Border]
	colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
	colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
	colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
	colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
	colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
	colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
	colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
	colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
	colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
	colors[clr.ComboBg]                = colors[clr.PopupBg]
	colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
	colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
	colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
	colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
	colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
	colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
	colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
	colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
	colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
	colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
	colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
	colors[clr.ModalWindowDarkening]   = ImVec4(0.20, 0.20, 0.20, 0.35);
end
function theme3()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
	colors[clr.FrameBg]                = ImVec4(0.48, 0.16, 0.16, 0.54)
	colors[clr.FrameBgHovered]         = ImVec4(0.98, 0.26, 0.26, 0.40)
	colors[clr.FrameBgActive]          = ImVec4(0.98, 0.26, 0.26, 0.67)
	colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
	colors[clr.TitleBgActive]          = ImVec4(0.48, 0.16, 0.16, 1.00)
	colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
	colors[clr.CheckMark]              = ImVec4(0.98, 0.26, 0.26, 1.00)
	colors[clr.SliderGrab]             = ImVec4(0.88, 0.26, 0.24, 1.00)
	colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.26, 0.26, 1.00)
	colors[clr.Button]                 = ImVec4(0.98, 0.26, 0.26, 1.40)
	colors[clr.ButtonHovered]          = ImVec4(0.98, 0.26, 0.26, 1.00)
	colors[clr.ButtonActive]           = ImVec4(0.98, 0.06, 0.06, 1.00)
	colors[clr.Header]                 = ImVec4(0.98, 0.26, 0.26, 0.31)
	colors[clr.HeaderHovered]          = ImVec4(0.98, 0.26, 0.26, 0.80)
	colors[clr.HeaderActive]           = ImVec4(0.98, 0.26, 0.26, 1.00)
	colors[clr.Separator]              = colors[clr.Border]
	colors[clr.SeparatorHovered]       = ImVec4(0.75, 0.10, 0.10, 0.78)
	colors[clr.SeparatorActive]        = ImVec4(0.75, 0.10, 0.10, 1.00)
	colors[clr.ResizeGrip]             = ImVec4(0.98, 0.26, 0.26, 0.25)
	colors[clr.ResizeGripHovered]      = ImVec4(0.98, 0.26, 0.26, 0.67)
	colors[clr.ResizeGripActive]       = ImVec4(0.98, 0.26, 0.26, 0.95)
	colors[clr.TextSelectedBg]         = ImVec4(0.98, 0.26, 0.26, 0.35)
	colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
	colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
	colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
	colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
	colors[clr.ComboBg]                = colors[clr.PopupBg]
	colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
	colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
	colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
	colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
	colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
	colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
	colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
	colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
	colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
	colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
	colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
	colors[clr.ModalWindowDarkening]   = ImVec4(0.20, 0.20, 0.20, 0.35);
end
function theme4()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
	colors[clr.FrameBg]                = ImVec4(0.16, 0.48, 0.42, 0.54)
	colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.98, 0.85, 0.40)
	colors[clr.FrameBgActive]          = ImVec4(0.26, 0.98, 0.85, 0.67)
	colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
	colors[clr.TitleBgActive]          = ImVec4(0.16, 0.48, 0.42, 1.00)
	colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
	colors[clr.CheckMark]              = ImVec4(0.26, 0.98, 0.85, 1.00)
	colors[clr.SliderGrab]             = ImVec4(0.24, 0.88, 0.77, 1.00)
	colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.98, 0.85, 1.00)
	colors[clr.Button]                 = ImVec4(0.26, 0.98, 0.85, 1.40)
	colors[clr.ButtonHovered]          = ImVec4(0.26, 0.98, 0.85, 1.00)
	colors[clr.ButtonActive]           = ImVec4(0.06, 0.98, 0.82, 1.00)
	colors[clr.Header]                 = ImVec4(0.26, 0.98, 0.85, 0.31)
	colors[clr.HeaderHovered]          = ImVec4(0.26, 0.98, 0.85, 0.80)
	colors[clr.HeaderActive]           = ImVec4(0.26, 0.98, 0.85, 1.00)
	colors[clr.Separator]              = colors[clr.Border]
	colors[clr.SeparatorHovered]       = ImVec4(0.10, 0.75, 0.63, 0.78)
	colors[clr.SeparatorActive]        = ImVec4(0.10, 0.75, 0.63, 1.00)
	colors[clr.ResizeGrip]             = ImVec4(0.26, 0.98, 0.85, 0.25)
	colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.98, 0.85, 0.67)
	colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.98, 0.85, 0.95)
	colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
	colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.81, 0.35, 1.00)
	colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.98, 0.85, 0.35)
	colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
	colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
	colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
	colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
	colors[clr.ComboBg]                = colors[clr.PopupBg]
	colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
	colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
	colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
	colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
	colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
	colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
	colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
	colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
	colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
	colors[clr.ModalWindowDarkening]   = ImVec4(0.20, 0.20, 0.20, 0.35);
end
function theme6()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
	colors[clr.Text] = ImVec4(0.90, 0.90, 0.90, 1.00)
	colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
	colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 1.00)
	colors[clr.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
	colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
	colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
	colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
	colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
	colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
	colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
	colors[clr.TitleBg] = ImVec4(0.76, 0.31, 0.00, 1.00)
	colors[clr.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75)
	colors[clr.TitleBgActive] = ImVec4(0.80, 0.33, 0.00, 1.00)
	colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
	colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
	colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
	colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
	colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
	colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00)
	colors[clr.CheckMark] = ImVec4(1.00, 0.42, 0.00, 0.53)
	colors[clr.SliderGrab] = ImVec4(1.00, 0.42, 0.00, 0.53)
	colors[clr.SliderGrabActive] = ImVec4(1.00, 0.42, 0.00, 1.00)
	colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00)
	colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
	colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
	colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
	colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
	colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
	colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
	colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
	colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
	colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
	colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
	colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
	colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
	colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
	colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
	colors[clr.TextSelectedBg] = cc:hex('FFA633',200):ImVec4()
	colors[clr.ModalWindowDarkening]  = ImVec4(0.20, 0.20, 0.20, 0.35);
end
function theme7()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
	colors[clr.WindowBg]              = ImVec4(0.14, 0.12, 0.16, 1.00);
	colors[clr.ChildWindowBg]         = ImVec4(0.30, 0.20, 0.39, 0.00);
	colors[clr.PopupBg]               = ImVec4(0.05, 0.05, 0.10, 0.90);
	colors[clr.Border]                = ImVec4(0.89, 0.85, 0.92, 0.30);
	colors[clr.BorderShadow]          = ImVec4(0.00, 0.00, 0.00, 0.00);
	colors[clr.FrameBg]               = ImVec4(0.30, 0.20, 0.39, 1.00);
	colors[clr.FrameBgHovered]        = ImVec4(0.41, 0.19, 0.63, 0.68);
	colors[clr.FrameBgActive]         = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.TitleBg]               = ImVec4(0.41, 0.19, 0.63, 0.45);
	colors[clr.TitleBgCollapsed]      = ImVec4(0.41, 0.19, 0.63, 0.35);
	colors[clr.TitleBgActive]         = ImVec4(0.41, 0.19, 0.63, 0.78);
	colors[clr.MenuBarBg]             = ImVec4(0.30, 0.20, 0.39, 0.57);
	colors[clr.ScrollbarBg]           = ImVec4(0.30, 0.20, 0.39, 1.00);
	colors[clr.ScrollbarGrab]         = ImVec4(0.41, 0.19, 0.63, 0.31);
	colors[clr.ScrollbarGrabHovered]  = ImVec4(0.41, 0.19, 0.63, 0.78);
	colors[clr.ScrollbarGrabActive]   = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.ComboBg]               = ImVec4(0.30, 0.20, 0.39, 1.00);
	colors[clr.CheckMark]             = ImVec4(0.56, 0.61, 1.00, 1.00);
	colors[clr.SliderGrab]            = ImVec4(0.41, 0.19, 0.63, 0.24);
	colors[clr.SliderGrabActive]      = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.Button]                = ImVec4(0.41, 0.19, 0.63, 1.44);
	colors[clr.ButtonHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86);
	colors[clr.ButtonActive]          = ImVec4(0.64, 0.33, 0.94, 1.00);
	colors[clr.Header]                = ImVec4(0.41, 0.19, 0.63, 0.76);
	colors[clr.HeaderHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86);
	colors[clr.HeaderActive]          = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.ResizeGrip]            = ImVec4(0.41, 0.19, 0.63, 0.20);
	colors[clr.ResizeGripHovered]     = ImVec4(0.41, 0.19, 0.63, 0.78);
	colors[clr.ResizeGripActive]      = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.CloseButton]           = ImVec4(1.00, 1.00, 1.00, 0.75);
	colors[clr.CloseButtonHovered]    = ImVec4(0.88, 0.74, 1.00, 0.59);
	colors[clr.CloseButtonActive]     = ImVec4(0.88, 0.85, 0.92, 1.00);
	colors[clr.PlotLines]             = ImVec4(0.89, 0.85, 0.92, 0.63);
	colors[clr.PlotLinesHovered]      = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.PlotHistogram]         = ImVec4(0.89, 0.85, 0.92, 0.63);
	colors[clr.PlotHistogramHovered]  = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.TextSelectedBg]        = ImVec4(0.41, 0.19, 0.63, 0.43);
	colors[clr.ModalWindowDarkening]  = ImVec4(0.20, 0.20, 0.20, 0.35);
end
function theme9()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    colors[clr.Text]                   = ImVec4(0.95, 0.96, 0.98, 1.00);
	colors[clr.TextDisabled]           = ImVec4(0.29, 0.29, 0.29, 1.00);
	colors[clr.WindowBg]               = ImVec4(0.14, 0.14, 0.14, 1.00);
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
function theme10()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4

	colors[clr.Text] = ImVec4(0.95, 0.96, 0.98, 1.00)
	colors[clr.TextDisabled] = ImVec4(0.36, 0.42, 0.47, 1.00)
	colors[clr.WindowBg] = ImVec4(0.11, 0.15, 0.17, 1.00)
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
	colors[clr.TextSelectedBg] = cc:hex('3A33FF',180):ImVec4()
	colors[clr.ModalWindowDarkening]   = ImVec4(0.20, 0.20, 0.20, 0.35);
end
function theme11()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
	
    colors[clr.Text]   = ImVec4(0.00, 0.00, 0.00, 0.71)
    colors[clr.TextDisabled]   = ImVec4(0.24, 0.24, 0.24, 1.00)
    colors[clr.WindowBg]              = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.ChildWindowBg]         = ImVec4(0.96, 0.96, 0.96, 1.00)
    colors[clr.PopupBg]               = ImVec4(0.92, 0.92, 0.92, 1.00)
    colors[clr.Border]                = ImVec4(0.86, 0.86, 0.86, 1.00)
    colors[clr.BorderShadow]          = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg]               = ImVec4(0.88, 0.88, 0.88, 1.00)
    colors[clr.FrameBgHovered]        = ImVec4(0.82, 0.82, 0.82, 1.00)
    colors[clr.FrameBgActive]         = ImVec4(0.76, 0.76, 0.76, 1.00)
    colors[clr.TitleBg]               = ImVec4(0.00, 0.45, 1.00, 0.82)
    colors[clr.TitleBgCollapsed]      = ImVec4(0.00, 0.45, 1.00, 0.82)
    colors[clr.TitleBgActive]         = ImVec4(0.00, 0.45, 1.00, 1.00)
    colors[clr.MenuBarBg]             = ImVec4(0.00, 0.37, 0.78, 1.00)
    colors[clr.ScrollbarBg]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.ScrollbarGrab]         = ImVec4(0.00, 0.35, 1.00, 0.78)
    colors[clr.ScrollbarGrabHovered]  = ImVec4(0.00, 0.33, 1.00, 0.84)
    colors[clr.ScrollbarGrabActive]   = ImVec4(0.00, 0.31, 1.00, 0.88)
    colors[clr.ComboBg]               = ImVec4(0.92, 0.92, 0.92, 1.00)
    colors[clr.CheckMark]             = ImVec4(0.00, 0.49, 1.00, 0.59)
    colors[clr.SliderGrab]            = ImVec4(0.00, 0.49, 1.00, 0.59)
    colors[clr.SliderGrabActive]      = ImVec4(0.00, 0.39, 1.00, 0.71)
    colors[clr.Button]                = ImVec4(0.00, 0.49, 1.00, 1.59)
    colors[clr.ButtonHovered]         = ImVec4(0.00, 0.49, 1.00, 0.71)
    colors[clr.ButtonActive]          = ImVec4(0.00, 0.49, 1.00, 0.78)
    colors[clr.Header]                = ImVec4(0.00, 0.49, 1.00, 0.78)
    colors[clr.HeaderHovered]         = ImVec4(0.00, 0.49, 1.00, 0.71)
    colors[clr.HeaderActive]          = ImVec4(0.00, 0.49, 1.00, 0.78)
    colors[clr.ResizeGrip]            = ImVec4(0.00, 0.39, 1.00, 0.59)
    colors[clr.ResizeGripHovered]     = ImVec4(0.00, 0.27, 1.00, 0.59)
    colors[clr.ResizeGripActive]      = ImVec4(0.00, 0.25, 1.00, 0.63)
    colors[clr.CloseButton]           = ImVec4(0.00, 0.35, 0.96, 0.71)
    colors[clr.CloseButtonHovered]    = ImVec4(0.00, 0.31, 0.88, 0.69)
    colors[clr.CloseButtonActive]     = ImVec4(0.00, 0.25, 0.88, 0.67)
    colors[clr.PlotLines]             = ImVec4(0.00, 0.39, 1.00, 0.75)
    colors[clr.PlotLinesHovered]      = ImVec4(0.00, 0.39, 1.00, 0.75)
    colors[clr.PlotHistogram]         = ImVec4(0.00, 0.39, 1.00, 0.75)
    colors[clr.PlotHistogramHovered]  = ImVec4(0.00, 0.35, 0.92, 0.78)
    colors[clr.TextSelectedBg]        = ImVec4(0.00, 0.47, 1.00, 0.59)
    colors[clr.ModalWindowDarkening]  = ImVec4(0.20, 0.20, 0.20, 0.35)
end
function theme12()
	imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    colors[clr.Text]                   = ImVec4(0.90, 0.90, 0.90, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.60, 0.60, 0.60, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.08, 0.08, 0.08, 1.00)
    colors[clr.ChildWindowBg]          = ImVec4(0.10, 0.10, 0.10, 1.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 1.00)
    colors[clr.Border]                 = ImVec4(0.70, 0.70, 0.70, 0.40)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg]                = ImVec4(0.15, 0.15, 0.15, 1.00)
    colors[clr.FrameBgHovered]         = ImVec4(0.19, 0.19, 0.19, 0.71)
    colors[clr.FrameBgActive]          = ImVec4(0.34, 0.34, 0.34, 0.79)
    colors[clr.TitleBg]                = ImVec4(0.00, 0.69, 0.33, 0.80)
    colors[clr.TitleBgActive]          = ImVec4(0.00, 0.74, 0.36, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.69, 0.33, 0.50)
    colors[clr.MenuBarBg]              = ImVec4(0.00, 0.80, 0.38, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.16, 0.16, 0.16, 1.00)
    colors[clr.ScrollbarGrab]          = ImVec4(0.00, 0.69, 0.33, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.00, 0.82, 0.39, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.00, 1.00, 0.48, 1.00)
    colors[clr.ComboBg]                = ImVec4(0.20, 0.20, 0.20, 0.99)
    colors[clr.CheckMark]              = ImVec4(0.00, 0.69, 0.33, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.00, 0.69, 0.33, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.00, 0.77, 0.37, 1.00)
    colors[clr.Button]                 = ImVec4(0.00, 0.69, 0.33, 1.00)
    colors[clr.ButtonHovered]          = ImVec4(0.00, 0.82, 0.39, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.00, 0.87, 0.42, 1.00)
    colors[clr.Header]                 = ImVec4(0.00, 0.69, 0.33, 1.00)
    colors[clr.HeaderHovered]          = ImVec4(0.00, 0.76, 0.37, 0.57)
    colors[clr.HeaderActive]           = ImVec4(0.00, 0.88, 0.42, 0.89)
    colors[clr.Separator]              = ImVec4(1.00, 1.00, 1.00, 0.40)
    colors[clr.SeparatorHovered]       = ImVec4(1.00, 1.00, 1.00, 0.60)
    colors[clr.SeparatorActive]        = ImVec4(1.00, 1.00, 1.00, 0.80)
    colors[clr.ResizeGrip]             = ImVec4(0.00, 0.69, 0.33, 1.00)
    colors[clr.ResizeGripHovered]      = ImVec4(0.00, 0.76, 0.37, 1.00)
    colors[clr.ResizeGripActive]       = ImVec4(0.00, 0.86, 0.41, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.00, 0.82, 0.39, 1.00)
    colors[clr.CloseButtonHovered]     = ImVec4(0.00, 0.88, 0.42, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.00, 1.00, 0.48, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.00, 0.69, 0.33, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(0.00, 0.74, 0.36, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.00, 0.69, 0.33, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(0.00, 0.80, 0.38, 1.00)
    colors[clr.TextSelectedBg]         = ImVec4(0.00, 0.69, 0.33, 0.72)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.17, 0.17, 0.17, 0.48)
end	
function easy_style()
	imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
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
end
function strong_style()
	imgui.SwitchContext()
	local style = imgui.GetStyle()
	style.WindowPadding = imgui.ImVec2(8, 8)
	style.WindowRounding = 2
	style.ChildWindowRounding = 2
	style.FramePadding = imgui.ImVec2(4, 3)
	style.FrameRounding = 2
	style.ItemSpacing = imgui.ImVec2(5, 4)
	style.ItemInnerSpacing = imgui.ImVec2(4, 4)
	style.IndentSpacing = 21
	style.ScrollbarSize = 13
	style.ScrollbarRounding = 0
	style.GrabMinSize = 8
	style.GrabRounding = 1
	style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
	style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
end
function setstyleandtheme()
	if mainIni.config.styletheme == 0 then strong_style()
	elseif mainIni.config.styletheme == 1 then easy_style() end
	if mainIni.config.theme == 0 then theme1()
	elseif mainIni.config.theme == 1 then theme2()
	elseif mainIni.config.theme == 2 then theme3()
	elseif mainIni.config.theme == 3 then theme4()
	elseif mainIni.config.theme == 4 then theme6() 
	elseif mainIni.config.theme == 5 then theme7() 
	elseif mainIni.config.theme == 6 then theme9() 
	elseif mainIni.config.theme == 7 then theme10()
	elseif mainIni.config.theme == 8 then theme11()
	elseif mainIni.config.theme == 9 then theme12() end	
end
setstyleandtheme()