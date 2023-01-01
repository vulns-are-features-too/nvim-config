local o = vim.o
local os = vim.loop.os_uname().sysname

if os == 'Windows' or os == 'Windows_NT' then
  o.shell = 'powershell'
  o.shellcmdflag =
    '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
  o.shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
  o.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  o.shellquote = ''
  o.shellxquote = ''
end
