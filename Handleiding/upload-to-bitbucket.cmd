:: inspired by: https://bitbucket.org/Swyter/bitbucket-curl-upload-to-repo-downloads
@echo off && setlocal

if "%1"=="" goto :bad
if "%2"=="" goto :bad
if "%3"=="" goto :bad
if "%4"=="" goto :bad

:start
	set usr=%1
	::read passwd with Python
	echo import getpass>hide.py
	echo print(getpass.getpass()) >>hide.py
	for /f "delims=" %%i in ('python hide.py') do set pwd=%%i
	del hide.py
	::without Python you can use
	::set /P pwd=Enter password (will be visible): 
	echo import getpass\nprint(getpass.getpass())>hide.py
	set /p password=Enter password: <nul
	for /f "tokens=*" %%i in ('hide.com') do set pwd=%%i
	del hide.com
	set pge=%2
	set fil1=%3
	set fil2=%4
	
	:: works like this: GET /account/signin/ -> POST /account/signin/ -> auto-redir to downloads page -> POST downloads page
	
	:: GET initial csrf, dropped in the cookie, final 32 chars of the line containing that word
	:: [i] note: you can add the "-v" parameter to any cURL command to get a detailed/verbose output, useful to diagnose problems.
	echo getting initial csrf token from the sign-in page:
	C:\curl-7.47.1-win64-mingw\bin\curl.exe -k -c cookies.txt --progress-bar -o temp.txt https://bitbucket.org/account/signin/
	
	for /f "tokens=7 delims=	" %%A in ('type cookies.txt ^| C:\Windows\System32\find.exe "csrf"') do set csrf=%%A
	
	:: and login using POST, to get the final session cookies, then redirect it to the right page
	echo signing in with the credentials provided:
	C:\curl-7.47.1-win64-mingw\bin\curl.exe -k -c cookies.txt -b cookies.txt --progress-bar -o temp.txt -d "username=%usr%&password=%pwd%&submit=&next=%pge%&csrfmiddlewaretoken=%csrf%" --referer "https://bitbucket.org/account/signin/" -L https://bitbucket.org/account/signin/
	
	for /f "tokens=7 delims=	" %%A in ('type cookies.txt ^| C:\Windows\System32\find.exe "csrf"') do set csrf=%%A
	
	:: check that we have the session cookie, if not, something bad happened, don't spend time uploading.
	set session_cookie=
	for /f "tokens=6 delims=	" %%A in ('type cookies.txt ^| C:\Windows\System32\find.exe "bb_session"') do set session_cookie=%%A
	if "%session_cookie%"=="" goto :notloggedin
	
	:: now that we're logged-in and at the right page, upload whatever you want to your repository...
	echo actual upload progress should appear right now as a progress bar, be patient:
	C:\curl-7.47.1-win64-mingw\bin\curl.exe -k -c cookies.txt -b cookies.txt --progress-bar -o temp.txt --referer "https://bitbucket.org/%pge%" -L --form csrfmiddlewaretoken=%csrf% --form token= --form files=@"%fil1%" https://bitbucket.org/%pge%
	C:\curl-7.47.1-win64-mingw\bin\curl.exe -k -c cookies.txt -b cookies.txt --progress-bar -o temp.txt --referer "https://bitbucket.org/%pge%" -L --form csrfmiddlewaretoken=%csrf% --form token= --form files=@"%fil2%" https://bitbucket.org/%pge%
	
	echo done? maybe. *crosses fingers* signing out, closing session!
	C:\curl-7.47.1-win64-mingw\bin\curl.exe -k -c cookies.txt -b cookies.txt --progress-bar -o temp.txt -L https://bitbucket.org/account/signout/
	
	goto :end
	
:notloggedin
	echo. 
	echo  [!] error: didn't get the session cookie, probably bad credentials or they changed stuff... upload canceled!
	goto :end

:bad
	echo  [!] error: missing arguments :(
	echo. 
	echo  syntax: upload-to-bitbucket.cmd ^<user^> ^<repo downloads page^> ^<local file1 to upload^> ^<local file2 to upload^>
	echo. 

:end
	del cookies.txt
	del temp.txt
