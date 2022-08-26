fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'ac_radio'
author 'ANTOND.#8507'
version '0.0.0'
description 'WIP scoreboard for ox_core'
repository 'https://github.com/antond15/ac_scoreboard'

dependency 'ox_core'

ui_page 'web/build/index.html'

files {
  'web/build/index.html',
  'web/build/**/*'
}

shared_scripts {
  '@ox_lib/init.lua',
  'resource/config.lua'
}

client_script 'resource/client.lua'
server_script 'resource/server.lua'
