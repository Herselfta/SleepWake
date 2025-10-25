# 贡献指南

感谢您对 SleepWake 项目的关注！我们欢迎各种形式的贡献。

## 🤝 如何贡献

### 报告问题

如果您发现了bug或有功能建议，请：

1. **检查现有问题**：先查看 [Issues](https://github.com/yourusername/SleepWake/issues) 是否已有类似问题
2. **收集信息**：使用脚本的系统诊断功能（选项6）收集系统信息
3. **创建Issue**：提供详细的问题描述、复现步骤和系统环境

#### Bug报告模板

```markdown
**问题描述**
简要描述遇到的问题

**复现步骤**
1. 运行脚本
2. 选择选项 X
3. 输入 Y
4. 出现错误

**期望行为**
描述您期望的正确行为

**系统环境**
- Windows版本：
- PowerShell版本：
- Docker版本（如果适用）：
- BIOS设置：

**系统诊断信息**
```
[运行选项6的输出结果]
```

**其他信息**
任何其他相关信息
```

### 提交代码

1. **Fork项目**：点击GitHub上的Fork按钮
2. **创建分支**：`git checkout -b feature/your-feature-name`
3. **提交更改**：`git commit -m "Add some feature"`
4. **推送分支**：`git push origin feature/your-feature-name`
5. **创建Pull Request**：在GitHub上创建PR

## 🛠️ 开发环境设置

### 必需工具

- Windows 10/11
- PowerShell 5.1 或更高版本
- Git
- 文本编辑器（推荐VS Code或PowerShell ISE）

### 开发步骤

1. **克隆仓库**
   ```bash
   git clone https://github.com/yourusername/SleepWake.git
   cd SleepWake
   ```

2. **创建开发分支**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **进行开发**
   - 修改 `WakeAfter.ps1` 文件
   - 更新相关文档
   - 测试功能

4. **测试**
   ```powershell
   # 以管理员身份运行PowerShell
   .\WakeAfter.ps1
   ```

## 📝 代码规范

### PowerShell代码规范

- **命名约定**：使用PascalCase命名函数，camelCase命名变量
- **注释**：为复杂逻辑添加注释
- **错误处理**：使用 `-ErrorAction SilentlyContinue` 处理预期错误
- **输出格式**：使用 `Write-Host` 和适当的颜色

### 提交信息规范

使用清晰的提交信息：

```
feat: 添加新功能
fix: 修复bug
docs: 更新文档
style: 代码格式调整
refactor: 代码重构
test: 添加测试
chore: 构建过程或辅助工具的变动
```

示例：
- `feat: 添加重复唤醒任务支持`
- `fix: 修复Docker环境下休眠模式问题`
- `docs: 更新README使用说明`

## 🧪 测试指南

### 功能测试

在提交代码前，请测试以下场景：

1. **基本功能测试**
   - [ ] 分钟级唤醒设置
   - [ ] 小时级唤醒设置
   - [ ] 具体时间唤醒设置
   - [ ] 任务取消功能
   - [ ] 状态查看功能

2. **权限测试**
   - [ ] 普通用户权限（应自动提升）
   - [ ] 管理员权限
   - [ ] UAC禁用情况

3. **环境兼容性测试**
   - [ ] Windows 10
   - [ ] Windows 11
   - [ ] Docker环境
   - [ ] Hyper-V环境

4. **错误处理测试**
   - [ ] 无效时间输入
   - [ ] 权限不足情况
   - [ ] 系统不支持唤醒的情况

### 测试脚本

您可以创建测试脚本来验证功能：

```powershell
# test-basic.ps1
Write-Host "测试基本功能..." -ForegroundColor Green

# 测试分钟设置
Write-Host "测试1分钟后唤醒..."
# [测试代码]

# 测试小时设置
Write-Host "测试1小时后唤醒..."
# [测试代码]

Write-Host "所有测试完成!" -ForegroundColor Green
```

## 📋 Pull Request指南

### PR检查清单

在提交PR前，请确保：

- [ ] 代码遵循项目规范
- [ ] 添加了适当的注释
- [ ] 更新了相关文档
- [ ] 测试了所有功能
- [ ] 没有破坏现有功能
- [ ] 提交信息清晰明确

### PR模板

```markdown
## 变更描述
简要描述此PR的变更内容

## 变更类型
- [ ] Bug修复
- [ ] 新功能
- [ ] 文档更新
- [ ] 代码重构
- [ ] 其他

## 测试
- [ ] 已测试基本功能
- [ ] 已测试错误处理
- [ ] 已测试兼容性

## 相关Issue
关闭 #(issue编号)

## 其他信息
任何其他相关信息
```

## 🏷️ 标签说明

我们使用以下标签来组织Issues和PRs：

- `bug`：bug报告
- `enhancement`：功能建议
- `documentation`：文档相关
- `help wanted`：需要帮助
- `good first issue`：适合新手的任务
- `priority: high`：高优先级
- `priority: medium`：中优先级
- `priority: low`：低优先级

## 📞 获取帮助

如果您在贡献过程中遇到问题：

1. 查看 [Issues](https://github.com/yourusername/SleepWake/issues) 中的讨论
2. 创建新的Issue询问
3. 在Discussions中发起讨论

## 🙏 致谢

感谢所有贡献者的努力！您的贡献让这个项目变得更好。

---

**注意**：请确保您的贡献符合项目的MIT许可证要求。
