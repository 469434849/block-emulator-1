@echo off
setlocal enabledelayedexpansion

rem 定义总的等待时间，单位为分钟
set INTERVAL=30

rem 计算总秒数
set /A secondsInterval=%INTERVAL% * 60

rem 生成并执行脚本的函数
:generateAndExecute
set /A currentScriptNum=10
:loop
if !currentScriptNum! leq 16 (
   set "scriptName=D:\code\blockchain\block-emulator\bat_shardNum=!currentScriptNum!_NodeNum=4_mod=CLPA_useWeight=false.bat"
   if exist "!scriptName!" (
       call "!scriptName!"
       echo Script !scriptName! executed at %date% %time%
   ) else (
       echo Warning: Script !scriptName! not found.
   )

    set /A currentScriptNum+=2
    timeout /t 600 /nobreak
    goto :loop
)

endlocal
pause
