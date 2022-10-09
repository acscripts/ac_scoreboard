fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'ac_scoreboard'
author 'ANTOND.#8507'
version '1.0.0'
description 'A framework-standalone scoreboard UI for FiveM.'
repository 'https://github.com/antond15/ac_scoreboard'

dependency 'ox_lib'

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

server_scripts {
  'resource/server/server.lua',
  'resource/server/framework.lua'
}
