保存一下自己写的svn 工具

需要的环境变量:
svn_authfile   存放svn用户密码的文件.用作鉴权
svn_authz_file 存放组信息的文件

支持的系统:
Linux, Mac OS. 
不支持 Windows. (svnpasswd.lua中判断svn_authfile是否存在用了shell命令,这个windows不支持)


