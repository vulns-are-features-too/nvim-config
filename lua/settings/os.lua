local o = vim.o
local os = vim.loop.os_uname().sysname
local executable = vim.fn.executable

if os == 'Windows' or os == 'Windows_NT' then
  -- Native Windows
  if executable('pwsh') then
    o.shell = 'pwsh'
  elseif executable('powershell') then
    o.shell = 'powershell'
  end -- No powershell? Install it. Preferably version 7.X

  o.shellcmdflag =
  '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
  o.shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
  o.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  o.shellquote = ''
  o.shellxquote = ''
elseif os == 'Linux' and vim.fn.isdirectory('/mnt/c/WINDOWS') then
  -- WSL
end
