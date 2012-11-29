#!/usr/bin/env lua
require 'os'
require 'dict4ini'

passwordfile = os.getenv('SvnAuthUserFile') or 'authfile'
authz_file = os.getenv('SvnAuthzAccessFile') or 'authz.conf'

username, password = arg[1], arg[2]

if username and password then
    -- user exits ? 
    cfg = dict4ini.read(authz_file)
    local u_list = ','
    for k,v in pairs(cfg['groups'])  do u_list = u_list .. v .. ',' end
    if not string.find(u_list,  ',' .. username .. ',')
    then
        io.stderr:write(string.format('User [%s] Not Exist! \n', username))
        os.exit(-1)
    end

   -- create file if not exits
    os.execute(string.format('[ -e %s ] || touch %s', passwordfile, passwordfile))

    os.execute(string.format('htpasswd -b %s %s %s', passwordfile, username, password))
    io.stdout:write("success!\n")
    os.exit(0)
else
    io.stderr:write(string.format ("Usage: %s USERNAME PASSWORD\n", arg[0]))
    os.exit(-1)
end

