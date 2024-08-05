@echo off
REM UTF-8エンコーディングを設定
chcp 65001 >nul
SETLOCAL

REM スクリプトが実行されているディレクトリを取得
SET "SOURCE_DIR=%~dp0"

REM ターゲットディレクトリを設定
SET "HOME_DIR=%USERPROFILE%"
SET "STARTUP_DIR=%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"

REM スクリプトが管理者権限で実行されているかチェック
NET FILE >nul 2>&1
IF NOT %ERRORLEVEL% == 0 (
    ECHO このスクリプトは管理者権限が必要です。
    PAUSE
    EXIT /B
)

REM ホームディレクトリにシンボリックリンクを作成
IF EXIST "%SOURCE_DIR%.ideavimrc" (
    MKLINK "%HOME_DIR%\.ideavimrc" "%SOURCE_DIR%.ideavimrc"
) ELSE (
    ECHO ソースディレクトリに .ideavimrc が見つかりません。
)

IF EXIST "%SOURCE_DIR%_vsvimrc" (
    MKLINK "%HOME_DIR%\_vsvimrc" "%SOURCE_DIR%_vsvimrc"
) ELSE (
    ECHO ソースディレクトリに _vsvimrc が見つかりません。
)

REM スタートアップディレクトリにシンボリックリンクを作成
IF EXIST "%SOURCE_DIR%AHKv2.ahk" (
    MKLINK "%STARTUP_DIR%\AHKv2.ahk" "%SOURCE_DIR%AHKv2.ahk"
) ELSE (
    ECHO ソースディレクトリに AHKv2.ahk が見つかりません。
)

REM 完了メッセージを表示
ECHO シンボリックリンクの作成が完了しました。
PAUSE
ENDLOCAL
EXIT /B
