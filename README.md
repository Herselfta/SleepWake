# SleepWake

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Windows](https://img.shields.io/badge/Windows-10%2F11-blue.svg)](https://www.microsoft.com/windows)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-blue.svg)](https://docs.microsoft.com/powershell)
[![Docker](https://img.shields.io/badge/Docker-Optimized-2496ED.svg)](https://www.docker.com/)

一个专为Windows系统设计的智能定时唤醒脚本，支持睡眠和休眠模式的自动唤醒功能。

> 🎯 **专为Win11 + Docker环境优化** | ⚡ **一键安装** | 🔧 **自动权限管理** | 📊 **系统诊断**

## ✨ 功能特性

- 🕐 **多种时间设置方式**：支持分钟、小时或具体时间点唤醒
- 💤 **智能睡眠管理**：支持睡眠和休眠模式，自动优化唤醒可靠性
- 🔧 **自动权限管理**：自动获取管理员权限，无需手动操作
- 🎯 **Docker环境优化**：专为Win11 + Docker环境优化，避免混合睡眠问题
- 📊 **系统诊断功能**：内置诊断工具，帮助排查唤醒问题
- ⚡ **快速启动**：优化的启动流程，减少等待时间

## 🚀 快速开始

### 系统要求

- Windows 10/11
- PowerShell 5.1 或更高版本
- 管理员权限

### 安装使用

#### 方法一：自动安装（推荐）

1. **下载并运行安装脚本**
   ```powershell
   # 右键以管理员身份运行 PowerShell，然后执行：
   .\setup.ps1
   ```

2. **安装完成后**
   - 桌面会创建快捷方式
   - 开始菜单会添加程序项
   - 默认安装到 `C:\SleepWake`

#### 方法二：手动安装

1. **下载脚本**
   ```bash
   git clone https://github.com/yourusername/SleepWake.git
   cd SleepWake
   ```

2. **运行脚本**
   ```powershell
   # 右键以管理员身份运行 PowerShell，然后执行：
   .\WakeAfter.ps1
   ```

### 使用方式

运行脚本后选择唤醒方式：
- 输入 `1`：设置多少分钟后唤醒
- 输入 `2`：设置多少小时后唤醒  
- 输入 `3`：设置具体时间唤醒（如：08:30 或 2025-01-15 08:30）

## 📖 使用示例

### 基本使用

```powershell
# 30分钟后唤醒
选择: 1
输入: 30

# 2小时后唤醒
选择: 2
输入: 2

# 明天早上8:30唤醒
选择: 3
输入: 08:30

# 指定日期时间唤醒
选择: 3
输入: 2025-01-15 08:30
```

### 高级功能

```powershell
# 查看当前任务状态
选择: 5

# 取消唤醒任务
选择: 4

# 系统诊断（检查唤醒支持）
选择: 6
```

## ⚙️ 配置说明

### 睡眠模式选择

脚本提供两种睡眠模式：

1. **睡眠模式**（推荐）
   - ✅ 唤醒最可靠
   - ✅ 支持所有唤醒定时器
   - ✅ 适合Docker/Hyper-V环境

2. **休眠模式**（警告）
   - ⚠️ 可能无法被定时器唤醒
   - ⚠️ Docker/Hyper-V环境限制
   - ⚠️ 需要BIOS RTC Alarm支持

### 自动优化功能

- **唤醒定时器启用**：自动启用系统唤醒定时器
- **任务权限设置**：使用SYSTEM账户运行，确保最高权限
- **唤醒验证**：自动验证唤醒定时器是否生效

## 🔧 故障排除

### 常见问题

**Q: 脚本无法唤醒电脑？**
A: 请检查以下项目：
- BIOS中是否启用了RTC Alarm
- 是否使用了睡眠模式（而非休眠）
- 运行系统诊断（选项6）检查支持状态

**Q: Docker环境下无法唤醒？**
A: Docker/Hyper-V环境不支持混合睡眠，请：
- 使用睡眠模式而非休眠
- 检查BIOS RTC设置
- 避免使用混合睡眠

**Q: 权限不足错误？**
A: 脚本会自动请求管理员权限，如果失败请：
- 手动右键以管理员身份运行PowerShell
- 检查UAC设置

### 系统诊断

使用脚本的系统诊断功能（选项6）可以检查：
- 支持的睡眠状态
- 当前唤醒定时器
- 支持唤醒的设备
- 系统配置建议

## 📋 技术细节

### 核心功能

- **权限管理**：自动检测并获取管理员权限
- **任务调度**：使用Windows任务计划程序创建唤醒任务
- **电源管理**：通过powercfg命令管理电源设置
- **睡眠控制**：使用.NET Framework的SetSuspendState API

### 兼容性

- ✅ Windows 10/11
- ✅ PowerShell 5.1+
- ✅ Docker Desktop
- ✅ Hyper-V环境
- ⚠️ 虚拟机环境（需要额外配置）

## 🤝 贡献指南

欢迎提交Issue和Pull Request！

### 开发环境

1. 克隆仓库
2. 使用PowerShell ISE或VS Code进行开发
3. 测试不同Windows版本和PowerShell版本

### 提交规范

- 使用清晰的提交信息
- 添加适当的注释
- 测试新功能的兼容性

## 📄 许可证

本项目采用 [MIT License](LICENSE) 许可证。

## 🙏 致谢

感谢所有贡献者和用户的反馈！

---

**注意**：使用前请确保了解睡眠和休眠模式的区别，建议在测试环境中先验证唤醒功能。
