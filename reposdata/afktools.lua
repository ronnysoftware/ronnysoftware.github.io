script_name('AFK Tools')
script_author("ronnysoftware")
script_version('2.0.3')
script_properties('work-in-pause')
local dlstatus = require("moonloader").download_status
local imgui = require('imgui')
local encoding = require("encoding")
local sampev = require("samp.events")
local memory = require("memory")
local effil = require("effil")
local inicfg = require("inicfg")
encoding.default = 'CP1251'
u8 = encoding.UTF8

if not doesDirectoryExist('moonloader/config') then
	createDirectory('moonloader/config')
end

local path = getWorkingDirectory() .. "\\config"

local mainIni = inicfg.load({
	autologin = {
		state = false
	},
	arec ={
		state = false,
		statebanned = false,
		wait = 50
	},
	roulette = {
		standart = false,
		donate = false,
		platina = false,
		wait = 1000
	},
	vknotf = {
		token = '',
		user_id = '',
		group_id = '',
		state = false,
		isinitgame = false,
		ishungry = false,
		iscloseconnect = false,
		isadm = false,
		isdemorgan = false,
		islowhp = false,
		ispayday = false,
		iscrashscript = false,
		issellitem = false
	},
	piar = {
		piar1 = '',
		piar2 = '',
		piar3 = '',
		piarwait = 50,
		piarwait2 = 50,
		piarwait3 = 50,
		auto_piar = false,
		auto_piar_kd = 300,
		last_time = os.time(),
	},
	eat = {
		checkmethod = 0,
		eat2met = 30,
		cycwait = 30,
		setmetod = 0,
        eatmetod = 0,
        healstate = false,
        hplvl = 30,
        hpmetod = 0,
        arztextdrawid = 648,
        arztextdrawidheal = 646,
        drugsquen = 1
	},
	config = {
		autoupdate = true,
		banscreen = false,
		antiafk = false,
		fastconnect = false
	}
},'afktools.ini')

if not doesFileExist('moonloader/config/afktools.ini') then
	inicfg.save(mainIni,'afktools.ini')
end

changelog = [[
	v1.0
		Релиз
	v1.1 
		Добавил автообновление
		Добавил новые события для уведомлений 
		Изменил автологин, теперь это автозаполнение
	v1.2
		Управление игрой через команды: !getplstats, !getplinfo, !sendplchat(а так же кнопки) 
		Новое событие для отправки уведомления: при выходе из деморгана
		Добавил флудер на 3 строки(если 2 или 3 строка не нужна оставьте её пустой)
	v1.25 - Hotfix
		Исправил краш при отправке уведомления о том что перс голоден
	v1.3
		Добавил открытие донат сундука (внимательно читайте как сделать чтоб работало)
		Для украинцев: добавил возможность вырубить VK Notifications и спокойно использовать скрипт
	v1.4
		Пофиксил автооткрытие если игра свернута
	v1.5
		Переписал функцию принятия уведомлений
		Теперь автохилл не флудит
	v1.6
		Релиз на BlastHack
		К каждой строке флудера добавлена своя задержка
		Теперь, если вас убил игрок и включено уведомление о смерти, в уведомлении напишет кто вас убил
		Прибрался в коде
	v1.6.1
		Фикс VK Notifications
	v1.7
		В VK Notifications добавлена кнопка "Голод" и команда !getplhun
		Добавлена возможность выключить автообновление
		Исправлены ложные уведомления на сообщения от администратора
	v1.8 
		Обновил способ антиафк, вроде теперь у всех работает
		Пофиксил если перс умрет
	v1.8-fix
		Фикс краша при реконнекте
	v1.9
		Новый дизайн
		Добавлен АвтоПиар
		Добавлена проверка на /pm от админов(диалог + чат, 2 вида)
		Фикс AutoBanScreen - теперь, скринит при появлении диалога о бане
	v1.9.1
		Фикс хавки из дома
	v1.9.1.1
		Фикс сохранения задержки для автооткрытия
	v2.0.0
		Пофикшены краши(вроде все) при реконнекте, использовании бота VK
		Сменен дизайн на более приятный
		В автозаполнение добавлена кнопка "Добавить аккаунт"
		Добавлены команды /afkrec(рекон с секундами), /afksrec(стопает авторекон и рекон обычный)
]]
changelog2 = [[	v2.0.1
		Фикс автооткрытия
	v2.0.2
		Автоеда - Добавлен выбор проверки когда можно похавать(полоска голода с настройкой) 
		Фикс крашей из-за пиара и др.
		Добавлен Fastconnect
	v2.0.3
		Фиксы багов
]]
scriptinfo = [[
	AFK Tools - скрипт, для прокачки аккаунта на Arizona Role Play
	В данном разделе вы можете более подробно узнать о скрипте

	Команды скрипта:
		/afktools - открыть меню скрипта
		/afkreload - перезагрузить скрипт 
		/afkunload - выгрузить скрипт
		/afkrec - реконнект с секундами
		/afksrec - остановить реконнект(стандартный или авторекон) 
]]


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
7. После этого у вас появится токен, скопируйте его и вставьте в поле "Токен"

Как настроить команды !getstats, !getinfo и др.?

Переходим во вкладку "Long Poll API", в подвкладке "Настройки" включаем его, выбираем версию 5.80(вместо версии 5.50)
Переходим в вкладку "Типы событий", там ставим галочку на входящее сообщение. Готово!
Во вкладке "Сообщения" справа включаем сообщения сообщества и не забываем сразу же разрешить 
	сообщения от сообщества с главной страницы группы(или же просто что-то пишем в сообщения группы).
Теперь необходимо так же активировать возможности ботов в группе: 
	Управление - Сообщения - Настройки ботов - Возможности ботов - Включены
В скрипте нужно будет заполнить ID группы, которой мы создали выше.
p.s если ID группы не в виде числа, вы можете его добыть в диалоге с группой
	Например: ссылка на диалог: https://vk.com/im?sel=-194187813, где 194187813 это ID группы 
p.s.s если у вас не было до этого ID группы, сохраните настройки и нажмите "Переподключение к серверам"  

Где взять VK ID?
Самый простой способ
1. Зайдите в "Настройки" вашего аккаунта
2. В поле "Адрес страницы" нажмите "Изменить"
3. Над кнопкой "Сохранить" будет текст - "Номер страницы - (цифры)". Эти цифры и есть ваш VK ID
4. Перепишите эти цифры в поле "VK ID" 

Сохраните
Напишите что-то в вашу группу
Теперь, вы можете проверить уведомления нажав кнопку "Проверить" 
]]
local _message = {}

function AFKMessage(text,del)
	del = del or 5
	_message[#_message+1] = {active = false, time = 0, showtime = del, text = text}
end
--ale op, load
local fastconnect = imgui.ImBool(mainIni.config.fastconnect)
local antiafk = imgui.ImBool(mainIni.config.antiafk)
local banscreen = imgui.ImBool(mainIni.config.banscreen)
local autoupdateState = imgui.ImBool(mainIni.config.autoupdate)
local autologin = {
	state = imgui.ImBool(mainIni.autologin.state)
}
local arec = {
	state = imgui.ImBool(mainIni.arec.state),
	statebanned = imgui.ImBool(mainIni.arec.statebanned),
	wait = imgui.ImInt(mainIni.arec.wait)
}
local roulette = {
	standart = imgui.ImBool(mainIni.roulette.standart),
	donate = imgui.ImBool(mainIni.roulette.donate),
	platina = imgui.ImBool(mainIni.roulette.platina),
	wait = imgui.ImInt(mainIni.roulette.wait)
}
local vknotf = {
	token = imgui.ImBuffer(''..mainIni.vknotf.token,300),
	user_id = imgui.ImBuffer(''..mainIni.vknotf.user_id,300),
	group_id = imgui.ImBuffer(''..mainIni.vknotf.group_id,300),
	state = imgui.ImBool(mainIni.vknotf.state),
	isinitgame = imgui.ImBool(mainIni.vknotf.isinitgame),
	ishungry = imgui.ImBool(mainIni.vknotf.ishungry),
	iscloseconnect = imgui.ImBool(mainIni.vknotf.iscloseconnect),
	isadm = imgui.ImBool(mainIni.vknotf.isadm),
	isdemorgan = imgui.ImBool(mainIni.vknotf.isdemorgan),
	islowhp = imgui.ImBool(mainIni.vknotf.islowhp),
	issendlowhp = false,
	ispayday = imgui.ImBool(mainIni.vknotf.ispayday),
	iscrashscript = imgui.ImBool(mainIni.vknotf.iscrashscript),
	ispaydaystate = false,
	ispaydayvalue = 0,
	ispaydaytext = '',
	issellitem = imgui.ImBool(mainIni.vknotf.issellitem)
}
local piar = {
	piar1 = imgui.ImBuffer(''..mainIni.piar.piar1, 500),
	piar2 = imgui.ImBuffer(''..mainIni.piar.piar2, 500),
	piar3 = imgui.ImBuffer(''..mainIni.piar.piar3, 500),
	piarwait = imgui.ImInt(mainIni.piar.piarwait),
	piarwait2 = imgui.ImInt(mainIni.piar.piarwait2),
	piarwait3 = imgui.ImInt(mainIni.piar.piarwait3),
	auto_piar = imgui.ImBool(mainIni.piar.auto_piar),
	auto_piar_kd = imgui.ImInt(mainIni.piar.auto_piar_kd),
	last_time = mainIni.piar.last_time
}
local eat = {
	checkmethod = imgui.ImInt(mainIni.eat.checkmethod),
	eat2met = imgui.ImInt(mainIni.eat.eat2met),
	cycwait = imgui.ImInt(mainIni.eat.cycwait),
	setmetod = imgui.ImInt(mainIni.eat.setmetod),
	eatmetod = imgui.ImInt(mainIni.eat.eatmetod),
	healstate = imgui.ImBool(mainIni.eat.healstate),
	hplvl = imgui.ImInt(mainIni.eat.hplvl),
	hpmetod = imgui.ImInt(mainIni.eat.hpmetod),
	arztextdrawid = imgui.ImInt(mainIni.eat.arztextdrawid),
	arztextdrawidheal = imgui.ImInt(mainIni.eat.arztextdrawidheal),
	drugsquen = imgui.ImInt(mainIni.eat.drugsquen)
}
-- one launch
local afksets = imgui.ImBool(false)
local showpass = false
local showtoken = false
local aopen = false
local opentimerid = {
	standart = -1,
	donate = -1,
	platina = -1
}
local checkopen = {
	standart = false,
	donate = false
}
local onPlayerHungry = lua_thread.create_suspended(function()
	if eat.eatmetod.v == 1 then
		AFKMessage('Реагирую, кушаю')
		gotoeatinhouse = true
		sampSendChat('/home')
	elseif eat.eatmetod.v == 3 then
		AFKMessage('Реагирую, кушаю')
		setVirtualKeyDown(0x12, false)
		while not sampIsDialogActive() do wait(0) end
		sampSendDialogResponse(1825, 1, 6, false)
		while not sampIsDialogActive() do wait(0) end
		wait(500)
		sampCloseCurrentDialogWithButton(0)
	elseif eat.eatmetod.v == 2 then 
		AFKMessage('Реагирую, кушаю')
		if eat.setmetod.v == 0 then
			for i = 1,30 do
				sampSendChat('/cheeps')
				wait(4000)
			end    
		elseif eat.setmetod.v == 1 then
			for k = 1,10 do
				sampSendChat('/jfish')
				wait(3000)
			end    
		elseif eat.setmetod.v == 2 then
			sampSendChat('/jmeat')  
		elseif eat.setmetod.v == 3 then
			sampSendClickTextdraw(eat.arztextdrawid.v)
			sampSendClickTextdraw(eat.arztextdrawid.v)
		elseif eat.setmetod.v == 4 then
			sampSendChat('/meatbag') 
		end
	end
end)
local createscreen = lua_thread.create_suspended(function()
	wait(2000)
	takeScreen()
end)
local checkrulopen = lua_thread.create_suspended(function()
	while true do
		wait(0)
		if aopen then
			AFKMessage('Начинаем делать проверку')
			checkopen.standart = true
			checkopen.donate = roulette.donate.v and true or false
			checkopen.platina = roulette.platina.v and true or false
			sampSendChat('/invent')
			wait(roulette.wait.v*1000)
			AFKMessage('Перезапуск')
		end
	end
end)

--autofill
local file_accs = path .. "\\accs.json"

local dialogChecker = {
	check = false,
	id = -1,
	title = ""
}

local editpass = {
	numedit = -1,
	input = imgui.ImBuffer('',100)
}

local addnew = {
	name = imgui.ImBuffer('',100),
	pass = imgui.ImBuffer('',100),
	dialogid = imgui.ImInt(0),
	serverip = imgui.ImBuffer('',100)
}

function addnew:save()
	if #addnew.name.v > 0 and #addnew.pass.v > 0 and #(tostring(addnew.dialogid.v)) > 0 and #addnew.serverip.v > 0 then
		saveacc(addnew.name.v,addnew.pass.v,addnew.dialogid.v,addnew.serverip.v)
		return true
	end
end

local temppass = {}
local savepass = {}

if doesFileExist(file_accs) then
	local f = io.open(file_accs, "r")
	if f then
		savepass = decodeJson(f:read("a*"))
		f:close()
	end
end


local checklist = {
	u8('You are hungry!'),
	u8('Полоска голода')
}
local metod = {
	u8('Чипсы'),
	u8('Рыба'),
	u8('Оленина'),
	u8('TextDraw'),
	u8('Мешок')
}
local healmetod = {
	u8('Аптечка'),
	u8('Наркотики'),
	u8('Андреналин'),
	u8('Пиво'),
	u8('TextDraw')
}
 
font2 = renderCreateFont('Arial', 8, 5)
local list = {}
function list:new()
	return {
		pos = {
			x = select(1,getScreenResolution()) - 222,
			y = select(2,getScreenResolution()) - 60
		},
		size = {
			x = 200,
			y = 0
		}
	}
end
notfList = list:new()

function onWindowMessage(msg, wparam, lparam)
	if msg == 0x100 or msg == 0x101 then
		if (wparam == 0x1B and afksets.v) and not isPauseMenuActive() then
			consumeWindowMessage(true, false)
			if msg == 0x101 then
				afksets.v = false
			end
		end
	end
end

menunum = 0 
menufill = 0 
localvalue = 0
local key, server, ts

function threadHandle(runner, url, args, resolve, reject) -- обработка effil потока без блокировок
	local t = runner(url, args)
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
function async_http_request(url, args, resolve, reject)
	local runner = requestRunner()
	if not reject then reject = function() end end
	lua_thread.create(threadHandle,runner, url, args, resolve, reject)
end
local vkerr, vkerrsend -- сообщение с текстом ошибки, nil если все ок
function tblfromstr(str)
	local a = {}
	for b in str:gmatch('%S+') do
		a[#a+1] = b
	end
	return a
end
function longpollResolve(result)
	if result then
		if not result:sub(1,1) == '{' then
			vkerr = 'Ошибка!\nПричина: Нет соединения с VK!'
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
		if vknotf.state.v and t.updates then
			for k, v in ipairs(t.updates) do
				if v.type == 'message_new' and tonumber(v.object.from_id) == tonumber(vknotf.user_id.v) and v.object.text then
					if v.object.payload then
						local pl = decodeJson(v.object.payload)
						if pl.button then
							if pl.button == 'getstats' then
								getPlayerArzStats()
							elseif pl.button == 'getinfo' then
								getPlayerInfo()
							elseif pl.button == 'gethun' then
								getPlayerArzHun()
							elseif pl.button == 'support' then
								sendvknotf('Команды:\n!sendplchat - Отправить сообщение из VK в Игру\n!getplstats - получить статистику персонажа\n!getplhun - получить голод персонажа\n!getplinfo - получить информацию о персонаже\nПоддержка: @ronnysoftware')
							elseif pl.button == 'openchest' then
								openchestrulletVK()
							elseif pl.button == 'keyW' then
								setKeyFromVK('go')
							elseif pl.button == 'keyA' then
								setKeyFromVK('left')
							elseif pl.button == 'keyS' then
								setKeyFromVK('back')
							elseif pl.button == 'keyD' then
								setKeyFromVK('right')
							end
						end
						return
					end
					local objsend = tblfromstr(v.object.text)
					if objsend[1] == '!getplstats' then
						getPlayerArzStats()
					elseif objsend[1] == '!getplinfo' then
						getPlayerInfo()
					elseif objsend[1] == '!getplhun' then
						getPlayerArzHun()
					elseif objsend[1] == '!sendplchat' then
						print('this')
						local args = table.concat(objsend, " ", 2, #objsend) 
						if #args > 0 then
							args = u8:decode(args)
							sampProcessChatInput(args)
							sendvknotf('Сообщение "' .. args .. '" было успешно отправлено в игру')
						else
							sendvknotf('Неправильный аргумент! Пример: !sendplchat [строка]')
						end
					end
				end
			end
		end
	end
end
function longpollGetKey()
	async_http_request('https://api.vk.com/method/groups.getLongPollServer?group_id=' .. vknotf.group_id.v .. '&access_token=' .. vknotf.token.v .. '&v=5.80', '', function (result)
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
				server = t.response.server
				ts = t.response.ts
				key = t.response.key
				vkerr = nil
			end
		end
	end)
end
function sendvknotf(msg, host)
	host = host or sampGetCurrentServerName()
	local acc = sampGetPlayerNickname(select(2,sampGetPlayerIdByCharHandle(playerPed))) .. '['..select(2,sampGetPlayerIdByCharHandle(playerPed))..']'
	msg = msg:gsub('{......}', '')
	msg = '[AFK Tools | Notifications | '..acc..' | '..host..']\n'..msg
	msg = u8(msg)
	msg = url_encode(msg)
	local keyboard = vkKeyboard()
	keyboard = u8(keyboard)
	keyboard = url_encode(keyboard)
	msg = msg .. '&keyboard=' .. keyboard
	if vknotf.state.v and #vknotf.user_id.v > 0 then
		async_http_request('https://api.vk.com/method/messages.send', 'user_id=' .. vknotf.user_id.v .. '&message=' .. msg .. '&access_token=' .. vknotf.token.v .. '&v=5.80',
		function (result)
			local t = decodeJson(result)
			if not t then
				return
			end
			if t.error then
				vkerrsend = 'Ошибка!\nКод: ' .. t.error.error_code .. ' Причина: ' .. t.error.error_msg
				return
			end
			vkerrsend = nil
		end)
	end
end
function vkKeyboard() --создает конкретную клавиатуру для бота VK, как сделать для более общих случаев пока не задумывался
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
	row2[1].action.payload = '{"button": "openchest"}'
	row2[1].action.label = aopen and 'Выключить автооткрытие' or 'Включить автооткрытие'
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
function char_to_hex(str)
	return string.format("%%%02X", string.byte(str))
  end
  
function url_encode(str)
    local str = string.gsub(str, "\\", "\\")
    local str = string.gsub(str, "([^%w])", char_to_hex)
    return str
end
function getPlayerInfo()
	if isSampLoaded() and isSampAvailable() and sampGetGamestate() == 3 then
		local response = ''
		response = response .. 'HP: ' .. getCharHealth(PLAYER_PED) .. '\n'
		response = response .. 'Armor: ' .. getCharArmour(PLAYER_PED) .. '\n'
		response = response .. 'Money: ' .. getPlayerMoney(PLAYER_HANDLE) .. '\n'
		local x, y, z = getCharCoordinates(PLAYER_PED)
		response = response .. 'Coords: X: ' .. math.floor(x) .. ' | Y: ' .. math.floor(y) .. ' | Z: ' .. math.floor(z)
		sendvknotf(response)
	else
		sendvknotf('Вы не подключены к серверу!')
	end
end
sendstatsstate = false
function getPlayerArzStats()
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
		sendvknotf(sendstatsstate == true and 'Ошибка! В течении 10 секунд скрипт не получил информацию!' or tostring(sendstatsstate))
		sendstatsstate = false
	else
		sendvknotf('(error) Персонаж не заспавнен')
	end
end
function getPlayerArzHun()
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
		sendvknotf(gethunstate == true and 'Ошибка! В течении 10 секунд скрипт не получил информацию!' or tostring(gethunstate))
		gethunstate = false
	else
		sendvknotf('(error) Персонаж не заспавнен')
	end
end
function setKeyFromVK(getkey)
	if isSampLoaded() and isSampAvailable() and sampIsLocalPlayerSpawned() then
		sendvknotf('Отправлено нажатие на клавишу '..getkey)
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
		sendvknotf('Ваш персонаж не заспавнен!')
	end
end
function openchestrulletVK()
	if isSampLoaded() and isSampAvailable() and sampIsLocalPlayerSpawned() then
		if roulette.standart.v or roulette.donate.v or roulette.platina.v then
			aopen = not aopen
			if aopen then 
				checkrulopen:run()
				afksets.v = false
			else 
				lua_thread.terminate(checkrulopen) 
			end
			sendvknotf('Автооткрытие '..(aopen and 'включено!' or 'выключено!'))
		else
			sendvknotf("Включите сундук с рулетками!")
		end
	else
		sendvknotf('Ваш персонаж не заспавнен!')
	end
end
function openchestrullet()
	if sampIsLocalPlayerSpawned() then
		if roulette.standart.v or roulette.donate.v or roulette.platina.v then
			aopen = not aopen
			AFKMessage('Автооткрытие '..(aopen and 'включено!' or 'выключено!'))
			if aopen then 
				checkrulopen:run()
				afksets.v = false
			else 
				lua_thread.terminate(checkrulopen) 
			end
		else
			AFKMessage("Включите сундук с рулетками!")
		end
	else
		AFKMessage("Ваш персонаж не заспавнен!")
	end
end
bizpiaron = false
idsshow = false
function vkget()
	longpollGetKey()
	local reject, args = function() end, ''
	while not key do 
		wait(1)
	end
	local runner = requestRunner()
	while true do
		while not key do wait(0) end
		url = server .. '?act=a_check&key=' .. key .. '&ts=' .. ts .. '&wait=25' --меняем url каждый новый запрос потокa, так как server/key/ts могут изменяться
		threadHandle(runner, url, args, longpollResolve, reject)
		wait(100)
	end
end
function bizpiar()
	while true do wait(0)
		if bizpiaron then
			sampSendChat(u8:decode(piar.piar1.v))
			wait(piar.piarwait.v * 1000)
		end
	end
end
function bizpiar2()
	while true do wait(0)
		if bizpiaron then
			if piar.piar2.v:len() > 0 then
				sampSendChat(u8:decode(piar.piar2.v))
				wait(piar.piarwait2.v * 1000)
			end
		end
	end
end
function bizpiar3()
	while true do wait(0)
		if bizpiaron then
			if piar.piar3.v:len() > 0 then
				sampSendChat(u8:decode(piar.piar3.v))
				wait(piar.piarwait3.v * 1000)
			end
		end
	end
end
bizpiarhandle = lua_thread.create_suspended(bizpiar) 
bizpiarhandle2 = lua_thread.create_suspended(bizpiar2) 
bizpiarhandle3 = lua_thread.create_suspended(bizpiar3) 
function activatePiar(bbiza)
	if bbiza then 
		bizpiarhandle:run()
		bizpiarhandle2:run()
		bizpiarhandle3:run()
	else 
		bizpiarhandle:terminate()
		bizpiarhandle2:terminate()
		bizpiarhandle3:terminate()
	end
end

function main()
    while not isSampAvailable() do
        wait(0)
	end
	if piar.auto_piar.v and (os.time() - piar.last_time) <= piar.auto_piar_kd.v then
		lua_thread.create(function()
			while not sampIsLocalPlayerSpawned() do wait(0) end
			bizpiaron = true
			activatePiar(bizpiaron)
			AFKMessage('[АвтоПиар] Пиар включен т.к прошло меньше чем '..piar.auto_piar_kd.v..' секунд после последней выгрузки')
		end)
	end
	local _a = [[Скрипт успешно запущен!
Версия: %s
Открыть меню: /afktools
Автор: @ronnysoftware]]
	if autoupdateState.v then
		updates:autoupdate()
	else
		updates:getlast()
	end
	AFKMessage(_a:format(thisScript().version))
	sampRegisterChatCommand('eattest',function() gotoeatinhouse = true; sampSendChat('/home') end)
	sampRegisterChatCommand('afktools',function() afksets.v = not afksets.v end)
	sampRegisterChatCommand('afkreload',function() thisScript():reload() end)
	sampRegisterChatCommand('afkunload',function() thisScript():unload() end)
	sampRegisterChatCommand('afksrec', function() 
		if handle_aurc then
			handle_aurc:terminate()
			handle_aurc = nil
			AFKMessage('Автореконнект остановлен!')
		else
			AFKMessage('Вы сейчас не ожидаете автореконнекта!')
		end
		if handle_rc then
			handle_rc:terminate()
			handle_rc = nil
			AFKMessage('Реконнект остановлен!')
		else
			AFKMessage('Вы сейчас не ожидаете реконнекта!')
		end
	end)
	sampRegisterChatCommand('afkrec',function(a)
		a = a and (tonumber(a) and tonumber(a) or 1) or 1
		reconstandart(a)
	end)
	if fastconnect.v then
		sampFastConnect(fastconnect.v)
	end
	workpaus(antiafk.v)
	lua_thread.create(vkget)
    while true do 
		wait(0)
        imgui.Process = afksets.v or #_message>0
		imgui.ShowCursor = afksets.v
		if idsshow then
            local alltextdraws = sampGetAllTextDraws()
            for _, v in pairs(alltextdraws) do
                local fX,fY = sampTextdrawGetPos(v)
                local fX,fY = convertGameScreenCoordsToWindowScreenCoords(fX,fY)	
                renderFontDrawText(font2,tostring(v),tonumber(fX),tonumber(fY),0xD7FFFFFF)
            end
		end
    end
end
function convertHexToImVec4(hex,alp)
	alp = alp or 255 
	local r,g,b = tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
	return imgui.ImVec4(r/255,g/255,b/255,alp/255)
end
function convertImVec4ToU32(imvec)
	return imgui.ImColor(imvec):GetU32()
end
--рендер уведов
function onRenderNotification()
	local count = 0
	for k, v in ipairs(_message) do
		local push = false
		if v.active and v.time < os.clock() then
			v.active = false
			table.remove(_message, k)
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
					imgui.PushStyleVar(imgui.StyleVar.Alpha, (v.time - os.clock()) / 0.3)
					push = true
				end
				local nText = u8(tostring(v.text))
				notfList.size = imgui.GetFont():CalcTextSizeA(imgui.GetFont().FontSize, 200.0, 196.0, nText)
				notfList.pos = imgui.ImVec2(notfList.pos.x, (notfList.pos.y - (count == 1 and notfList.size.y or (notfList.size.y + 40))))
				imgui.SetNextWindowPos(notfList.pos, _, imgui.ImVec2(0.0, 0.0))
				imgui.SetNextWindowSize(imgui.ImVec2(200, notfList.size.y + imgui.GetStyle().ItemSpacing.y + imgui.GetStyle().WindowPadding.y+25))
				imgui.Begin(u8'##msg' .. k, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar)
				imgui.CenterText('AFK Tools')
				imgui.Separator()
				imgui.TextWrapped(nText)
				imgui.End()
				if push then
					imgui.PopStyleVar()
				end
			end
		end
	end
	notfList = list:new()
end
--imgui: элементы акков
function autofillelementsaccs()
	if imgui.Button(u8('Временные данные')) then menufill = 1 end
	imgui.SameLine()
	if imgui.Button(u8('Добавить аккаунт')) then
		imgui.OpenPopup('##addacc')
	end
	if imgui.BeginPopupModal('##addacc',true,imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize) then
		imgui.CenterText(u8('Добавить новый аккаунт'))
		imgui.Separator()
		imgui.CenterText(u8('Ник'))
		imgui.Separator()
		imgui.InputText('##nameadd',addnew.name)
		imgui.Separator()
		imgui.CenterText(u8('Пароль'))
		imgui.Separator()
		imgui.InputText('##addpas',addnew.pass)
		imgui.Separator()
		imgui.CenterText(u8('ID Диалога'))
		imgui.SameLine()
		imgui.TextQuestion(u8('ID Диалога в который надо ввести пароль\nНесколько ID для Arizona RP\n	2 - Диалог ввода пароля\n	991 - Диалог PIN-Кода банка'))
		imgui.Separator()
		imgui.InputInt('##dialogudadd',addnew.dialogid)
		imgui.Separator()
		imgui.CenterText(u8('IP сервера'))
		imgui.SameLine()
		imgui.TextQuestion(u8('IP Сервера, на котором будет введен пароль\nПример: 185.169.134.171:7777'))
		imgui.Separator()
		imgui.InputText('##ipport',addnew.serverip)
		imgui.Separator()
		if imgui.Button(u8("Добавить"), imgui.ImVec2(-1, 20)) then
			if addnew:save() then
				imgui.CloseCurrentPopup()
			end
		end
		if imgui.Button(u8("Закрыть"), imgui.ImVec2(-1, 20)) then
			imgui.CloseCurrentPopup()
		end
		imgui.EndPopup()
	end
	imgui.SameLine()
	imgui.Checkbox(u8('Включить'),autologin.state); imgui.SameLine(); imgui.TextQuestion(u8('Включает автозаполнение в диалоги'))
	imgui.SameLine()
	imgui.CenterText(u8'Автозаполнение'); imgui.SameLine()
	imgui.SameLine(838)
	if imgui.Button(u8('Обновить')) then
		local f = io.open(file_accs, "r")
		if f then
			savepass = decodeJson(f:read("a*"))
			f:close()
		end
		AFKMessage('Подгруженны новые данные')
	end
	imgui.Columns(3, _, true)
	imgui.Separator()
	imgui.SetColumnWidth(-1, 150); imgui.Text(u8"   Никнейм"); imgui.NextColumn()
	imgui.SetColumnWidth(-1, 150); imgui.Text(u8"Сервер"); imgui.NextColumn()
	imgui.SetColumnWidth(-1, 450); imgui.Text(u8"Пароли"); imgui.NextColumn()
	for k, v in pairs(savepass) do
		imgui.Separator()
		if imgui.Selectable(u8('   '..v[1]..'##'..k), false, imgui.SelectableFlags.SpanAllColumns) then imgui.OpenPopup('##acc'..k) end
		if imgui.BeginPopupModal('##acc'..k,true,imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize) then
			btnWidth2 = (imgui.GetWindowWidth() - 22)/2
			imgui.CreatePaddingY(8)
			imgui.CenterText(u8('Аккаунт '..v[1]))
			imgui.Separator()
			for f,t in pairs(v[3]) do
				imgui.Text(u8('Диалог[ID]: '..v[3][f].id..' Введённые данные: '..v[3][f].text))
				if editpass.numedit == f then
					imgui.PushItemWidth(-1)
					imgui.InputText(u8'##pass'..f,editpass.input)
					imgui.PopItemWidth()
					if imgui.Button(u8("Подтвердить##"..f), imgui.ImVec2(-1, 20)) then
						v[3][f].text = editpass.input.v
						editpass.input.v = ''
						editpass.numedit = -1
						saveaccounts()
					end
				elseif editpass.numedit == -1 then
					if imgui.Button(u8("Сменить пароль##2"..f), imgui.ImVec2(-1, 20)) then
						editpass.input.v = v[3][f].text
						editpass.numedit = f
					end
				end
				if imgui.Button(u8("Скопировать##"..f), imgui.ImVec2(btnWidth2, 0)) then
					setClipboardText(v[3][f].text)
					imgui.CloseCurrentPopup()
				end
				imgui.SameLine()
				if imgui.Button(u8("Удалить##"..f), imgui.ImVec2(btnWidth2, 0)) then
					v[3][f] = nil
					if #v[3] == 0 then
						savepass[k] = nil
					end
					saveaccounts()
				end
				imgui.Separator()
			end
			if imgui.Button(u8("Подключиться"), imgui.ImVec2(-1, 20)) then
				local ip2, port2 = string.match(v[2], "(.+)%:(%d+)")
				reconname(v[1],ip2, tonumber(port2))
			end
			if imgui.Button(u8("Удалить все данные"), imgui.ImVec2(-1, 20)) then
				savepass[k] = nil
				imgui.CloseCurrentPopup()
				saveaccounts()
			end
			if imgui.Button(u8("Закрыть##sdosodosdosd"), imgui.ImVec2(-1, 20)) then
				imgui.CloseCurrentPopup()
			end
			imgui.CreatePaddingY(8)
			imgui.EndPopup()
		end
		imgui.NextColumn()
		imgui.Text(tostring(v[2]))
		imgui.NextColumn()
		imgui.Text(u8('Кол-во паролей: '..#v[3]..'. Нажмите ЛКМ для управления паролями'))
		imgui.NextColumn()
	end
	imgui.Columns(1)
	imgui.Separator()
end
--imgui: элементы сейва
function autofillelementssave()
	if imgui.Button(u8'< Аккаунты') then menufill = 0 end
	imgui.SameLine()
	imgui.CenterText(u8'Автозаполнение')
	imgui.SameLine(838) 
	if imgui.Button(u8('Очистка')) then temppass = {}; AFKMessage('Буфер временных паролей очищен!') end
	imgui.Columns(5, _, true)
	imgui.Separator()--710
	imgui.SetColumnWidth(-1, 130); imgui.Text(u8"Диалог[ID]"); imgui.NextColumn()
	imgui.SetColumnWidth(-1, 150); imgui.Text(u8"Никнейм"); imgui.NextColumn()
	imgui.SetColumnWidth(-1, 140); imgui.Text(u8"Сервер"); imgui.NextColumn()
	imgui.SetColumnWidth(-1, 170); imgui.Text(u8"Введенные данные"); imgui.NextColumn()
	imgui.SetColumnWidth(-1, 140); imgui.Text(u8"Время"); imgui.NextColumn()
	for k, v in pairs(temppass) do
		if imgui.Selectable('   '..tostring(u8(string.gsub(v.title, "%{.*%}", "") .. "[" .. v.id .. "]")) .. "##" .. k, false, imgui.SelectableFlags.SpanAllColumns) then
			saveacc(k)
			saveaccounts()
			AFKMessage('Пароль '..v.text..' для аккаунта '..v.nick..' на сервере '..v.ip..' сохранён!')
		end
		imgui.NextColumn()
		imgui.Text(tostring(v.nick))
		imgui.NextColumn()
		imgui.Text(tostring(v.ip))
		imgui.NextColumn()
		imgui.Text(tostring(u8(v.text)))
		imgui.NextColumn()
		imgui.Text(tostring(v.time))
		imgui.NextColumn()
	end
	imgui.Columns(1)
	imgui.Separator()
end
function imgui.OnDrawFrame()
	if afksets.v then
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(920,470))
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2,sh/2),imgui.Cond.FirstUseEver,imgui.ImVec2(0.5,0.5))
		-- imgui.PushStyleVar(imgui.StyleVar.WindowPadding,imgui.ImVec2(0,0))
		imgui.Begin('##afktools',afksets,imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar)
		if menunum > 0 then
			imgui.SetCursorPos(imgui.ImVec2(12,8))
			if imgui.Button('<',imgui.ImVec2(20,34)) then
				menunum = 0
			end
		end
		imgui.SetCursorPos(imgui.ImVec2(40,8))
		imgui.RenderLogo()
		imgui.SetCursorPos(imgui.ImVec2(516,8))
		imgui.BeginGroup()
		imgui.Text(u8('Версия => Текущая: '..thisScript().version..' | Актуальная: '..(updates.data.result and updates.data.relevant_version or 'error')))
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
		imgui.SetCursorPos(imgui.ImVec2(880,25))
		imgui.CloseButton(5.5)
		imgui.SetCursorPos(imgui.ImVec2(0,50))
		imgui.Separator()
		if menunum == 0 then
			local buttons = {
				{u8('Основные'),1,u8('Настройка основных функций')},
				{u8('Автозаполнение'),2,u8('Автоввод текста в диалоги')},
				{u8('VK Notifications'),3,u8('Уведомления в VK')},
				{u8('Автоеда'),4,u8('Автоеда когда вы голодны')},
				{u8('Информация'),5,u8('Полезная информация о скрипте')},
				{u8('История обновлений'),6,u8('Список изменений которые\n	 произошли в скрипте')}
			}
			local function renderbutton(i)
				local name,set,desc,func = buttons[i][1],buttons[i][2],buttons[i][3],buttons[i][4]
				local getpos2 = imgui.GetCursorPos()
				imgui.SetCursorPos(getpos2)
				if imgui.Button('##'..name..'//'..desc,imgui.ImVec2(240,80)) then
					if func then
						pcall(func)
					else
						menunum = set
					end
				end 
				imgui.SetCursorPos(getpos2)
				imgui.BeginGroup()
				imgui.CreatePadding(240/2-imgui.CalcTextSize(name).x/2,15)
				imgui.Text(name)
				imgui.CreatePadding(240/2-imgui.CalcTextSize(desc).x/2,(80/2-imgui.CalcTextSize(desc).y/2)-25)
				imgui.Text(desc)
				imgui.EndGroup()
				imgui.SetCursorPos(imgui.ImVec2(getpos2.x,getpos2.y+90))
			end
			imgui.CreatePaddingY(20)
			local cc = 1
			local startY = 140 
			for i = 1, #buttons do
				local poss = {
					80,
					330,
					580
				}
				imgui.SetCursorPos(imgui.ImVec2(poss[cc],startY))
				renderbutton(i)
				if cc == #poss then
					cc = 0
					startY = startY + 90
				end
				cc = cc + 1
			end
			imgui.SetCursorPos(imgui.ImVec2(920/2 - 300/2,400))
			imgui.BeginGroup()
			if imgui.Button(u8('Сохранить настройки'),imgui.ImVec2(150,30)) then saveini() end
			imgui.SameLine()
			if imgui.Button(u8('Перезагрузить скрипт'),imgui.ImVec2(150,30)) then thisScript():reload() end
			imgui.EndGroup()
			
		elseif menunum == 1 then
			imgui.BeginChild('##ana',imgui.ImVec2(-1,-1),false)
			imgui.CenterText(u8('Автореконнект'))
			imgui.Separator()
			imgui.Checkbox(u8('Включить автореконнект'), arec.state)
			if arec.state.v then
				imgui.Checkbox(u8('Включить автореконнект при You are banned from this server'), arec.statebanned)
			    imgui.SameLine()
			    imgui.PushItemWidth(80)
			    imgui.InputInt(u8('Задержка(сек)###arec'),arec.wait)
			    imgui.PopItemWidth()
			end
			imgui.Separator()
			imgui.CenterText(u8('Автооткрытие рулеток'))
			imgui.Separator()
			imgui.BeginGroup()
			imgui.Text(u8('Внимание! Автооткрытие рулеток нормально работает только на англ. языке инвентаря'))
			imgui.Checkbox(u8('Открывать стандарт сундук'),roulette.standart); imgui.SameLine() imgui.TextQuestion(u8('Для оптимизации открывания сундуков стандартный сундук должен быть в 1 слоте на 1 странице')) 
			imgui.Checkbox(u8('Открывать донат сундук'),roulette.donate); imgui.SameLine() imgui.TextQuestion(u8('[Обязательно!] Донатный сундук должен быть в 2 слоте на 1 странице'))
			imgui.Checkbox(u8('Открывать платина сундук'),roulette.platina); imgui.SameLine() imgui.TextQuestion(u8('[Обязательно!] Платиновый сундук должен быть в 3 слоте на 1 странице'))
			imgui.PushItemWidth(100)
			imgui.InputInt(u8('Задержка (в сек.)##wait'),roulette.wait)
			imgui.SameLine()
			imgui.TextQuestion(u8('Задержка перед чеком состояния рулеток(можно открыть или нет)'))
			imgui.PopItemWidth()
			if imgui.Button(u8('Включить/выключить автооткрытие сундуков')) then 
			    openchestrullet()
			end
			imgui.EndGroup()
			imgui.Separator()
			imgui.CenterText(u8('Флудер'))
			imgui.Separator()
			imgui.BeginGroup()
			imgui.PushItemWidth(400)
			imgui.InputText(u8('1 Строка'),piar.piar1)
			imgui.SameLine()
			imgui.TextQuestion(u8('Обязательная строка'))
			imgui.InputText(u8('2 Строка'),piar.piar2)
			imgui.SameLine()
			imgui.TextQuestion(u8('Оставьте строку пустую если не хотите её использовать'))
			imgui.InputText(u8('3 Строка'),piar.piar3)
			imgui.SameLine()
			imgui.TextQuestion(u8('Оставьте строку пустую если не хотите её использовать'))
			imgui.PopItemWidth()
			imgui.EndGroup()
		
			imgui.SameLine()
		
			imgui.BeginGroup()
			imgui.PushItemWidth(80)
			imgui.InputInt(u8('Задержка(сек.)##piar1'),piar.piarwait); 
			imgui.InputInt(u8('Задержка(сек.)##piar2'),piar.piarwait2); 
			imgui.InputInt(u8('Задержка(сек.)##piar3'),piar.piarwait3); 
			imgui.PopItemWidth()
			imgui.EndGroup()
			if imgui.Button(u8('Активировать флудер')) then 
			    bizpiaron = not bizpiaron
			    activatePiar(bizpiaron)
			    AFKMessage(bizpiaron and 'Пиар включён!' or 'Пиар выключен!',5)
			end
			imgui.SameLine()
			imgui.Checkbox(u8('АвтоПиар'),piar.auto_piar) 
			imgui.SameLine()
			imgui.TextQuestion(u8('Если после последнего выгружения скрипта пройдет меньше указанного(в настройках) времени, включиться автопиар'))
			if piar.auto_piar.v then
			    imgui.SameLine()
			    imgui.PushItemWidth(120)
			    if imgui.InputInt(u8('Максимальное время для включения пиара(в сек.)##autpiar'),piar.auto_piar_kd) then
			        if piar.auto_piar_kd.v < 0 then piar.auto_piar_kd = 0 end
			    end
			    imgui.PopItemWidth()
			end
			imgui.Separator()
			imgui.CenterText(u8('Остальные настройки'))
			imgui.Separator()
			imgui.BeginGroup()
			if imgui.Checkbox(u8('Fastconnect'),fastconnect) then
				sampFastConnect(fastconnect.v)
			end
			imgui.SameLine()
			imgui.TextQuestion(u8('Быстрый вход на сервер'))
			if imgui.Checkbox(u8('AntiAFK'),antiafk) then workpaus(antiafk.v) end
			imgui.SameLine()
			imgui.TextQuestion(u8('Вы не будете стоять в AFK если свернете игру\nВнимание! Если AntiAFK включен и вы сохранили настройки то при следуещем заходе он автоматически включится! Учтите это!'))
			imgui.Checkbox(u8('AutoScreenBan'),banscreen)
			imgui.SameLine()
			imgui.TextQuestion(u8('Если вас забанит админ то скрин сделается автоматически'))
			imgui.Checkbox(u8('Автообновление'),autoupdateState)
			imgui.SameLine()
			imgui.TextQuestion(u8('Включает автообновление. По умолчанию включено'))
			imgui.EndGroup()
			imgui.EndChild()
		elseif menunum == 2 then
			imgui.BeginChild('##ana',imgui.ImVec2(-1,-1),false)
			if menufill == 0 then
				autofillelementsaccs()
			elseif menufill == 1 then
				autofillelementssave()
			end
			imgui.EndChild()
		elseif menunum == 3 then
			imgui.BeginChild('##ana',imgui.ImVec2(-1,-1),false)
			imgui.CenterText('VK Notification')
			imgui.Separator()
			if imgui.Checkbox(u8('Включить уведомления'), vknotf.state) then
				if vknotf.state.v then
					longpollGetKey()
				end
			end
			if vknotf.state.v then
				imgui.BeginGroup()
				if vkerr then
					imgui.Text(u8'Состояние приёма: ' .. u8(vkerr))
					imgui.Text(u8'Для переподключения к серверам нажмите кнопку "Переподключиться к серверам"')
				else
					imgui.Text(u8'Состояние приёма: Активно!')
				end
				if vkerrsend then
					imgui.Text(u8'Состояние отправки: ' .. u8(vkerrsend))
				else
					imgui.Text(u8'Состояние отправки: Активно!')
				end
				imgui.InputText(u8('Токен'), vknotf.token, showtoken and 0 or imgui.InputTextFlags.Password)
				imgui.SameLine()
				if imgui.Button(u8('Показать##1010')) then showtoken = not showtoken end
				imgui.InputText(u8('VK ID'), vknotf.user_id)
				imgui.SameLine()
				imgui.TextQuestion(u8('В цифрах!'))
				imgui.InputText(u8('VK ID Группы'), vknotf.group_id)
				imgui.SameLine()
				imgui.TextQuestion(u8('В цифрах!'))
				imgui.SetNextWindowSize(imgui.ImVec2(900,530))
				if imgui.BeginPopupModal('##howsetVK',true,imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize) then
					imgui.Text(u8(howsetVK))
					imgui.SetCursorPosY(490)
					local wid = imgui.GetWindowWidth()
					imgui.SetCursorPosX(wid / 2 - 30)
					if imgui.Button(u8'Закрыть', imgui.ImVec2(60,20)) then
						imgui.CloseCurrentPopup()
					end
					imgui.EndPopup()
				end
				if imgui.Button(u8('Как настроить')) then imgui.OpenPopup('##howsetVK') end
				imgui.SameLine()
				if imgui.Button(u8('Проверить уведомления')) then sendvknotf('Тестовое сообщение лол кек милота') end
				imgui.SameLine()
				if imgui.Button(u8('Переподключиться к серверам')) then longpollGetKey() end
				imgui.EndGroup()
				imgui.Separator()
				imgui.CenterText(u8('События, при которых отправиться уведомление'))
				imgui.Separator()
				imgui.BeginGroup()
				imgui.Checkbox(u8('Подключение'),vknotf.isinitgame); imgui.SameLine(); imgui.TextQuestion(u8('Если персонаж подключится к серверу'))
				imgui.Checkbox(u8('Администрация'),vknotf.isadm); imgui.SameLine(); imgui.TextQuestion(u8('Если в строке будет слово "Администратор" + ваш ник + красная строка(искл.: окно /pm, чат /pm, ban тоже будут учитываться)'))
				imgui.Checkbox(u8('Голод'),vknotf.ishungry); imgui.SameLine(); imgui.TextQuestion(u8('Если персонаж проголодается'))
				imgui.Checkbox(u8('Кик'),vknotf.iscloseconnect); imgui.SameLine(); imgui.TextQuestion(u8('Если персонаж отключится от сервера'))
				imgui.Checkbox(u8('Деморган'),vknotf.isdemorgan); imgui.SameLine(); imgui.TextQuestion(u8('Если персонаж выйдет из деморгана'))
				imgui.EndGroup()
				imgui.SameLine(350)
				imgui.BeginGroup()
				imgui.Checkbox(u8('PayDay'),vknotf.ispayday); imgui.SameLine(); imgui.TextQuestion(u8('Если персонаж получит PayDay'))
				imgui.Checkbox(u8('Смерть'),vknotf.islowhp); imgui.SameLine(); imgui.TextQuestion(u8('Если персонаж умрет(если вас кто-то убъет, напишет его ник)'))
				imgui.Checkbox(u8('Краш скрипта'),vknotf.iscrashscript); imgui.SameLine(); imgui.TextQuestion(u8('Если скрипт выгрузится/крашнется(даже если перезагрузите через CTRL + R)'))
				imgui.Checkbox(u8('Продажи'),vknotf.issellitem); imgui.SameLine(); imgui.TextQuestion(u8('Если персонаж продаст что-то на ЦР или АБ'))
				imgui.EndGroup()
			end
			imgui.EndChild()
		elseif menunum == 4 then
			imgui.BeginChild('##ana',imgui.ImVec2(-1,-1),false)
			imgui.CenterText(u8('Автоеда'))
			imgui.Separator()
			imgui.BeginGroup()
        	imgui.RadioButton(u8'Оффнуть',eat.eatmetod,0)
			if eat.eatmetod.v > 0 then
				imgui.SameLine()
				imgui.PushItemWidth(140)
				imgui.Combo(u8('Способ проверки голода'), eat.checkmethod, checklist, -1)
				if eat.checkmethod.v == 1 then
					imgui.PushItemWidth(80)
					imgui.SameLine()
					imgui.InputInt(u8('При скольки процентах голода надо кушать'),eat.eat2met,0)
				end
				imgui.PopItemWidth()
			end
			imgui.RadioButton(u8'Кушать Дома',eat.eatmetod,1)
        	imgui.SameLine()
        	imgui.TextQuestion(u8'Ваш персонаж будет кушать дома из холодильника')
        	imgui.BeginGroup()
        	imgui.RadioButton(u8'Кушать вне Дома',eat.eatmetod,2)
        	imgui.SameLine()
        	imgui.TextQuestion(u8'Ваш персонаж будет кушать вне дома способом из списка')
        	if eat.eatmetod.v == 2 then
        	    imgui.Text(u8'Выбор метода еды:')
        	    imgui.PushItemWidth(100)
        	    imgui.Combo('##123123131231232', eat.setmetod, metod, -1)
        	    if eat.setmetod.v == 3 then
        	        imgui.Text(u8("ID TextDraw'a Еды"))
        	        imgui.InputInt(u8"##eat", eat.arztextdrawid,0)      
        	    end    
        	    imgui.PopItemWidth()
        	end
        	imgui.EndGroup()
        	imgui.RadioButton(u8'Кушать в Фам КВ',eat.eatmetod,3)
        	imgui.SameLine()
        	imgui.TextQuestion(u8'Ваш персонаж будет кушать из холодильника в семейной квартире. Для использования встаньте на место, где при нажатии ALT появится диалог с выбором еды')
        	imgui.EndGroup()
        	imgui.BeginGroup()
        	imgui.Checkbox(u8'АвтоХил', eat.healstate)
        	-- imgui.SameLine()
        	if eat.healstate.v then
        	    imgui.PushItemWidth(40)
        	    imgui.InputInt(u8'Уровень HP для Хила', eat.hplvl,0)
        	    imgui.PopItemWidth()
        	    imgui.Text(u8 'Выбор метода хила:')
        	    imgui.PushItemWidth(100)
				imgui.Combo('##ban',eat.hpmetod,healmetod,-1)
				if eat.hpmetod.v == 1 then
        	        imgui.PushItemWidth(30)
        	        imgui.InputInt(u8"Кол-во нарко",eat.drugsquen,0)
        	        imgui.PopItemWidth()
        	    end
        	    if eat.hpmetod.v == 4 then
        	        imgui.Text(u8("ID TextDraw'a Хила"))
        	        imgui.InputInt(u8"##heal",eat.arztextdrawidheal,0)
        	    end
        	    imgui.PopItemWidth()
        	end
        	imgui.EndGroup()
        	imgui.SameLine(130)
        	if imgui.Checkbox(u8('Включить отображение ID текстдравов'), imgui.ImBool(idsshow)) then
        	    idsshow = not idsshow
        	end
			imgui.EndChild()
		elseif menunum == 5 then
			imgui.BeginChild('##ana',imgui.ImVec2(-1,-1),false)
			imgui.CenterText(u8('Информация'))
			imgui.Separator()
			imgui.Text(u8(scriptinfo))
			imgui.EndChild()
		elseif menunum == 6 then
			imgui.BeginChild('##ana',imgui.ImVec2(-1,-1),false)
			imgui.CenterText(u8('История обновлений'))
			imgui.Separator()
			imgui.Text(u8(changelog))
			imgui.Text(u8(changelog2))
			imgui.EndChild()
		end
		imgui.End()
	end
	onRenderNotification()
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
function imgui.CloseButton(rad)
	local pos = imgui.GetCursorScreenPos()
	local poss = imgui.GetCursorPos()
	local a,b,c,d = pos.x - rad, pos.x + rad, pos.y - rad, pos.y + rad
	local e,f = poss.x - rad, poss.y - rad
	local list = imgui.GetWindowDrawList()
	list:AddLine(imgui.ImVec2(a,d),imgui.ImVec2(b,c),convertImVec4ToU32(convertHexToImVec4('FFFFFF')))
	list:AddLine(imgui.ImVec2(b,d),imgui.ImVec2(a,c),convertImVec4ToU32(convertHexToImVec4('FFFFFF')))
	imgui.SetCursorPos(imgui.ImVec2(e,f))
	if imgui.InvisibleButton('##closebutolo',imgui.ImVec2(rad*2,rad*2)) then
		afksets.v = false
	end
end
function imgui.RenderLogo()
	imgui.Image(logos,imgui.ImVec2(40,40))
end
function imgui.CenterText(text) 
	local width = imgui.GetWindowWidth()
	local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(text)
end
function imgui.TextQuestion(text)
  imgui.TextDisabled('(?)')
  imgui._atq(text)
end
function imgui._atq(text)
	if imgui.IsItemHovered() then
		imgui.BeginTooltip()
		imgui.PushTextWrapPos(450)
		imgui.TextUnformatted(text)
		imgui.PopTextWrapPos()
		imgui.EndTooltip()
	end
end
function imgui.CreatePaddingX(x)
	x = x or 8
	local cc = imgui.GetCursorPos()
	imgui.SetCursorPosX(cc.x+x)
end
function imgui.CreatePaddingY(y)
	y = y or 8
	local cc = imgui.GetCursorPos()
	imgui.SetCursorPosY(cc.y+y)
end
function imgui.CreatePadding(x,y)
	x,y = x or 8, y or 8
	local cc = imgui.GetCursorPos()
	imgui.SetCursorPos(imgui.ImVec2(cc.x+x,cc.y+y))
end


function onScriptTerminate(scr,qgame)
	if scr == thisScript() then
		mainIni.piar.last_time = os.time()
		local saved = inicfg.save(mainIni,'afktools.ini')
		if vknotf.iscrashscript.v then
			sendvknotf('Скрипт умер :(')
		end	
	end
end
--получить все текстдравы
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

--сделать скрин
function takeScreen()
	if isSampLoaded() then
		memory.setuint8(sampGetBase() + 0x119CBC, 1)
	end
end
--antiafk
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
	-- AFKMessage('AntiAFK '..(bool and 'работает' or 'не работает'))
end
function sampFastConnect(bool)
	if bool then 
		writeMemory(sampGetBase() + 0x2D3C45, 2, 0, true)
	else
		writeMemory(sampGetBase() + 0x2D3C45, 2, 8228, true)
	end
end
-- автозаполнение
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

--хукиииииииииииииииииии
function onReceivePacket(id, bitStream)
	if (id == PACKET_DISCONNECTION_NOTIFICATION or id == PACKET_INVALID_PASSWORD) then
		goaurc()
	end
	if (id == PACKET_CONNECTION_BANNED) then	
		ip,port = sampGetCurrentServerAddress()
		if arec.state.v and arec.statebanned.v then
			lua_thread.create(function()
				wait(1000)
				sampConnectToServer(ip,port)
			end)
		end
	end
	if (id == 29) then 
		if vknotf.iscloseconnect.v then
			sendvknotf("Server didn't not respond") 
		end
	end
end
function onReceiveRpc(id,bitStream)
	if (id == RPC_CONNECTIONREJECTED) then
		goaurc()
	end
end

tblclosetest = {['50.83'] = 50.84, ['49.9'] = 50, ['49.05'] = 49.15, ['48.2'] = 48.4, ['47.4'] = 47.6, ['46.5'] = 46.7, ['45.81'] = '45.84',
['44.99'] = '45.01', ['44.09'] = '44.17', ['43.2'] = '43.4', ['42.49'] = '42.51', ['41.59'] = '41.7', ['40.7'] = '40.9', ['39.99'] = 40.01,
['39.09'] = 39.2, ['38.3'] = 38.4, ['37.49'] = '37.51', ['36.5'] = '36.7', ['35.7'] = '35.9', ['34.99'] = '35.01', ['34.1'] = '34.2';}
tblclose = {}

sendcloseinventory = function()
	sampSendClickTextdraw(tblclose[1])
end
function sampev.onShowTextDraw(id,data)
	-- for k,v in pairs(data) do
	-- 	if id == 2110 then
	-- 		__idclosebutton = id
	-- 		print(k,v)
	-- 		if type(v) == 'table' then
	-- 			for kb,bv in pairs(v) do
	-- 				print('	',kb,bv)
	-- 			end
	-- 		end
	-- 	end
	-- end

	--find close button / thx dmitriyewich
	for w, q in pairs(tblclosetest) do
		if data.lineWidth >= tonumber(w) and data.lineWidth <= tonumber(q) and data.text:find('^LD_SPAC:white$') then
			for i=0, 2 do rawset(tblclose, #tblclose + 1, id) end
		end
	end

	if eat.checkmethod.v == 1 then
		if data.boxColor == -1436898180 then 
			if data.position.x == 549.5 and data.position.y == 60 then
				print('get hun > its hungry')
				if math.floor(((data.lineWidth - 549.5) / 54.5) * 100) <= eat.eat2met.v then
					onPlayerHungry:run()
				end
			end
		end
	end
	if aopen then -- state
		if roulette.standart.v then --standard
			if data.modelId == 19918 then --standart model
				opentimerid.standart = id + 1
			end
			if checkopen.standart then
				if id == opentimerid.standart then
					AFKMessage('[standart] пытаюсь открыть сундук')
					sampSendClickTextdraw(id - 1) 
					sampSendClickTextdraw(2302)
					if not checkopen.donate and not checkopen.platina then
						sendcloseinventory()
					end
					checkopen.standart = false
				end
			end
		end
		if roulette.donate.v then
			if data.modelId == 19613 then --standart model
				opentimerid.donate = id + 1
			end
			if checkopen.donate then
				if id == opentimerid.donate then
					AFKMessage('[donate] пытаюсь открыть сундук')
					sampSendClickTextdraw(id - 1) 
					sampSendClickTextdraw(2302)
					if not checkopen.standard and not checkopen.platina then
						sendcloseinventory()
					end
					checkopen.donate = false
				end
			end
		end
		if roulette.platina.v then
			if data.modelId == 1353 then --standart model
				opentimerid.platina = id + 1
			end
			if checkopen.platina then
				if id == opentimerid.platina then
					AFKMessage('[platina] пробую открыть сундук')
					sampSendClickTextdraw(id - 1) 
					sampSendClickTextdraw(2302)
					if not checkopen.standard and not checkopen.donate then
						sendcloseinventory()
					end
					checkopen.platina = false
				end
			end
		end
	end
	-- print('ID = %s, ModelID = %s',id,data.modelId)
end
function sampev.onSetPlayerHealth(healthfloat)
	if eat.healstate.v and sampIsLocalPlayerSpawned() then
		if healthfloat <= eat.hplvl.v then
			if eat.hpmetod.v == 0 then
				sampSendChat('/usemed')
			elseif eat.hpmetod.v == 1 then
				sampSendChat('/usedrugs '..eat.drugsquen.v)
			elseif eat.hpmetod.v == 2 then
				sampSendChat('/adrenaline')
			elseif eat.hpmetod.v == 3 then
				sampSendChat('/beer')
			elseif eat.hpmetod.v == 4 then
				sampSendClickTextdraw(eat.arztextdrawidheal.v)
			end 
		end   
	end
end
function sampev.onSendTakeDamage(playerId, damage, weapon, bodypart)
	local killer = ''
	if vknotf.islowhp.v then
		if sampGetPlayerHealth(select(2, sampGetPlayerIdByCharHandle(playerPed))) - damage <= 0 and sampIsLocalPlayerSpawned() then
			if playerId > -1 and playerId < 1001 then
				killer = '\nУбийца: '..sampGetPlayerNickname(playerId)..'['..playerId..']'
			end
			sendvknotf('Ваш персонаж умер'..killer)
		end
	end
end
function sampev.onShowDialog(dialogId, dialogStyle, dialogTitle, okButtonText, cancelButtonText, dialogText)
	if dialogText:find('Вы получили бан аккаунта') then
		if banscreen.v then
			createscreen:run()
		end
		if vknotf.isadm.v then
			local svk = dialogText:gsub('\n','') 
			svk = svk:gsub('\t','') 
			sendvknotf('(warning | dialog) '..svk)
		end
	end
	if vknotf.isadm.v then
		if dialogText:find('Администратор (.+) ответил вам') then
			local svk = dialogText:gsub('\n','') 
			svk = svk:gsub('\t','') 
			sendvknotf('(warning | dialog) '..svk)
		end
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
	if gethunstate and dialogId == 0 and dialogText:find('Ваша сытость') then
		sampSendDialogResponse(id,0,0,'')
		gethunstate = dialogText
		return false
	end
	if sendstatsstate and dialogId == 235 then
		sampSendDialogResponse(id,0,0,'')
		sendstatsstate = dialogText
		return false
	end
	if dialogStyle == 1 or dialogStyle == 3 then
		local acc = getAcc()
		local bool = true
		if acc > -1 then
			if autologin.state.v then
				local dialog = findDialog(acc, dialogId)
				if dialog > -1 then
				
					sampSendDialogResponse(dialogId, 1, 0, tostring(savepass[acc][3][dialog].text))
					return false
				else
					bool = true
				end
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
end
function sampev.onServerMessage(color,text)
	-- print(text .. ' \\ ' .. color)
	if gotoeatinhouse then
		if text:find('электроэнергию') then
			AFKMessage('Невозможно покушать! Оплатите комуналку!')
			gotoeatinhouse = false
		end
	end
	if vknotf.issellitem.v then 
		if color == -1347440641 and text:find('от продажи') and text:find('комиссия') then
			sendvknotf(text)
		end
		if color == 1941201407 and text:find('Поздравляем с продажей транспортного средства') then
			sendvknotf('Поздравляем с продажей транспортного средства')
		end
	end
	if color == -10270721 and text:find('Вы можете выйти из психиатрической больницы') then
		if vknotf.isdemorgan.v then
			sendvknotf(text)
		end
	end
	if text:find('^Администратор (.+) ответил вам') then
		if vknotf.isadm.v then
			sendvknotf('(warning | chat) '..text)
		end
	end
	if color == -10270721 and text:find('Администратор') then
		local res, mid = sampGetPlayerIdByCharHandle(PLAYER_PED)
		if res then 
			local mname = sampGetPlayerNickname(mid)
			if text:find(mname) then
				if vknotf.isadm.v then
					sendvknotf(text)
				end
			end
		end
	end
	if vknotf.ispayday.v then
		if text:find('Банковский чек') and color == 1941201407 then
			vknotf.ispaydaystate = true
			vknotf.ispaydaytext = ''
		end
		if vknotf.ispaydaystate then
			if text:find('Депозит в банке') then 
				vknotf.ispaydaytext = vknotf.ispaydaytext..'\n'..text
			elseif text:find('Сумма к выплате') then
				vknotf.ispaydaytext = vknotf.ispaydaytext..'\n'..text 
			elseif text:find('Текущая сумма в банке') then
				vknotf.ispaydaytext = vknotf.ispaydaytext..'\n'..text
			elseif text:find('Текущая сумма на депозите') then
				vknotf.ispaydaytext = vknotf.ispaydaytext..'\n'..text
			elseif text:find('В данный момент у вас') then
				vknotf.ispaydaytext = vknotf.ispaydaytext..'\n'..text
				sendvknotf(vknotf.ispaydaytext)
				vknotf.ispaydaystate = false
				vknotf.ispaydaytext = ''
			end
		end
	end
end
function sampev.onInitGame(playerId, hostName, settings, vehicleModels, unknown)
	if vknotf.isinitgame.v then
		sendvknotf('Вы подключились к серверу!', hostName)
	end
end
function sampev.onDisplayGameText(style, time, text)
	-- print('[GameText | '..os.date('%H:%M:%S')..'] '..'style == '..style..', time == '..time..', text == '..text)
	if eat.checkmethod.v == 0 then
		if text == ('You are hungry!') or text == ('~r~You are very hungry!') then
			if vknotf.ishungry.v then
				sendvknotf('Вы проголодались!')
			end
			onPlayerHungry:run()
		end
	end 
end
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
-- реконы 
-- рекон стандарт 
function reconstandart(timewait,bool_close)
	if handle_aurc then
		handle_aurc:terminate()
		handle_aurc = nil
		AFKMessage('Автореконнект остановлен т.к вы использовали обычный реконнект')
	end
	if handle_rc then
		handle_rc:terminate()
		handle_rc = nil
		AFKMessage('Предыдущий реконнект был остановлен')
	end
	handle_rc = lua_thread.create(function(timewait2, bclose)
		bclose = bclose or true
		if bclose then
			closeConnect()
		end
		timewait2 = tonumber(timewait2)
		if timewait2 then	
			if timewait2 >= 0 then
				recwaitim = timewait2*1000
				AFKMessage('Реконнект через '..timewait2..' секунд')
				wait(recwaitim)
				sampConnectToServer(sampGetCurrentServerAddress())
			end
		else
			AFKMessage('Реконнект...')
			sampConnectToServer(sampGetCurrentServerAddress())
		end  
		handle_rc = nil
	end,timewait, bool_close)
end
--рекон с ником 
function reconname(playername,ips,ports)
	if handle_aurc then
		handle_aurc:terminate()
		handle_aurc = nil
		AFKMessage('Автореконнект остановлен т.к вы использовали реконнект с ником')
	end
	if handle_rc then
		handle_rc:terminate()
		handle_rc = nil
		AFKMessage('Предыдущий реконнект был остановлен')
	end
	handle_rc = lua_thread.create(function()
		if #playername == 0 then
			AFKMessage('Введите ник для реконнекта')
		else
			closeConnect()
			sampSetLocalPlayerName(playername)
			AFKMessage('Реконнект с новым ником\n'..playername)
			local ip, port = sampGetCurrentServerAddress()
			ips,ports = ips or ip, ports or port
			sampConnectToServer(ips,ports)
		end 
	end)
end
-- создать autorecon
function goaurc()
	if vknotf.iscloseconnect.v then
		sendvknotf('Потеряно соединение с сервером')
	end
	if arec.state.v then
		if handle_aurc then
			handle_aurc:terminate()
			handle_aurc = nil
			AFKMessage('Предыдущий автореконнект был остановлен')
		end
		if handle_rc then
			handle_rc:terminate()
			handle_rc = nil
			AFKMessage('Обычный автореконнект был остановлен т.к сработал автореконнект')
		end
		handle_aurc = lua_thread.create(function()
			local ip, port = sampGetCurrentServerAddress()
			AFKMessage('Соединение потеряно. Реконнект через '..arec.wait.v..' секунд')
			wait(arec.wait.v * 1000)
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

--//saves
function saveini()
	--login
	mainIni.autologin.state = autologin.state.v
	--autoreconnect
	mainIni.arec.state = arec.state.v
	mainIni.arec.statebanned = arec.statebanned.v
	mainIni.arec.wait = arec.wait.v
	--roulette
	mainIni.roulette.standart = roulette.standart.v
	mainIni.roulette.donate = roulette.donate.v
	mainIni.roulette.wait = roulette.wait.v
	--vk.notf
	mainIni.vknotf.state = vknotf.state.v
	mainIni.vknotf.token = vknotf.token.v
	mainIni.vknotf.user_id = vknotf.user_id.v
	mainIni.vknotf.group_id = vknotf.group_id.v
	mainIni.vknotf.isadm = vknotf.isadm.v	
	mainIni.vknotf.isinitgame = vknotf.isinitgame.v	
	mainIni.vknotf.iscloseconnect = vknotf.iscloseconnect.v
	mainIni.vknotf.ishungry = vknotf.ishungry.v
	mainIni.vknotf.isdemorgan = vknotf.isdemorgan.v
	mainIni.vknotf.islowhp = vknotf.islowhp.v
	mainIni.vknotf.ispayday = vknotf.ispayday.v
	mainIni.vknotf.iscrashscript = vknotf.iscrashscript.v
	mainIni.vknotf.issellitem = vknotf.issellitem.v
	--piar
	mainIni.piar.piar1 = piar.piar1.v
	mainIni.piar.piar2 = piar.piar2.v
	mainIni.piar.piar3 = piar.piar3.v
	mainIni.piar.piarwait = piar.piarwait.v
	mainIni.piar.piarwait2 = piar.piarwait2.v
	mainIni.piar.piarwait3 = piar.piarwait3.v
	mainIni.piar.auto_piar = piar.auto_piar.v
	mainIni.piar.auto_piar_kd = piar.auto_piar_kd.v
	--main config
	mainIni.config.antiafk = antiafk.v
	mainIni.config.banscreen = banscreen.v
	mainIni.config.autoupdate = autoupdateState.v
	mainIni.config.fastconnect = fastconnect.v
	--eat
	mainIni.eat.checkmethod = eat.checkmethod.v
	mainIni.eat.cycwait = eat.cycwait.v
	mainIni.eat.eatmetod = eat.eatmetod.v
	mainIni.eat.eat2met = eat.eat2met.v
    mainIni.eat.arztextdrawid = eat.arztextdrawid.v
    mainIni.eat.arztextdrawidheal = eat.arztextdrawidheal.v
    mainIni.eat.setmetod = eat.setmetod.v
    mainIni.eat.hpmetod = eat.hpmetod.v
    mainIni.eat.hplvl = eat.hplvl.v
    mainIni.eat.healstate = eat.healstate.v
	mainIni.eat.drugsquen = eat.drugsquen.v
	mainIni.eat.hpmetod = eat.hpmetod.v
	local saved = inicfg.save(mainIni,'afktools.ini')
	AFKMessage('Настройки INI сохранены '..(saved and 'успешно!' or 'с ошибкой!'))
end
function saveacc(...)
	local a = {...}

	local data
	if #a == 1 then
		data = temppass[a[1]]
	else
		data = {
			nick = a[1],
			ip = a[4],
			id = a[3],
			text = a[2]
		}
	end
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
end
function saveaccounts()
	if doesFileExist(file_accs) then
		os.remove(file_accs)
	end
	if table.maxn(savepass) > 0 then
		local f = io.open(file_accs, "w")
		if f then
			f:write(encodeJson(savepass))
			f:close()
		end
	end
	print('[Accounts] Saved!')
end
-- // система автообновления
updates = {}
updates.data = {
	result = false,
	status = '',
	relevant_version = '',
	url_update = '',
	url_json = 'https://ronnysoftware.github.io/api/updates/afktools' 
}
function updates:getlast(autoupd)
	print('call getlast')
	self.data.status = 'Проверяю обновления'
	if autoupd then
		AFKMessage(self.data.status)
	end
	local json = path .. '\\updateafktools.json'
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
						self.data.status = '[decode] Ошибка при загрузке JSON фалйа!\nОбратитесь в тех.поддержку скрипта'
						if autoupd then
							AFKMessage(self.data.status)
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
						AFKMessage(self.data.status)
					end
					return false
				end
			else
				self.data.result = false
				self.data.status = '[exist] Невозможно проверить обновление!\nЧто-то блокирует соединение с сервером\nОбратитесь в тех.поддержку скрипта'
				if autoupd then
					AFKMessage(self.data.status)
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
			AFKMessage(self.data.status)
			int_scr_download = downloadUrlToFile(self.data.url_update, thisScript().path, function(id3, status1, p13, p23)
				if status1 == dlstatus.STATUS_ENDDOWNLOADDATA and int_scr_download == id3 then
					AFKMessage('Загрузка обновления завершена.')
					AFKMessage('Обновление завершено!')
					goupdatestatus = true          
					lua_thread.create(function() wait(500) thisScript():reload() end)
				end
				if status1 == dlstatus.STATUSEX_ENDDOWNLOAD and int_scr_download == id3 then
					if goupdatestatus == nil then
						self.data.status = 'Обновление прошло неудачно. Запущена старая версия.'
						AFKMessage(self.data.status)
					end
				end
			end)
		else
			self.data.status = 'Обновление не требуется.'
			AFKMessage(self.data.status)
		end
	end
end
function updates:autoupdate()
	local result = self:getlast(true)
	if result then
		self:download()
	end
end
--// стиль, тема и лого
function esstyle()
	imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
	local ImVec2 = imgui.ImVec2
	
	style.WindowPadding = imgui.ImVec2(8, 8)
	style.WindowRounding = 4
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
esstyle()

function theme1()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
	colors[clr.Text]                   = ImVec4(0.90, 0.90, 0.90, 1.00);
    colors[clr.TextDisabled]           = ImVec4(0.60, 0.60, 0.60, 1.00);
    colors[clr.WindowBg]               = ImVec4(0.08, 0.08, 0.08, 1.00);
	colors[clr.ChildWindowBg]          = colors[clr.WindowBg];
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
    colors[clr.ScrollbarBg]            = ImVec4(0.13, 0.13, 0.13, 0.00);
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
    colors[clr.Separator]              = ImVec4(1.00, 1.00, 1.00, 0.40);
    colors[clr.SeparatorHovered]       = ImVec4(0.36, 0.36, 0.36, 0.40);
    colors[clr.SeparatorActive]        = ImVec4(0.23, 0.23, 0.23, 0.40);
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
    colors[clr.TextSelectedBg]         = ImVec4(0.25, 0.25, 0.25, 0.60);
    colors[clr.ModalWindowDarkening]   = ImVec4(0.21, 0.21, 0.21, 0.51);
end

theme1()
local _logos ="\x89\x50\x4E\x47\x0D\x0A\x1A\x0A\x00\x00\x00\x0D\x49\x48\x44\x52\x00\x00\x00\x28\x00\x00\x00\x28\x08\x06\x00\x00\x00\x8C\xFE\xB8\x6D\x00\x00\x00\x09\x70\x48\x59\x73\x00\x00\x0B\x13\x00\x00\x0B\x13\x01\x00\x9A\x9C\x18\x00\x00\x00\x20\x63\x48\x52\x4D\x00\x00\x7A\x25\x00\x00\x80\x83\x00\x00\xF9\xFF\x00\x00\x80\xE9\x00\x00\x75\x30\x00\x00\xEA\x60\x00\x00\x3A\x98\x00\x00\x17\x6F\x92\x5F\xC5\x46\x00\x00\x19\x38\x49\x44\x41\x54\x78\x01\x00\x28\x19\xD7\xE6\x01\xFF\xFF\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x66\x00\x00\x00\x11\x00\x00\x00\x00\x00\x00\x00\x89\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x11\x00\x00\x00\x99\x00\x00\x00\x00\x00\x00\x00\x9A\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x66\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xBC\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\xFF\xFF\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xCC\x00\x00\x00\x33\x00\x00\x00\xEF\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x22\x00\x00\x00\x33\x00\x00\x00\x00\x00\x00\x00\x9A\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x66\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xAB\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\xFF\xFF\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xDD\x00\x00\x00\x22\x00\x00\x00\xDE\x00\x00\x00\x23\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x33\x00\x00\x00\x22\x00\x00\x00\x00\x00\x00\x00\x9A\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x66\x00\x00\x00\x33\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x66\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xAB\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x77\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x22\xFF\xFF\xFF\xBB\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x44\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\xEE\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xCC\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xDD\xFF\xFF\xFF\x44\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x11\xFF\xFF\xFF\x77\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x44\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x55\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x66\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xAA\xFF\xFF\xFF\x22\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x55\xFF\xFF\xFF\xDD\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xCC\xFF\xFF\xFF\x22\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x99\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x11\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\xBB\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xEE\xFF\xFF\xFF\x77\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x22\xFF\xFF\xFF\xBB\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xEE\xFF\xFF\xFF\x66\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x11\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xAA\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x44\xFF\xFF\xFF\xDD\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xDD\xFF\xFF\xFF\x44\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x77\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x88\xFF\xFF\xFF\x11\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x66\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x66\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x77\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x99\xFF\xFF\xFF\x11\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x22\xFF\xFF\xFF\xBB\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xDD\xFF\xFF\xFF\x66\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\xAA\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xEE\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x44\xFF\xFF\xFF\xBB\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xDD\xFF\xFF\xFF\x44\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x55\xFF\xFF\xFF\xEE\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xBB\xFF\xFF\xFF\x44\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x22\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x99\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x22\xFF\xFF\xFF\x99\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xEE\xFF\xFF\xFF\x77\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x11\xFF\xFF\xFF\x88\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x33\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x77\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x55\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\xEE\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xBB\xFF\xFF\xFF\x22\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x33\xFF\xFF\xFF\xBB\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x44\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\xCC\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xDD\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xDD\xFF\xFF\xFF\x55\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x66\xFF\xFF\xFF\xEE\xFF\xFF\xFF\x44\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x22\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x88\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x77\xFF\xFF\xFF\x11\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x11\xFF\xFF\xFF\x11\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x88\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x33\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x22\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\xFF\xFF\xFF\x00\x01\xFF\xFF\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xDD\x00\x00\x00\x22\x00\x00\x00\xDE\x00\x00\x00\x23\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x33\x00\x00\x00\x22\x00\x00\x00\x00\x00\x00\x00\x9A\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x66\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xAB\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\xFF\xFF\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xEE\x00\x00\x00\x11\x00\x00\x00\xBC\x00\x00\x00\x45\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x55\x00\x00\x00\x11\x00\x00\x00\x00\x00\x00\x00\xAB\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x55\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xAB\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x11\x00\x00\x00\xBC\x00\x00\x00\xCD\x00\x00\x00\xEF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\xFF\xFF\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\xFF\xFF\x04\xE2\xBC\xA7\x45\x71\x94\xC3\x00\x00\x00\x00\x49\x45\x4E\x44\xAE\x42\x60\x82"
logos = imgui.CreateTextureFromMemory(memory.strptr(_logos),#_logos)