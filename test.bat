@echo off

setlocal enabledelayedexpansion

set  shardNum=%1
set  nodeNum=%2
set /A shardNumMaxIdx=%shardNum%-1
set /A nodeNumMaxIdx=%nodeNum%-1
set  run_mod=%3
set  useWeight=%4
if /i "%run_mod%"=="CLPA" (
    set "mod=1"
) else if /i "%run_mod%"=="Relay" (
    set "mod=3"
)
echo shardNum = %shardNum%
echo nodeNum = %nodeNum%
echo shardNumMaxIdx = %shardNumMaxIdx%
echo nodeNumMaxIdx = %nodeNumMaxIdx%
echo run_mod = %run_mod%
echo useWeight = %useWeight%
echo mod = %mod%
REM 输出启动所有节点的命令
for /L %%s in (0,1,%shardNumMaxIdx%) do (
    for /L %%n in (1,1,%nodeNumMaxIdx%) do (
        if /i "%useWeight%"=="true" (
            start "Service_s%%s_n%%n" cmd /c go run main.go -n %%n -N %nodeNum% -s %%s -S %shardNum% -m %mod% -w
        ) else (
            start "Service_s%%s_n%%n" cmd /c go run main.go -n %%n -N %nodeNum% -s %%s -S %shardNum% -m %mod%
        )
    )
)

REM 输出启动额外服务的命令
if /i "%useWeight%"=="true" (
    start "Service_c_S%shardNum%_N%nodeNum%" cmd /c go run main.go -c -N %nodeNum% -S %shardNum% -m %mod% -w
) else (
    start "Service_c_S%shardNum%_N%nodeNum%" cmd /c go run main.go -c -N %nodeNum% -S %shardNum% -m %mod%
)

REM 输出再次启动所有节点的命令
for %%n in (0) do (
    for /L %%s in (0,1,%shardNumMaxIdx%) do (
        if /i "%useWeight%"=="true" (
            start "Service_s%%s_n%%n" cmd /c go run main.go -n %%n -N %nodeNum% -s %%s -S %shardNum% -m %mod% -w
         ) else (
            start "Service_s%%s_n%%n" cmd /c go run main.go -n %%n -N %nodeNum% -s %%s -S %shardNum% -m %mod%
         )
    )
)

REM 等待600秒
timeout /t 600

REM 输出关闭所有窗口的命令
for /L %%s in (0,1,%shardNumMaxIdx%) do (
    for /L %%n in (0,1,%nodeNumMaxIdx%) do (
        taskkill /FI "WINDOWTITLE eq Service_s%%s_n%%n" /F
    )
)
taskkill /FI "WINDOWTITLE eq Service_c_S%shardNum%_N%nodeNum%" /F
exit
