@echo off
echo #### robgc's autodump v0.1####
echo Este script supone que no has cambiado las credenciales del usuario root en la base de datos

cd "c:\Program Files\MySQL\MySQL Server 5.5\bin\"
mysqldump -uroot -pV3rY=$tR0nG=P@$$w0rd$ Acme-Pad-Thai > "C:\Documents and Settings\Student\Desktop\dump.sql"

cd "c:\Documents and Settings\Student\Desktop\"
type header.sql > Acme-Pad-Thai.sql
echo. >> Acme-Pad-Thai.sql
echo. >> Acme-Pad-Thai.sql
type dump.sql >> Acme-Pad-Thai.sql
echo commit; >> Acme-Pad-Thai.sql

echo Dump finalizado
echo Presiona cualquier tecla para salir
pause >nul