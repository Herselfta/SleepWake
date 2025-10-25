# ========================================
# SleepWake 安装脚本
# 自动配置环境和检查依赖
# ========================================

param(
    [switch]$SkipChecks,
    [switch]$Force,
    [string]$InstallPath = "C:\SleepWake"
)

$ErrorActionPreference = "Stop"

# 颜色输出函数
function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

# 检查管理员权限
function Test-Administrator {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# 检查系统要求
function Test-SystemRequirements {
    Write-ColorOutput "`n=== 检查系统要求 ===" -Color Cyan
    
    # 检查Windows版本
    $osVersion = [System.Environment]::OSVersion.Version
    if ($osVersion.Major -lt 10) {
        Write-ColorOutput "❌ 不支持的操作系统版本。需要Windows 10或更高版本。" -Color Red
        return $false
    }
    Write-ColorOutput "✅ Windows版本: $($osVersion.Major).$($osVersion.Minor)" -Color Green
    
    # 检查PowerShell版本
    $psVersion = $PSVersionTable.PSVersion
    if ($psVersion.Major -lt 5) {
        Write-ColorOutput "❌ PowerShell版本过低。需要PowerShell 5.1或更高版本。" -Color Red
        return $false
    }
    Write-ColorOutput "✅ PowerShell版本: $($psVersion.ToString())" -Color Green
    
    # 检查管理员权限
    if (-not (Test-Administrator)) {
        Write-ColorOutput "❌ 需要管理员权限才能运行此脚本。" -Color Red
        Write-ColorOutput "请右键以管理员身份运行PowerShell。" -Color Yellow
        return $false
    }
    Write-ColorOutput "✅ 管理员权限: 已获取" -Color Green
    
    return $true
}

# 检查唤醒支持
function Test-WakeSupport {
    Write-ColorOutput "`n=== 检查唤醒支持 ===" -Color Cyan
    
    try {
        # 检查支持的睡眠状态
        $sleepStates = powercfg /a 2>$null
        if ($sleepStates -match "待机.*启用") {
            Write-ColorOutput "✅ 睡眠模式: 支持" -Color Green
        } else {
            Write-ColorOutput "⚠️  睡眠模式: 可能不支持" -Color Yellow
        }
        
        if ($sleepStates -match "休眠.*启用") {
            Write-ColorOutput "✅ 休眠模式: 支持" -Color Green
        } else {
            Write-ColorOutput "⚠️  休眠模式: 可能不支持" -Color Yellow
        }
        
        # 检查唤醒定时器
        $wakeTimers = powercfg /waketimers 2>$null
        if ($wakeTimers) {
            Write-ColorOutput "✅ 唤醒定时器: 支持" -Color Green
        } else {
            Write-ColorOutput "⚠️  唤醒定时器: 未检测到" -Color Yellow
        }
        
        return $true
    } catch {
        Write-ColorOutput "⚠️  无法检查唤醒支持状态" -Color Yellow
        return $true
    }
}

# 安装脚本文件
function Install-ScriptFiles {
    param([string]$TargetPath)
    
    Write-ColorOutput "`n=== 安装脚本文件 ===" -Color Cyan
    
    # 创建目标目录
    if (-not (Test-Path $TargetPath)) {
        New-Item -ItemType Directory -Path $TargetPath -Force | Out-Null
        Write-ColorOutput "✅ 创建目录: $TargetPath" -Color Green
    }
    
    # 复制脚本文件
    $scriptPath = Join-Path $PSScriptRoot "WakeAfter.ps1"
    $targetScript = Join-Path $TargetPath "WakeAfter.ps1"
    
    if (Test-Path $scriptPath) {
        Copy-Item $scriptPath $targetScript -Force
        Write-ColorOutput "✅ 安装主脚本: WakeAfter.ps1" -Color Green
    } else {
        Write-ColorOutput "❌ 找不到主脚本文件" -Color Red
        return $false
    }
    
    # 复制其他文件
    $filesToCopy = @("README.md", "LICENSE", "CHANGELOG.md", "CONTRIBUTING.md")
    foreach ($file in $filesToCopy) {
        $sourceFile = Join-Path $PSScriptRoot $file
        $targetFile = Join-Path $TargetPath $file
        if (Test-Path $sourceFile) {
            Copy-Item $sourceFile $targetFile -Force
            Write-ColorOutput "✅ 安装文件: $file" -Color Green
        }
    }
    
    return $true
}

# 创建桌面快捷方式
function New-DesktopShortcut {
    param([string]$ScriptPath)
    
    Write-ColorOutput "`n=== 创建快捷方式 ===" -Color Cyan
    
    try {
        $WshShell = New-Object -comObject WScript.Shell
        $Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\SleepWake.lnk")
        $Shortcut.TargetPath = "powershell.exe"
        $Shortcut.Arguments = "-NoProfile -ExecutionPolicy Bypass -WindowStyle Normal -File `"$ScriptPath`""
        $Shortcut.WorkingDirectory = Split-Path $ScriptPath
        $Shortcut.Description = "SleepWake - 定时唤醒脚本"
        $Shortcut.Save()
        
        Write-ColorOutput "✅ 桌面快捷方式已创建" -Color Green
    } catch {
        Write-ColorOutput "⚠️  无法创建桌面快捷方式: $($_.Exception.Message)" -Color Yellow
    }
}

# 创建开始菜单快捷方式
function New-StartMenuShortcut {
    param([string]$ScriptPath)
    
    try {
        $startMenuPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"
        $WshShell = New-Object -comObject WScript.Shell
        $Shortcut = $WshShell.CreateShortcut("$startMenuPath\SleepWake.lnk")
        $Shortcut.TargetPath = "powershell.exe"
        $Shortcut.Arguments = "-NoProfile -ExecutionPolicy Bypass -WindowStyle Normal -File `"$ScriptPath`""
        $Shortcut.WorkingDirectory = Split-Path $ScriptPath
        $Shortcut.Description = "SleepWake - 定时唤醒脚本"
        $Shortcut.Save()
        
        Write-ColorOutput "✅ 开始菜单快捷方式已创建" -Color Green
    } catch {
        Write-ColorOutput "⚠️  无法创建开始菜单快捷方式: $($_.Exception.Message)" -Color Yellow
    }
}

# 主安装流程
function Start-Installation {
    Write-ColorOutput "======================================" -Color Cyan
    Write-ColorOutput "      SleepWake 安装程序" -Color Green
    Write-ColorOutput "======================================" -Color Cyan
    
    # 检查系统要求
    if (-not $SkipChecks) {
        if (-not (Test-SystemRequirements)) {
            Write-ColorOutput "`n❌ 系统要求检查失败，安装终止。" -Color Red
            exit 1
        }
        
        if (-not (Test-WakeSupport)) {
            Write-ColorOutput "`n⚠️  唤醒支持检查失败，但可以继续安装。" -Color Yellow
            $continue = Read-Host "是否继续安装？(Y/N)"
            if ($continue -ne 'Y' -and $continue -ne 'y') {
                Write-ColorOutput "安装已取消。" -Color Gray
                exit 0
            }
        }
    }
    
    # 确认安装路径
    if (-not $Force) {
        Write-ColorOutput "`n安装路径: $InstallPath" -Color Cyan
        $confirm = Read-Host "确认安装到此路径？(Y/N)"
        if ($confirm -ne 'Y' -and $confirm -ne 'y') {
            Write-ColorOutput "安装已取消。" -Color Gray
            exit 0
        }
    }
    
    # 安装文件
    if (-not (Install-ScriptFiles $InstallPath)) {
        Write-ColorOutput "`n❌ 文件安装失败，安装终止。" -Color Red
        exit 1
    }
    
    # 创建快捷方式
    $scriptPath = Join-Path $InstallPath "WakeAfter.ps1"
    New-DesktopShortcut $scriptPath
    New-StartMenuShortcut $scriptPath
    
    # 安装完成
    Write-ColorOutput "`n======================================" -Color Cyan
    Write-ColorOutput "      安装完成！" -Color Green
    Write-ColorOutput "======================================" -Color Cyan
    Write-ColorOutput "`n安装位置: $InstallPath" -Color White
    Write-ColorOutput "主脚本: WakeAfter.ps1" -Color White
    Write-ColorOutput "`n使用方法:" -Color Yellow
    Write-ColorOutput "1. 双击桌面快捷方式" -Color White
    Write-ColorOutput "2. 或在开始菜单中找到 SleepWake" -Color White
    Write-ColorOutput "3. 或直接运行: $scriptPath" -Color White
    Write-ColorOutput "`n首次运行需要管理员权限。" -Color Yellow
}

# 运行安装
Start-Installation
