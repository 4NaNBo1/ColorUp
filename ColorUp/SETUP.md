# ColorUp 项目配置指南

## 📋 必需的权限配置

### Info.plist 权限设置

为了让应用能够访问相册选择图片和保存处理后的图片，需要在 Xcode 项目中配置以下权限：

#### 方法一：通过 Xcode 界面配置

1. 在 Xcode 中打开项目
2. 选择项目导航器中的 `ColorUp` 项目
3. 选择 `ColorUp` target
4. 切换到 `Info` 标签页
5. 点击 `+` 按钮添加以下键值对：

| Key | Type | Value |
|-----|------|-------|
| `Privacy - Photo Library Usage Description` | String | 需要访问您的相册以选择图片 |
| `Privacy - Photo Library Additions Usage Description` | String | 需要权限以保存处理后的图片到相册 |

#### 方法二：直接编辑 Info.plist

如果项目中有 `Info.plist` 文件，可以直接添加以下内容：

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>需要访问您的相册以选择图片</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>需要权限以保存处理后的图片到相册</string>
```

#### 方法三：通过 Xcode 项目设置（推荐）

现代 Xcode 项目可能不使用独立的 Info.plist 文件，而是在项目设置中管理：

1. 选择项目 target
2. 在 `Info` 标签页中，找到 `Custom iOS Target Properties`
3. 右键点击空白处，选择 `Add Row`
4. 添加以下两个条目：
   - `Privacy - Photo Library Usage Description`
   - `Privacy - Photo Library Additions Usage Description`

## 🛠️ 开发环境要求

### 必需工具

- **Xcode**: 15.0 或更高版本
- **macOS**: 14.0 (Sonoma) 或更高版本
- **iOS 部署目标**: 17.0 或更高版本

### Swift 版本

- **Swift**: 5.9 或更高版本

## 📦 依赖项

本项目不依赖任何第三方库，完全使用原生 SwiftUI 和 iOS 框架：

- `SwiftUI` - 用户界面框架
- `CoreImage` - 图像处理
- `PhotosUI` - 相册访问
- `UIKit` - 图片操作

## 🏃 运行项目

### 步骤 1: 打开项目

```bash
cd /Users/admin/Documents/Project/ColorUp
open ColorUp.xcodeproj
```

### 步骤 2: 配置签名

1. 在 Xcode 中选择项目 target
2. 切换到 `Signing & Capabilities` 标签页
3. 选择你的开发团队
4. 确保 `Automatically manage signing` 已勾选

### 步骤 3: 选择设备

- **模拟器**: 选择任意 iOS 17.0+ 模拟器
- **真机**: 连接 iPhone/iPad，确保设备系统为 iOS 17.0+

### 步骤 4: 运行

- 按下 `⌘R` 或点击工具栏的运行按钮
- 首次运行时，系统会提示授予照片访问权限

## 🐛 常见问题

### 问题 1: 无法访问相册

**症状**: 点击"选择"按钮没有反应，或应用崩溃

**解决方案**:
1. 检查 Info.plist 中是否正确添加了权限描述
2. 在设置 -> 隐私 -> 照片中，确认应用已获得权限
3. 如果权限被拒绝，需要卸载应用重新安装

### 问题 2: 保存图片失败

**症状**: 点击保存按钮后没有反应

**解决方案**:
1. 检查 `NSPhotoLibraryAddUsageDescription` 权限
2. 确认在设置中授予了"添加照片"权限
3. 检查设备存储空间是否充足

### 问题 3: 图片处理缓慢

**症状**: 选择图片或调整参数时有明显延迟

**解决方案**:
1. 确保运行在真机上，模拟器性能可能不佳
2. 尝试使用较小的图片（建议 < 10MB）
3. 检查是否有其他应用占用大量资源

### 问题 4: 编译错误

**症状**: Xcode 报告编译错误

**解决方案**:
1. 确认 Xcode 版本 >= 15.0
2. 清理构建文件夹: `Product -> Clean Build Folder` (⇧⌘K)
3. 删除 DerivedData: `~/Library/Developer/Xcode/DerivedData/`
4. 重新打开项目

### 问题 5: 预设风格不显示

**症状**: 预设风格列表为空

**解决方案**:
1. 确认 `StylePreset.swift` 文件已正确添加到项目
2. 检查文件是否在正确的 target 中
3. 重新构建项目

## 🎨 自定义配置

### 修改主题色

在 `ContentView.swift` 和其他视图文件中，主题色使用了橙黄渐变：

```swift
LinearGradient(
    colors: [.orange, .yellow],
    startPoint: .leading,
    endPoint: .trailing
)
```

你可以修改为任意颜色组合，例如：

```swift
// 蓝紫渐变
LinearGradient(
    colors: [.blue, .purple],
    startPoint: .leading,
    endPoint: .trailing
)

// 粉红渐变
LinearGradient(
    colors: [.pink, .red],
    startPoint: .leading,
    endPoint: .trailing
)
```

### 添加新的预设风格

在 `StylePreset.swift` 中的 `presets` 数组中添加新的风格：

```swift
StylePreset(
    name: "你的风格名称",
    nameEN: "Your Style Name",
    adjustment: ColorAdjustment(
        hue: 0.0,
        saturation: 1.0,
        brightness: 1.0,
        contrast: 1.0,
        lutIntensity: 1.0,
        exposure: 1.0,
        gamma: 2.2,
        useACES: false
    ),
    category: "自定义"
)
```

### 调整动画效果

所有动画使用 SwiftUI 的 `spring` 动画：

```swift
.animation(.spring(response: 0.3, dampingFraction: 0.7), value: someValue)
```

参数说明：
- `response`: 动画持续时间（秒）
- `dampingFraction`: 阻尼系数（0-1，越小弹性越大）

## 📱 测试建议

### 功能测试清单

- [ ] 选择图片功能正常
- [ ] 所有预设风格可以应用
- [ ] 手动调整滑块响应灵敏
- [ ] 原图对比功能工作正常
- [ ] 保存图片到相册成功
- [ ] 重置功能正常
- [ ] 动画流畅，无卡顿
- [ ] 旋转屏幕布局正常

### 性能测试

- 测试大尺寸图片（> 5MB）处理性能
- 测试快速切换预设时的响应速度
- 测试连续调整滑块时的流畅度
- 测试长时间使用的内存占用

### 兼容性测试

- iOS 17.0 ~ 17.x
- iPhone SE ~ iPhone 15 Pro Max
- iPad 各型号
- 浅色/深色模式
- 不同语言环境

## 🚀 发布准备

### App Store 提交检查清单

- [ ] 应用图标已设计（1024x1024px）
- [ ] 启动屏幕已配置
- [ ] 所有权限描述清晰明了
- [ ] 版本号和构建号已设置
- [ ] 截图已准备（各尺寸设备）
- [ ] App Store 描述已撰写
- [ ] 隐私政策已发布
- [ ] 测试通过所有功能

### 优化建议

1. **性能优化**
   - 实现图片缓存机制
   - 优化大图片处理流程
   - 减少不必要的重绘

2. **用户体验**
   - 添加使用教程/引导
   - 实现撤销/重做功能
   - 支持批量处理

3. **功能扩展**
   - 添加更多预设风格
   - 支持自定义预设保存
   - 集成社交分享功能

## 📞 支持

如有问题，请查看：
- 项目 README.md
- 代码注释
- Apple 官方文档

---

祝你开发顺利！🎉
