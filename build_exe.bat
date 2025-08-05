@echo off
echo === Criando executavel do Dashboard Holy Foods ===
echo.
rd /s /q build
rd /s /q dist
del dash_holyfoods_inadimplencia.spec
echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --hidden-import=openpyxl --hidden-import=watchdog --hidden-import=datetime launcher.py

echo.
echo Copiando arquivos necessarios...
if not exist "dist\static" mkdir "dist\static"
copy "static\*" "dist\static\"

if not exist "dist\base_dados" mkdir "dist\base_dados"
if exist "base_dados\*" copy "base_dados\*" "dist\base_dados\"

echo.
echo Executavel criado em: dist\dash_holyfoods_inadimplencia.exe
echo.
echo Para usar:
echo 1. Copie o arquivo dash_holyfoods_inadimplencia.exe para onde desejar
echo 2. Execute o arquivo
echo 3. O programa criara a pasta base_dados automaticamente
echo 4. Coloque os arquivos CSV na pasta base_dados
echo.
pause
echo.
echo === Criando executavel do Dashboard Holy Foods ===
echo.

echo Instalando PyInstaller...
pip install pyinstaller

echo.
echo Criando executavel...
pyinstaller --onefile --name "dash_holyfoods_inadimplencia" --icon=NONE --add-data "static;static" --add-data "base_dados;base_dados" --hidden-import=pandas --hidden-import=fastapi --hidden-import=uvicorn --