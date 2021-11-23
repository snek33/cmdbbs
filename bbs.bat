@echo off
goto login

:login
cls
echo Log in or just type anon as username to browse anonymously.
set /p username=Username:
if %username% == anon goto amenu
cls
echo Login
set /p password=Password:
cls
if exist ".\users\%username%.usr" goto passwordc

:passwordc
cls
set /p password_file=<".\users\%username%.usr"
if %password_file%==%password% goto menu

:menu
cls
echo Logged in as %username%
echo.
echo (C)reate subreddit
echo (B)rowse subreddit
echo (P)ost into a subreddit
echo (S)earch for a specific post
echo (E)xit
set /p command=
if %command% == c goto create
if %command% == b goto browse
if %command% == p goto post
if %command% == s goto search
if %command% == e goto exit

:amenu
cls
echo Logged in as anonymous
echo.
echo (B)rowse subreddit
echo (S)earch for a specific post
echo (E)xit
set /p command=
if %command% == b goto browse
if %command% == s goto search2
if %command% == e goto exit


:create
cls
echo Select a name for your subreddit
set /p subname=Name:
set /p description=Enter some information about your subreddit: 
md ".\r\%subname%"
echo %description% >>".\r\%subname%\subinfo.desc"
echo. >>".\r\%subname%\subinfo.desc"
echo Created by u/%username% >>".\r\%subname%\subinfo.desc"
cls
echo Subreddit Created!
pause >nul
goto menu

:browse
cls
echo List of subreddits
echo.
dir ".\r\" /a /b
echo.
set /p bchoice=Select a subreddit: 

if %username% == anon goto browse3
goto browse2

:browse2
cls
echo Currently browsing r/%bchoice%
type ".\r\%bchoice%\*.post"
echo.
echo.
echo (V)iew the description of this subreddit
echo (A)dd a comment to a post
echo (R)eturn to the menu
set /p returning=Choose: 
if %returning% == v goto descr
if %returning% == a goto comment
if %returning% == r goto menu

:browse3
cls
echo Currently browsing r/%bchoice%
type ".\r\%bchoice%\*.post"
echo.
echo (V)iew the description of this subreddit
echo (R)eturn to the menu
set /p returning=Choose: 
if %returning% == v goto descr2
if %returning% == r goto amenu

:descr
cls
echo Viewing the description of \r\%bchoice%
echo.
type ".\r\%bchoice%\subinfo.desc"
echo.
pause >nul
goto browse2

:descr2
cls
echo Viewing the description of \r\%bchoice%
echo.
type ".\r\%bchoice%\subinfo.desc"
echo.
pause >nul
goto browse3

:comment
cls
set /p edress=Enter the post title: 
set /p comment=Enter your comment: 
echo. >>".\r\%bchoice%\%edress%.post"
echo %comment% >>".\r\%bchoice%\%edress%.post"
echo Posted by u/%username% >>".\r\%bchoice%\%edress%.post"
goto browse2

:post
cls
set /p title=Set a title for your post: 
set /p post=Enter the contents of your post: 
set /p sub=Enter the subreddit you desire to post: 
echo %title%, Posted by u/%username% >>".\r\%sub%\%title%.post"
echo %date% >>".\r\%sub%\%title%.post"
echo. >>".\r\%sub%\%title%.post"
echo %post% >>".\r\%sub%\%title%.post"
echo.
echo Post Created!
pause >nul
goto menu

:search
cls 
set /p adress=Enter post adress: 
echo.
type "%adress%.post"
pause >nul
goto menu

:search2
cls 
set /p adress=Enter post adress: 
echo.
type "%adress%.post"
pause >nul
goto amenu

:exit
exit