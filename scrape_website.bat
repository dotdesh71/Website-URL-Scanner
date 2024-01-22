@echo off
setlocal enabledelayedexpansion

REM Prompt the user for the domain name
set /p domain="Enter the domain name (e.g., example.com): "

REM Set the URL and output file
set "url=https://%domain%"
set "output_file=output.txt"

REM Define loading animation characters and colors
set "chars=\|/-"
set "colors=0 1 2 3 4 5 6 7 8 9 A B C D E F"

REM Display a loading animation
echo Scanning website for URLs, please wait...
for /L %%i in (1,1,20) do (
    set /a "index=%%i %% 4"
    for %%c in (%colors%) do (
        set /a "color=%%c"
        echo|set /p="!chars:~%index%,1!!chars:~%index%,1!" <nul
        ping localhost -n 1 >nul
        echo -n -e "\e[1;%dm" !color!
        echo -n -e "\e[0m"
        cls
        echo Scanning website for URLs, please wait...
    )
)

REM Use powershell to fetch the HTML content and extract URLs
powershell -Command "(Invoke-WebRequest -Uri '%url%').Links.Href | Out-File -FilePath '%output_file%' -Encoding utf8"

REM Clear the screen and display a completion message
cls
echo.
echo URLs extracted and saved to %output_file%
echo.
echo Press any key to exit...
pause >nul
