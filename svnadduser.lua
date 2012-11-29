#!/usr/bin/env lua
require 'os'
require 'dict4ini'

authz_file = os.getenv('SvnAuthzAccessFile') or 'authz.conf'

-- svnadduser username -g groupname
username, option, groupname = arg[1], arg[2], arg[3]
if username and option =='-g' and groupname
then
    -- user exits ? 
    cfg = dict4ini.read(authz_file)
    local u_list = ','
    for k,v in pairs(cfg['groups'])  do u_list = u_list .. v .. ',' end
    if string.find(u_list,  ',' .. username .. ',') then
        io.stderr:write(string.format('User [%s] Exist! \n', username))
        os.exit(-1)
    end

    dict4ini.update('groups', groupname, cfg['groups'][groupname] .. ',' .. username)
    io.stdout:write(string.format('add user %s success\n', username))
else
    io.stderr:write(string.format ("Usage: %s USERNAME -g GROUPNAME\n", arg[0]))
    os.exit(-1)
end

