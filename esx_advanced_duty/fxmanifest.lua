fx_version 'cerulean'
game 'gta5'

author 'The Owls - Nosmakos'
description 'ESX Advanced Duty System'
version '1.0.0'

client_script 'client/main.lua'

shared_scripts {
	'@es_extended/imports.lua',
    '@es_extended/locale.lua',
    'locales/*.lua',
    'config.lua'
}

server_script 'server/main.lua'

dependency 'es_extended'
