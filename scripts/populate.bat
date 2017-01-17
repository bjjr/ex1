@echo off
echo #### robgc's populate v0.1####
echo Este script supone que no has cambiado las credenciales del usuario root en la base de datos
echo ADVERTENCIA: Todos los archivos .sql deben permanecer en el escritorio

cd "c:\Program Files\MySQL\MySQL Server 5.5\bin\"

echo Limpiando la base de datos
mysql -uroot -pV3rY=$tR0nG=P@$$w0rd$ < "C:\Documents and Settings\Boss\Desktop\delete.sql"

echo Poblando la base de datos
mysql -uroot -pV3rY=$tR0nG=P@$$w0rd$ < "C:\Documents and Settings\Boss\Desktop\Acme-Pad-Thai.sql"

echo Poblado finalizado
echo Presiona cualquier tecla para salir
pause >nul
