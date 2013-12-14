#!/usr/bin/env lua
--[[
v1.2 
    支持 ini 文件中等号两边没有空格的情况
v1.1
--  缺陷: 目前需要 ini 文件中等号两边有空格.
      如果等号两边没有空格,会匹配失败
 http://en.wikipedia.org/wiki/INI_file
--]]
dict4ini={}
function dict4ini.read(inifile)
    dict4ini.cfg={}
    dict4ini.inifile=inifile
    local line,section,name,value 
    for line in io.lines(inifile)
    do
        if not (string.match(line, '^#') or string.len(line) == 0 )then
            -- search for: [section]
            section = string.match(line, '^%[(.*)%]$') or section or 'nil'
            if section then
                -- 这里存在缺陷, 只支持等号两边有空格的情况!. < 已解决.
                if not dict4ini.cfg[section] then dict4ini.cfg[section] ={} end
                name, value = string.match(line, '^(.*)%s*=%s*(.*)$')
                if name then
                    name = string.gsub(name, '%s', '')
                    dict4ini.cfg[section][name] = string.gsub(value, '%s', '')
                end
            end
        end
    end
    return dict4ini.cfg
end

function dict4ini.dump()
    for k,v in pairs(dict4ini.cfg)
    do
	print(string.format("[%s]", k))
	if type(v) == 'table' then
	    for k1,v1 in pairs(v)
	    do
		print(string.format("%s = %s", k1,v1))
            end
	else
	    print(value)
	end
    end
end

function dict4ini.update(in_section,in_name,in_value, debug_mode)
    if dict4ini.cfg[in_section][in_name] then
        local tmpbuf={}
        local line,section,name,value 
        for line in io.lines(dict4ini.inifile)
        do
            section = string.match(line, '^%[(.*)%]$') or section or nil
            if section == in_section then
                name, value = string.match(line, '^(.*)%s*=%s*(.*)')
                if name then name = string.gsub(name, '%s', '') end
                if name == in_name then line=string.format("%s=%s",name, in_value) end
            end
            table.insert(tmpbuf, line)
        end
	table.insert(tmpbuf, '')
        fp = io.open(dict4ini.inifile .. (debug_mode or ''), 'w')
        fp:write(table.concat(tmpbuf, '\n'))
        fp:flush()
	fp:close()
    else
        io.stderr:write(string.format("section=[%s],name=[%s] not exists!", in_section,in_name))
    end
end

