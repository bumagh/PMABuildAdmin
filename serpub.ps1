# deploy.ps1 - uni-app 自动化构建部署脚本
# 修复编码问题和路径问题

param(
    [string]$RemoteDir = "/www/wwwroot/app.tutlab.tech/app/",
    [string]$Server = "root@tutlab.tech",
    [string]$LocalDirPub = "./app/"

)

# 设置控制台编码为UTF-8
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 设置错误处理
$ErrorActionPreference = "Stop"

# 颜色输出函数
function Write-Success {
    param([string]$Message)
    Write-Host "[SUCCESS] $Message" -ForegroundColor Green
}

function Write-ErrorMsg {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

function Write-Info {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor Cyan
}

function Write-Warning {
    param([string]$Message)
    Write-Host "[WARNING] $Message" -ForegroundColor Yellow
}

# 获取正确的构建目录
function Get-BuildPath {
    $possiblePaths = @(
        "./app/"
    )
    
    foreach ($path in $possiblePaths) {
        if (Test-Path $path) {
            Write-Info "找到构建目录: $path"
            return $path
        }
    }
    
    return $null
}


# 构建项目
function Build-Project {
  
    $buildPath = Get-BuildPath
    
    if (-not $buildPath) {
        Write-ErrorMsg "未找到构建产物"
        
        # 尝试查找可能的构建文件
        Write-Info "尝试查找构建文件..."
        Get-ChildItem -Path . -Filter "dist" -Recurse -Directory | ForEach-Object {
            Write-Info "找到目录: $($_.FullName)"
        }
        
        return $null
    }
    
    # 检查构建产物
    $files = Get-ChildItem -Path $buildPath -File
    if ($files.Count -eq 0) {
        Write-Warning "构建目录为空，检查子目录..."
        
        # 检查子目录
        Get-ChildItem -Path $buildPath -Directory | ForEach-Object {
            $subFiles = Get-ChildItem -Path $_.FullName -File
            Write-Info "子目录 $($_.Name) 中有 $($subFiles.Count) 个文件"
        }
    } else {
        Write-Success "构建成功! 生成 $($files.Count) 个文件"

        # 显示主要文件
        Write-Info "主要文件:"
        $files | Select-Object -First 10 | ForEach-Object {
            $size = if ($_.Length -lt 1024) { "$($_.Length) B" }
                    elseif ($_.Length -lt 1048576) { "$([math]::Round($_.Length/1KB, 2)) KB" }
                    else { "$([math]::Round($_.Length/1MB, 2)) MB" }
            Write-Host "  $($_.Name) ($size)" -ForegroundColor Gray
        }
    }
    
    return $buildPath
}

# 部署到服务器
function Deploy-ToServer {
    param(
        [string]$LocalDir,
        [string]$RemoteDir,
        [string]$Server
    )
    
    Write-Info "开始部署到服务器: $Server"
    
    # 检查本地目录
    if (-not (Test-Path $LocalDirPub)) {
        Write-ErrorMsg "本地目录不存在: $LocalDirPub"
        return $false
    }
    
    try {
        # 使用 scp 上传
        Write-Info "正在上传文件..."
        
        # 构建完整的scp命令
        $sourcePath = $LocalDirPub + "*"
        $destination = "${Server}:${RemoteDir}"
        # 先清理远程目录 /www/wwwroot/app.tutlab.tech/public/countdown/assets 下的所有文件

        #Write-Info "清理远程目录: $RemoteDir"
        
        #ssh $Server "rm -rf ${RemoteDir}/*"
        #Write-Host "执行命令: scp -r `"$sourcePath`" `"$destination`"" -ForegroundColor Gray
        
        scp -r "$sourcePath" "$destination"
        
        if ($LASTEXITCODE -ne 0) {
            throw "SCP上传失败 (退出码: $LASTEXITCODE)"
        }
        
        Write-Success "文件上传完成!"
        
        # 验证上传
        Write-Info "验证服务器文件..."
        try {
            ssh $Server "ls -la ${RemoteDir} | head -5"
        }
        catch {
            Write-Warning "无法验证服务器文件，但上传可能已成功"
        }
        
        return $true
    }
    catch {
        Write-ErrorMsg "部署失败: $_"
        Write-Info "解决方案:"
        Write-Host "  1. 确保SSH密钥已配置: ssh-copy-id $Server" -ForegroundColor Gray
        Write-Host "  3. 检查服务器目录权限" -ForegroundColor Gray
        return $false
    }
}

# 主流程
function Main {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Blue
    Write-Host "    uni-app 自动化部署脚本" -ForegroundColor Blue
    Write-Host "========================================" -ForegroundColor Blue
    Write-Host ""
    
   
    # 3. 构建项目（除非跳过）
    $buildPath = $null
    if (-not $SkipBuild) {
        $buildPath = Build-Project
        
        if (-not $buildPath) {
            Write-ErrorMsg "构建失败，退出"
            exit 1
        }
    } else {
        Write-Warning "跳过构建步骤"
        $buildPath = Get-BuildPath
        
        if (-not $buildPath) {
            Write-ErrorMsg "未找到构建目录"
            exit 1
        }
    }
    
    Write-Info "使用构建目录: $buildPath"
    Write-Host "手动部署命令:" -ForegroundColor Yellow
    Write-Host "  scp -r `"$buildPath*`" ${Server}:${RemoteDir}" -ForegroundColor Gray
    
    # 5. 部署到服务器
    if (-not (Deploy-ToServer -LocalDir $buildPath -RemoteDir $RemoteDir -Server $Server)) {
        exit 1
    }
    
    Write-Host ""
    Write-Success "🎉 部署完成!"
    Write-Host ""
}

# 执行主函数
Main