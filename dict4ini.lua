#!/usr/bin/env lua
---  http://en.wikipedia.org/wiki/INI_file
dict4ini={}
function dict4ini.read(inifile)
    local cfg={}
    for line in io.lines(inifile)
    do
        if not (string.match(line, '^#') or string.len(line) == 0 )then
            -- search for: [section]
            section = string.match(line, '^%[(.*)%]$') or section or 'nil'
            if section then
                if not cfg[section] then cfg[section] ={} end
                name, value = string.match(line, '^(.*)%s=%s*(.*)')
                if name then cfg[section][name] = value end
            end
        end
    end
    return cfg
end

