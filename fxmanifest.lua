fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

name 'ac_scoreboard'
author 'AC Scripts'
version '2.2.3'
description 'A framework-standalone scoreboard UI for FiveM.'
repository 'https://github.com/acscripts/ac_scoreboard'


shared_script '@ox_lib/init.lua'
server_script 'resource/server.lua'
client_script 'resource/client.lua'


ui_page 'web/build/index.html'

files {
  'web/build/index.html',
  'web/build/**/*',
  'config.lua',
  'modules/client/*.lua',
  'locales/*.json',
}


ox_libs {
  'locale',
}

dependencies {
  '/native:0xAB7F7241',
  'ox_lib',
}
