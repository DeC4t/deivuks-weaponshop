fx_version 'cerulean'
game 'gta5'

author '🖤Deivuks_420🖤#8641'
description 'Deivuks Weaponshop'
version 'v1.0'

lua54 'yes'

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/*.css',
	'html/*.js',
	'html/img/*.png',
	'html/img/weapons/*.png',
	'html/img/attachments/*.png',
	'html/img/bullets/*.png',
}

shared_scripts {
	'configs/*.lua',
}

client_script 'client/main.lua'

server_script 'server/main.lua'