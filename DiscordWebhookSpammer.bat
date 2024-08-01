@echo off
color 09
title Discord Webhook spammer
echo WEBHOOK SPAMMER
echo github.com/wiced1
setlocal enabledelayedexpansion

set /p webhook=Enter Webhook URL: 
set /p message=Enter message to send: 
set /p username=Enter bot username (default is "Bot"): 
set /p avatar_url=Enter avatar URL (optional): 
set /p num_messages=Enter number of messages to send (default is 1): 

set "username=!username: =!"    REM Remove any spaces from the username

if not defined webhook (
    echo Error: Webhook URL not specified
    goto :EOF
)

if not defined message (
    echo Error: Message not specified
    goto :EOF
)

if not defined username set "username=Bot"
if not defined num_messages set "num_messages=1"

echo Sending %num_messages% messages to webhook %webhook% with message "%message%", username "%username%", and avatar URL "%avatar_url%"...

set /a count=0

set "json={\"username\":\"!username!\",\"content\":\"!message!\"}"
if defined avatar_url set "json={\"username\":\"!username!\",\"avatar_url\":\"!avatar_url!\",\"content\":\"!message!\"}"

for /l %%i in (1,1,%num_messages%) do (
    curl -sSf -H "Content-Type: application/json" -X POST -d !json! -m 10 "%webhook%" > nul 2>&1
    set /a count+=1
)

echo Messages sent: %count%
pause
goto :EOF
