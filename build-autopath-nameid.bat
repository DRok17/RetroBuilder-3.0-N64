:MENU
@ECHO OFF
mode 50,12
ECHO                 RETROBUILDER 3.0
ECHO.
ECHO ..................................................
ECHO.
@echo off
IF EXIST .\contents\rom-name.txt (
    @echo off
    set "BOM=EF BB BF"
    type ".\contents\rom-name.txt" | clip
    GOTO BUBNAME
  ) ELSE (
    GOTO BUBNAME
  )
:BUBNAME
@set /p title="Bubble Name: "
@echo off
IF EXIST .\contents\rom-id.txt (
    @echo off
    set "BOM=EF BB BF"
    type ".\contents\rom-id.txt" | clip
    GOTO BUBID
  ) ELSE (
    GOTO BUBID
  )
:BUBID
@set /p id="Title ID (9 char MAX [CAPS or #]): "
@echo off
IF EXIST .\contents\rom.txt (
    @echo off
    set "BOM=EF BB BF"
    type ".\contents\rom.txt" | clip
    GOTO BUBPATH
  ) ELSE (
    GOTO BUBPATH
  )
:BUBPATH
GOTO FS
:VPKC
SET "vita=ux0:"
set /p sys=< .\contents\sys-id.txt
set /p defa=< .\contents\1resources\sys\def-rom-path.txt
set /p romp=< .\contents\file2.txt
@echo|set /p="%core%"= "contents/core.txt"
@echo|set /p="%vita%%defa%/%sys%/%romp%"> "contents/rom.txt"
@echo|set /p="%sys%"= "contents/sys-id.txt"
@echo|set /p="%title%"> "contents/rom-name.txt"
@echo|set /p="%id%"> "contents/rom-id.txt
vita-mksfoex -s TITLE_ID=%id% "%title%" param.sfo
vita-pack-vpk -s param.sfo -b eboot.bin "%id%.vpk" -a contents/icon0.png=sce_sys/icon0.png -a contents/bg.png=sce_sys/livearea/contents/bg.png -a contents/startup.png=sce_sys/livearea/contents/startup.png -a contents/template.xml=sce_sys/livearea/contents/template.xml -a contents/core.txt=core.txt -a contents/rom.txt=rom.txt
GOTO CLNUP

:VPKCN64
SET "vita=ux0:"
set /p sys=< .\contents\sys-id.txt
set /p defa=< .\contents\1resources\sys\def-rom-path.txt
set /p romp=< .\contents\file2.txt
@echo|set /p="%core%"= "contents/core.txt"
@echo|set /p="%vita%%defa%/%sys%/%romp%"> "contents/rom.txt"
@echo|set /p="%sys%"= "contents/sys-id.txt"
@echo|set /p="%title%"> "contents/rom-name.txt"
@echo|set /p="%id%"> "contents/rom-id.txt
vita-mksfoex -s TITLE_ID=%id% "%title%" param.sfo
vita-pack-vpk -s param.sfo -b eboot.bin "%id%.vpk" -a contents/icon0.png=sce_sys/icon0.png -a contents/bg.png=sce_sys/livearea/contents/bg.png -a contents/startup.png=sce_sys/livearea/contents/startup.png -a contents/template.xml=sce_sys/livearea/contents/template.xml -a contents/rom.txt=args.txt
GOTO CLNUP

:CLNUP
del ".\contents\package\*.vpk*"
copy ".\*.vpk*" ".\contents\package"
move ".\*.vpk*" ".\VPK"
copy ".\contents\*.png*" ".\contents\package"
copy ".\contents\rom.txt" ".\contents\package"
copy ".\contents\rom-name.txt" ".\contents\package"
copy ".\contents\rom-id.txt" ".\contents\package"
copy ".\contents\sys-id.txt" ".\contents\package"
for %%i in (.\contents\*.txt*) do if not "%%i"==".\contents\core.txt" if not "%%i"==".\contents\rom.txt" if not "%%i"==".\contents\rom-id.txt" if not "%%i"==".\contents\rom-name.txt" if not "%%i"==".\contents\sys-id.txt" del /q "%%i"
del .\contents\input\0splitter\nes-fileslist.txt
cd ".\contents\1batch"
start zzz-EbootInput-RA.bat

exit

:CON

@ECHO OFF
findstr /I /R [a-z]*\.gbc  .\contents\file2.txt>NUL
IF ERRORLEVEL 1 (GOTO SGBA) ELSE (GOTO GB)
GOTO :EOF

:SGBA
@ECHO OFF
findstr /I /R [a-z]*\.gba  .\contents\file2.txt>NUL
IF ERRORLEVEL 1 (GOTO SGB) ELSE (GOTO GBA)
GOTO :EOF

:SGB
@ECHO OFF
findstr /I /R [a-z]*\.gb  .\contents\file2.txt>NUL
IF ERRORLEVEL 1 (GOTO SGEN) ELSE (GOTO GB)
GOTO :EOF

:SGEN
@ECHO OFF
findstr /I /R [a-z]*\.gen  .\contents\file2.txt>NUL
IF ERRORLEVEL 1 (GOTO BIN) ELSE (GOTO GEN)
GOTO :EOF

:BIN
@ECHO OFF
findstr /I /R [a-z]*\.bin  .\contents\file2.txt>NUL
IF ERRORLEVEL 1 (GOTO SMD) ELSE (GOTO GEN)
GOTO :EOF

:SMD
@ECHO OFF
findstr /I /R [a-z]*\.smd  .\contents\file2.txt>NUL
IF ERRORLEVEL 1 (GOTO SGG) ELSE (GOTO GEN)
GOTO :EOF

:SGG
@ECHO OFF
findstr /I /R [a-z]*\.gg  .\contents\file2.txt>NUL
IF ERRORLEVEL 1 (GOTO STNES) ELSE (GOTO GG)
GOTO :EOF

:STNES
@ECHO OFF
findstr /I /R [a-z]*\.nes  .\contents\file2.txt>NUL
IF ERRORLEVEL 1 (GOTO STSNES) ELSE (GOTO NES)
GOTO :EOF

:STSNES
@ECHO OFF
findstr /I /R [a-z]*\.smc  .\contents\file2.txt>NUL
IF ERRORLEVEL 1 (GOTO SFAM) ELSE (GOTO SNES)
GOTO :EOF

:SFAM
@ECHO OFF
findstr /I /R [a-z]*\.sfc  .\contents\rom.txt>NUL
IF ERRORLEVEL 1 (GOTO SN64) ELSE (GOTO SNES)
GOTO :EOF

:SN64
@ECHO OFF
findstr /I /R [a-z]*\.n64  .\contents\rom.txt>NUL
IF ERRORLEVEL 1 (GOTO SZ64) ELSE (GOTO N64)
GOTO :EOF

:SZ64
@ECHO OFF
findstr /I /R [a-z]*\.z64  .\contents\rom.txt>NUL
IF ERRORLEVEL 1 (GOTO SV64) ELSE (GOTO N64)
GOTO :EOF

:SV64
@ECHO OFF
findstr /I /R [a-z]*\.v64  .\contents\rom.txt>NUL
IF ERRORLEVEL 1 (GOTO TMOUT) ELSE (GOTO N64)
GOTO :EOF


:GB
(echo GB) > ".\contents\sys-id.txt"
@echo OFF
cd ".\contents\1batch\"
start zz-Core-GB-OUT.bat
@echo off
IF EXIST ..\startup.png (
    cd "..\.."
    GOTO TMOUT
  ) ELSE (
    start zzz-StartupInput-GB.bat
    cd "..\.."
    GOTO TMOUT
  )

:GBA
(echo GBA) > ".\contents\sys-id.txt"
@echo OFF
cd ".\contents\1batch\"
start zz-Core-GBA-OUT.bat
@echo off
IF EXIST ..\startup.png (
    cd "..\.."
    GOTO TMOUT
  ) ELSE (
    start zzz-StartupInput-GBA.bat
    cd "..\.."
    GOTO TMOUT
  )

:GEN
(echo GEN) > ".\contents\sys-id.txt"
@echo OFF
cd ".\contents\1batch\"
start zz-Core-GEN-OUT.bat
@echo off
IF EXIST ..\startup.png (
    cd "..\.."
    GOTO TMOUT
  ) ELSE (
    start zzz-StartupInput-GEN.bat
    cd "..\.."
    GOTO TMOUT
  )

:GG
(echo GG) > ".\contents\sys-id.txt"
@echo OFF
cd ".\contents\1batch\"
start zz-Core-GG-OUT.bat
@echo off
IF EXIST ..\startup.png (
    cd "..\.."
    GOTO TMOUT
  ) ELSE (
    start zzz-StartupInput-GG.bat
    cd "..\.."
    GOTO TMOUT
  )

:NES
(echo NES) > ".\contents\sys-id.txt"
@echo OFF
cd ".\contents\1batch\"
start zz-Core-NES-OUT.bat
@echo off
IF EXIST ..\startup.png (
    cd "..\.."
    GOTO TMOUT
  ) ELSE (
    start zzz-StartupInput-NES.bat
    cd "..\.."
    GOTO TMOUT
  )

:SNES
(echo SNES) > ".\contents\sys-id.txt"
@echo OFF
cd ".\contents\1batch\"
start zz-Core-SNES-OUT.bat
@echo off
IF EXIST ..\startup.png (
    cd "..\.."
    GOTO TMOUT
  ) ELSE (
    start zzz-StartupInput-SNES.bat
    cd "..\.."
    GOTO TMOUT
  )

:N64
(echo N64) > ".\contents\sys-id.txt"
@echo OFF
cd ".\contents\1batch\"
@echo off
IF EXIST ..\startup.png (
    GOTO EBOOTN64
  ) ELSE (
    start zzz-StartupInput-N64.bat
    GOTO EBOOTN64
  )

:EBOOTN64
start zzz-EbootInput-N64.bat
GOTO PRTIME2

:PRTIME
cd "..\.."
GOTO TMOUT

:PRTIME2
cd "..\.."
GOTO TMOUT3

:FS
@echo off

cd ".\contents\1batch\"

wscript.exe "zinviz.vbs" "zzz-RomFileSplitter.bat"

cd "..\.."

GOTO TMOUT2


:TMOUT
@ECHO OFF
mode 50,12
ECHO                  RETROBUILDER 3.0
ECHO.
ECHO ..................................................
ECHO.
ECHO.
ECHO.
ECHO                    PLEASE WAIT
ECHO.
ECHO.
ECHO.
ECHO.
timeout 5 >nul
GOTO VPKC

:TMOUT2
@ECHO OFF
mode 50,12
ECHO                  RETROBUILDER 3.0
ECHO.
ECHO ..................................................
ECHO.
ECHO.
ECHO.
ECHO                    PLEASE WAIT
ECHO.
ECHO.
ECHO.
ECHO.
timeout 5 >nul
GOTO CON

:TMOUT3
@ECHO OFF
mode 50,12
ECHO                  RETROBUILDER 3.0
ECHO.
ECHO ..................................................
ECHO.
ECHO.
ECHO.
ECHO                    PLEASE WAIT
ECHO.
ECHO.
ECHO.
ECHO.
timeout 5 >nul
GOTO VPKCN64
