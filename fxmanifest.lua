fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'ac_scoreboard'
author 'ANTOND.#8507'
version '1.0.0'
description 'WIP scoreboard for ox_core'
repository 'https://github.com/antond15/ac_scoreboard'

dependency 'ox_core'

ui_page 'web/build/index.html'

files {
  'web/build/index.html',
  'web/build/**/*',
  'locales/*.lua'
}

shared_scripts {
  '@ox_lib/init.lua',
  'config.lua'
}

client_scripts {
  'resource/locales.lua',
  'resource/client.lua'
}

server_script 'resource/server.lua'
