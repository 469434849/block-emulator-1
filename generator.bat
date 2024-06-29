
@echo off
setlocal enabledelayedexpansion

for /L %%i in (10, 2, 16) do (
    echo Running with -S %%i
    go run main.go -g -S %%i -N 4 -m 1 -w
    go run main.go -g -S %%i -N 4 -m 1
    go run main.go -g -S %%i -N 4 -m 3 -w
    go run main.go -g -S %%i -N 4 -m 3
    echo.
)

endlocal