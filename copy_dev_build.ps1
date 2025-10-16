# 从开发模式复制H5文件的脚本
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  从开发模式部署H5  " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$projectRoot = "D:\wwei\NSS-WEB"
$frontRoot = "$projectRoot\src\main\resources\front\front"

# 可能的开发编译路径
$devPaths = @(
    "$frontRoot\unpackage\dist\dev\mp-weixin",
    "$frontRoot\unpackage\dist\dev\h5",
    "$frontRoot\.hbuilderx\launch",
    "$frontRoot\unpackage\dist\build\h5"
)

Write-Host "正在查找开发模式编译的文件..." -ForegroundColor Yellow

$foundPath = $null
foreach ($path in $devPaths) {
    if (Test-Path $path) {
        Write-Host "  找到：$path" -ForegroundColor Green
        $foundPath = $path
        break
    }
}

if ($null -eq $foundPath) {
    Write-Host ""
    Write-Host "[错误] 未找到开发编译文件！" -ForegroundColor Red
    Write-Host ""
    Write-Host "请先在HBuilderX中运行：" -ForegroundColor Yellow
    Write-Host "  运行 > 运行到浏览器 > Chrome" -ForegroundColor White
    Write-Host ""
    Read-Host "按Enter键退出"
    exit 1
}

# 检查是否是H5编译文件
$h5Dest = "$frontRoot\h5"

Write-Host ""
Write-Host "提示：开发模式的文件可能不完整" -ForegroundColor Yellow
Write-Host "建议使用以下方式查看效果：" -ForegroundColor Yellow
Write-Host "  1. 在HBuilderX中：运行 > 运行到浏览器 > Chrome" -ForegroundColor White
Write-Host "  2. 确保Spring Boot后端正在运行（端口8080）" -ForegroundColor White
Write-Host "  3. 在打开的浏览器中直接查看效果" -ForegroundColor White
Write-Host ""
Write-Host "开发模式的优势：" -ForegroundColor Cyan
Write-Host "  ✓ 实时预览，修改代码立即生效" -ForegroundColor Green
Write-Host "  ✓ 无需AppID验证" -ForegroundColor Green
Write-Host "  ✓ 方便调试" -ForegroundColor Green
Write-Host ""
Read-Host "按Enter键退出"

