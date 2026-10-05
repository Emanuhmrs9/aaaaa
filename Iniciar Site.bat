@echo off
setlocal
cd /d "%~dp0"
title Shopee Oportunidades

echo ==========================================
echo        SHOPEE OPORTUNIDADES
 echo ==========================================
echo.

where node >nul 2>&1
if errorlevel 1 (
  echo ERRO: Node.js nao foi encontrado.
  echo Instale o Node.js LTS e execute este arquivo novamente.
  pause
  exit /b 1
)

if not exist "node_modules" (
  echo Instalando dependencias pela primeira vez...
  call npm install
  if errorlevel 1 (
    echo ERRO ao instalar dependencias.
    pause
    exit /b 1
  )
)

if not exist ".env" (
  echo.
  echo ERRO: o arquivo .env nao existe.
  echo.
  echo Crie o arquivo .env a partir de .env.example e coloque:
  echo SHOPEE_APP_ID=seu_app_id
  echo SHOPEE_SECRET=seu_secret
  echo.
  pause
  exit /b 1
)

echo.
echo Iniciando servidor real da Shopee Open API...
echo.
start "" "http://localhost:3000"
npm start
pause
