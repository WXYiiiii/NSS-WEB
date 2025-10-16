# 简易H5构建方案
# 使用Node.js的http-server直接运行

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  H5即时预览方案  " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 检查Node.js
Write-Host "[1/3] 检查Node.js..." -ForegroundColor Green
$nodeVersion = node --version 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "  ✗ 未检测到Node.js" -ForegroundColor Red
    Write-Host ""
    Write-Host "请安装Node.js：https://nodejs.org/" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "按Enter键退出"
    exit 1
}
Write-Host "  ✓ Node.js版本：$nodeVersion" -ForegroundColor Green
Write-Host ""

# 检查http-server
Write-Host "[2/3] 检查http-server..." -ForegroundColor Green
$httpServer = Get-Command http-server -ErrorAction SilentlyContinue
if ($null -eq $httpServer) {
    Write-Host "  ✗ 未安装http-server" -ForegroundColor Yellow
    Write-Host "  正在安装..." -ForegroundColor Yellow
    npm install -g http-server
    Write-Host "  ✓ 安装完成" -ForegroundColor Green
} else {
    Write-Host "  ✓ http-server已安装" -ForegroundColor Green
}
Write-Host ""

# 启动服务器
Write-Host "[3/3] 启动H5服务器..." -ForegroundColor Green
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "服务器已启动！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "访问地址：http://localhost:8081/h5/index.html" -ForegroundColor Cyan
Write-Host ""
Write-Host "注意事项：" -ForegroundColor Yellow
Write-Host "1. 确保Spring Boot后端正在运行（端口8080）" -ForegroundColor White
Write-Host "2. 这会直接访问已编译的H5文件" -ForegroundColor White
Write-Host "3. 按Ctrl+C停止服务器" -ForegroundColor White
Write-Host ""

Set-Location "D:\wwei\NSS-WEB\src\main\resources\front\front"
http-server -p 8081 --cors

