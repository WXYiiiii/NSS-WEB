# H5编译后部署脚本
# 使用说明：在HBuilderX中编译完H5后，运行此脚本部署文件

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  H5前端部署脚本  " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$projectRoot = "D:\wwei\NSS-WEB"
$frontRoot = "$projectRoot\src\main\resources\front\front"
$h5Source = "$frontRoot\unpackage\dist\build\h5"
$h5Dest = "$frontRoot\h5"
$h5DestTarget = "$projectRoot\target\classes\front\front\h5"

# 检查源文件是否存在
if (-Not (Test-Path $h5Source)) {
    Write-Host "[错误] 未找到编译后的H5文件！" -ForegroundColor Red
    Write-Host "请先在HBuilderX中编译H5：发行 > 网站-H5手机版" -ForegroundColor Yellow
    Write-Host "编译路径：$h5Source" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "按任意键退出"
    exit 1
}

Write-Host "[1/4] 检查编译文件..." -ForegroundColor Green
Write-Host "  源路径：$h5Source" -ForegroundColor Gray
Write-Host "  ✓ 编译文件存在" -ForegroundColor Green
Write-Host ""

# 备份现有H5文件
if (Test-Path $h5Dest) {
    Write-Host "[2/4] 备份现有H5文件..." -ForegroundColor Green
    $backupName = "h5_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
    $backupPath = "$frontRoot\$backupName"
    Rename-Item -Path $h5Dest -NewName $backupName
    Write-Host "  备份到：$backupPath" -ForegroundColor Gray
    Write-Host "  ✓ 备份完成" -ForegroundColor Green
} else {
    Write-Host "[2/4] 跳过备份（目标目录不存在）" -ForegroundColor Yellow
}
Write-Host ""

# 复制新编译的H5文件到resources目录
Write-Host "[3/4] 部署H5文件到resources目录..." -ForegroundColor Green
Copy-Item -Path $h5Source -Destination $h5Dest -Recurse -Force
Write-Host "  目标：$h5Dest" -ForegroundColor Gray
Write-Host "  ✓ 部署完成" -ForegroundColor Green
Write-Host ""

# 复制到target/classes目录（Spring Boot运行时读取的目录）
Write-Host "[4/4] 同步到target/classes目录..." -ForegroundColor Green
if (Test-Path $h5DestTarget) {
    Remove-Item -Path $h5DestTarget -Recurse -Force
}
Copy-Item -Path $h5Dest -Destination $h5DestTarget -Recurse -Force
Write-Host "  目标：$h5DestTarget" -ForegroundColor Gray
Write-Host "  ✓ 同步完成" -ForegroundColor Green
Write-Host ""

Write-Host "========================================" -ForegroundColor Green
Write-Host "  部署完成！  " -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "接下来的步骤：" -ForegroundColor Cyan
Write-Host "1. 重启 SpringbootSchemaApplication.java" -ForegroundColor White
Write-Host "2. 访问：http://localhost:8080/springbootsme07/front/h5/index.html#/pages/index/index" -ForegroundColor White
Write-Host ""
Write-Host "您应该能看到新增的'知识讲解视频'模块（在'科普知识推荐'下方）" -ForegroundColor Yellow
Write-Host ""
Read-Host "按Enter键退出"

