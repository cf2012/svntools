保存一下自己写的svn 工具

需要的环境变量:
SvnAuthUserFile   存放svn用户密码的文件.用作鉴权
SvnAuthzAccessFile 存放组信息的文件

另外,需要将程序部署目录加入LUA_PATH中
LUA_PATH="${HOME}/bin/?.lua;$LUA_PATH"

支持的系统:
Linux, Mac OS. 
不支持 Windows. (svnpasswd.lua中判断svn_authfile是否存在用了shell命令,这个windows不支持)


