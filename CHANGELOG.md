# 更新日志

所有重要的项目更改都将记录在此文件中。

格式基于 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)，
并且此项目遵循 [语义化版本](https://semver.org/lang/zh-CN/)。

## [1.0.0] - 2025-01-15

### 新增
- 🎉 初始版本发布
- ✨ 支持多种时间设置方式（分钟、小时、具体时间）
- 🔧 自动管理员权限获取
- 💤 睡眠和休眠模式支持
- 📊 系统诊断功能
- ⚡ 优化的启动流程
- 🎯 Docker/Hyper-V环境优化

### 功能特性
- 支持分钟级精确唤醒（1-999分钟）
- 支持小时级唤醒（支持小数，如1.5小时）
- 支持具体时间点唤醒（HH:mm格式）
- 支持指定日期时间唤醒（yyyy-MM-dd HH:mm格式）
- 自动启用系统唤醒定时器
- 智能睡眠模式选择（睡眠/休眠）
- 唤醒任务状态查看和管理
- 完整的系统诊断工具
- 自动权限提升和错误处理

### 技术实现
- 使用Windows任务计划程序创建唤醒任务
- 通过powercfg命令管理电源设置
- 使用.NET Framework SetSuspendState API控制睡眠
- SYSTEM账户权限确保最高可靠性
- 异步加载优化用户体验

### 兼容性
- ✅ Windows 10/11
- ✅ PowerShell 5.1+
- ✅ Docker Desktop
- ✅ Hyper-V环境
- ⚠️ 虚拟机环境（需要额外配置）

---

## 计划中的功能

### [1.1.0] - 计划中
- 🔄 重复唤醒任务支持
- 📱 移动端通知集成
- 🌐 Web界面支持
- 📈 唤醒历史记录

### [1.2.0] - 计划中
- 🎵 自定义唤醒音效
- 📊 详细的唤醒统计
- 🔔 唤醒前提醒功能
- 🛠️ 更多系统诊断选项

---

## 贡献

欢迎提交Issue和Pull Request来改进这个项目！

### 报告问题
如果您发现任何问题，请：
1. 检查现有的Issue
2. 使用系统诊断功能（选项6）收集信息
3. 提供详细的错误信息和系统环境

### 功能请求
如果您有功能建议，请：
1. 检查计划中的功能列表
2. 详细描述您的需求和使用场景
3. 说明为什么这个功能对您有用

---

## 版本说明

- **主版本号**：不兼容的API修改
- **次版本号**：向下兼容的功能性新增
- **修订号**：向下兼容的问题修正

## 链接

- [GitHub仓库](https://github.com/yourusername/SleepWake)
- [问题报告](https://github.com/yourusername/SleepWake/issues)
- [功能请求](https://github.com/yourusername/SleepWake/issues/new?template=feature_request.md)
