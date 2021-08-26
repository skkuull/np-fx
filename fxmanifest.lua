fx_version 'cerulean'
games { 'gta5' }

ui_page 'index.html'

server_script '@np-lib/server/sv_infinity.lua'

client_script 'cl_*.lua'

shared_script 'sh_*.lua'

server_scripts {
    'sv_*.lua'
}

files {
    'index.html',
    'sounds/*.ogg'
}