@echo off

:start
cls

cd %USERPROFILE%
REM create the venv
C:\Python33\python.exe C:\Python33\Tools\Scripts\pyvenv.py %USERPROFILE%\venv
REM download get-pip.py and distribute_setup.py

powershell.exe -Command (new-object System.Net.WebClient).DownloadFile('https://raw.github.com/pypa/pip/master/contrib/get-pip.py','%USERPROFILE%\get-pip.py')
powershell.exe -Command (new-object System.Net.WebClient).DownloadFile('http://python-distribute.org/distribute_setup.py','%USERPROFILE%\distribute_setup.py') 

REM create idle in Scripts

echo (%USERPROFILE%\venv\Scripts\python -c "from idlelib.PyShell import main; main()" ^& pause) >> %USERPROFILE%\venv\Scripts\idle.bat

REM activate the venv, install distribute, install pip, create IDLE shortcut in desktop, install PILLOW
%USERPROFILE%\venv\Scripts\activate.bat & python distribute_setup.py & python get-pip.py & powershell.exe -Command $shortcut = (New-Object -comObject WScript.Shell).CreateShortcut('%USERPROFILE%\Desktop\idle.lnk'); $shortcut.TargetPath = '%USERPROFILE%\venv\Scripts\idle.bat'; $shortcut.Save() & pip install pillow

REM Now you can use pip install python_package to install your packages
REM to use the IDLE, just open the shortcut in your desktop
REM Enjoy!

py -m venv venv

.\venv\Scripts\python.exe

.\venv\Scripts\pip.exe install -r requirements.txt

pause
exit