cd %SAMPLES_ASPNET_WEBFORMS_HOME%\e2e-tests
call npm install
call npm run pretest

cd %IIS_EXPRESS_HOME%
call start iisexpress.exe /path:%SAMPLES_ASPNET_WEBFORMS_HOME%\okta-hosted-login\dist\okta-aspnet-webforms-example
cd %SAMPLES_ASPNET_WEBFORMS_HOME%\e2e-tests
call npm run test:okta-hosted-login
if errorlevel 1 (SET error=true)
call TASKKILL /F /IM iisexpress.exe

cd %IIS_EXPRESS_HOME%
call start iisexpress.exe /path:%SAMPLES_ASPNET_WEBFORMS_HOME%\self-hosted-login\dist\okta-aspnet-webforms-example

cd %SAMPLES_ASPNET_WEBFORMS_HOME%\e2e-tests
call npm run test:custom-login
if errorlevel 1 (SET error=true)
call TASKKILL /F /IM iisexpress.exe
IF "%error%"=="true" (
  exit 1
)
