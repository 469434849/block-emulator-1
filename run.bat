REM @echo off

for /L %%s in (4,2,6) do (


    echo Script executed at %date% %time%
    start "testBat" cmd /k test.bat %%s 4 CLPA true
    timeout /t 610 /nobreak
    taskkill /FI "WINDOWTITLE eq testBat" /F
)
echo end
