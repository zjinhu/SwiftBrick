# SwiftBrick AI Skills Reference

> A comprehensive AI reference guide for SwiftBrick iOS UI framework. Use this file to help AI assistants understand and generate code using SwiftBrick APIs.

## Overview / 概述

**SwiftBrick** is a lightweight, feature-rich iOS UI framework for rapidly building app interfaces. It provides base view controllers, reusable cells, UIKit extensions, and utility tools.

**SwiftBrick** 是一个轻量级、功能丰富的 iOS UI 框架，用于快速构建应用界面。提供基础视图控制器、可复用单元格、UIKit 扩展和实用工具。

---

## Quick Start / 快速开始

### Installation / 安装

```swift
// SPM: https://github.com/jackiehu/SwiftBrick
// Cocoapods: pod 'SwiftBrick'
import SwiftBrick
```

### Global Shortcuts / 全局快捷访问

```swift
Define.screenWidth          // Screen width / 屏幕宽度
Define.screenHeight         // Screen height / 屏幕高度
Define.fitWidth             // Width scale factor (based on 375pt) / 宽度缩放系数
Define.fitHeight            // Height scale factor (based on 667pt) / 高度缩放系数
Define.lineHeight           // 1px line width / 1像素线宽
Define.navBarHeight()       // Navigation bar height / 导航栏高度
Define.statusBarHeight()    // Status bar height / 状态栏高度
Define.tabBarHeight         // Tab bar height (includes safe area) / 标签栏高度

Device.isiPhoneX            // Has notch / 是否有刘海
Device.isiPad               // Is iPad / 是否为iPad
Device.systemVersion        // iOS version / iOS版本

APP.appName                 // App name / 应用名称
APP.version                 // App version / 应用版本

Font.systemFont(16)         // System font / 系统字体
Font.systemFontBold(16)     // Bold system font / 粗体系统字体
Font.fontFit                // Auto font scale factor / 自动字体缩放系数

AppState.isDebug            // Is debug build / 是否为调试模式
AppState.state              // .debug / .testFlight / .appStore
```

---

## The `.ss` Accessor Pattern / `.ss` 访问器模式

SwiftBrick uses the `.ss` accessor to add extension methods to UIKit types:

SwiftBrick 使用 `.ss` 访问器为 UIKit 类型添加扩展方法：

```swift
view.ss.setBackColor([.red, .blue])          // Set gradient background / 设置渐变背景
label.ss.makeConstraints { ... }             // Make Auto Layout constraints / 创建约束
tableView.ss.registerCell(MyCell.self)       // Register cell / 注册单元格
cell.ss.addAllLine(tableView:..., indexPath:...) // Add separator lines / 添加分割线
navigationBar.ss.setBackgroundColor(.white)  // Set nav bar background / 设置导航栏背景
vc.ss.hideDefaultBackBarButton()             // Hide back button / 隐藏返回按钮
```

---

## Base View Controllers / 基础视图控制器

### ViewController (Base VC / 基础VC)

```swift
class MyVC: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Background color auto-set from asset / 背景色自动从资源设置
        // Edge swipe back enabled by default / 默认启用边缘滑动返回
    }
    
    // Override to disable swipe back / 重写以禁用滑动返回
    func disableSwipe() { closePopGestureRecognizer() }
    
    // Custom back behavior / 自定义返回行为
    override func goBack() { /* custom */ }
}
```

### TableViewController

```swift
class MyTableVC: TableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Init with style / 用样式初始化
        // let vc = TableViewController(tableViewStyle: .styleGrouped)
        
        tableView?.ss.registerCell(MyCell.self)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ss.dequeueReusableCell(MyCell.self)
        // configure cell / 配置单元格
        return cell
    }
}
```

### CollectionViewController

```swift
class MyCollectionVC: CollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.ss.registerCell(MyCell.self)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.ss.dequeueReusableCell(MyCell.self, indexPath: indexPath)
        return cell
    }
}
```

### WebViewController

```swift
// Basic usage / 基本用法
let webVC = WebViewController(urlString: "https://example.com")

// With cookies / 带Cookie
let webVC = WebViewController(urlString: "https://example.com", cookie: ["token": "abc123"])

// Custom request / 自定义请求
let webVC = WebViewController(request: URLRequest(url: url))
```

### SwiftUIVC (iOS 13+)

```swift
@available(iOS 13.0, *)
let swiftuiVC = SwiftUIVC(MySwiftUIView())
```

---

## Base Cells / 基础单元格

### Custom TableViewCell

```swift
class MyCell: TableViewCell {
    override func setupCellViews() {
        // Add subviews here / 在此添加子视图
        let label = UILabel()
        contentView.addSubview(label)
    }
}

// Register & dequeue / 注册与复用
tableView.ss.registerCell(MyCell.self)
let cell = tableView.ss.dequeueReusableCell(MyCell.self)
```

### Custom CollectionViewCell

```swift
class MyCell: CollectionViewCell {
    override func setupCellViews() {
        // Add subviews here / 在此添加子视图
    }
}

collectionView.ss.registerCell(MyCell.self)
let cell = collectionView.ss.dequeueReusableCell(MyCell.self, indexPath: indexPath)
```

### Header/Footer Views

```swift
// Table header/footer / 表格头/尾
tableView.ss.registerHeaderFooterView(MyHeaderView.self)
let header = tableView.ss.dequeueReusableHeaderFooterView(MyHeaderView.self)

// Collection header/footer / 集合头/尾
collectionView.ss.registerHeaderFooterView(MyReusableView.self, kindType: .sectionHeader)
let header = collectionView.ss.dequeueReusableHeaderFooterView(MyReusableView.self, kindType: .sectionHeader, indexPath: indexPath)
```

---

## Layout Extensions / 布局扩展

### Constraints Maker / 约束构建器

```swift
view.ss.makeConstraints { maker in
    maker.topAnchor(equalTo: view.safeTopAnchor).offset(20)
    maker.leadingAnchor(equalTo: view.safeLeadingAnchor).offset(16)
    maker.trailingAnchor(equalTo: view.safeTrailingAnchor).offset(-16)
    maker.heightAnchor(44)
}

// Remake constraints (remove old, add new) / 重建约束
view.ss.remakeConstraints { maker in
    maker.widthAnchor(100)
    maker.heightAnchor(100)
    maker.centerXAnchor(equalTo: view.superview!.centerXAnchor)
}

// Update constraints / 更新约束
view.ss.updateConstraints { maker in
    maker.heightAnchor(200)
}
```

### Safe Area Anchors / 安全区域锚点

```swift
view.ss.safeTopAnchor       // safeAreaLayoutGuide.topAnchor
view.ss.safeBottomAnchor    // safeAreaLayoutGuide.bottomAnchor
view.ss.safeLeadingAnchor   // safeAreaLayoutGuide.leadingAnchor
view.ss.safeTrailingAnchor  // safeAreaLayoutGuide.trailingAnchor
view.ss.safeWidthAnchor     // safeAreaLayoutGuide.widthAnchor
view.ss.safeHeightAnchor    // safeAreaLayoutGuide.heightAnchor
```

### Adaptive Scaling / 自适应缩放

```swift
CGFloat(30).ss.scaleWidth()   // Scale width based on 375pt reference / 按375pt基准缩放宽度
Int(20).ss.scaleHeight()      // Scale height based on 667pt reference / 按667pt基准缩放高度
```

---

## UI Extensions / UI扩展

### UIView

```swift
// Gradient background / 渐变背景
view.ss.setBackColor([.red, .blue], startPoint: GradientPoint.topLeft.point, endPoint: GradientPoint.bottomRight.point)

// Remove gradients / 移除渐变
view.ss.removeGradients()

// Find parent VC (useful for analytics) / 查找父VC（埋点用）
let vc = view.ss.firstViewController()

// Quick init with builder / 快速初始化构建器
let label = UILabel.inits { label in
    label.text = "Hello"
    label.textColor = .black
}

// Tap gesture with closure / 带闭包的点击手势
view.addTapGestureWithCallback { view in
    print("tapped")
}
```

### UIColor

```swift
// Predefined colors (dark mode supported) / 预定义颜色（支持暗黑模式）
UIColor.baseBlue, .baseRed, .baseGreen, .baseOrange, .basePurple
UIColor.baseBackground, UIColor.baseBGColor
UIColor.textTitleColor, .textSecColor, .textDesColor, .textLinkColor
UIColor.baseLine

// Dynamic color for light/dark mode / 明暗模式动态颜色
UIColor.dynamicColor(light: .white, dark: .black)

// RGB / Hex / Random / RGB、十六进制、随机颜色
UIColor(r: 255, g: 128, b: 0, a: 1.0)
UIColor(hex: 0xFF8000)
UIColor("#FF8000")
UIColor.random

// Gradient from color array / 从颜色数组生成渐变
[.red, .blue, .green].gradient { gradient in
    gradient.startPoint = CGPoint(x: 0, y: 0)
    gradient.endPoint = CGPoint(x: 1, y: 1)
    return gradient
}
```

### UIButton

```swift
// Image-text layout / 图文布局
button.ss.layoutButton(.imagePositionTop, space: 8)  // Image on top, 8pt gap / 图片在上，间距8
button.ss.layoutButton(.imagePositionRight, space: 4) // Image on right / 图片在右

// Closure-based action / 闭包点击事件
button.addTouchUpInSideBtnAction { sender in
    print("button tapped")
}

// IBInspectable state properties / IB可检查状态属性
button.titleForNormal = "Submit"
button.titleColorForNormal = .white
button.imageForNormal = UIImage(systemName: "checkmark")
button.backImageForNormal = UIColor.blue.gradientImage
```

### CALayer

```swift
// Sketch-style shadow / Sketch风格阴影
layer.ss.sketchShadow(color: .black, alpha: 0.3, x: 0, y: 4, blur: 12, spread: 0)

// Simple shadow / 简单阴影
layer.ss.setShadow(color: .black, x: 0, y: 2, alpha: 0.2, radius: 8)

// Border & corner radius / 边框与圆角
layer.ss.setBorder(color: .gray, width: 1, corner: 8)

// Partial corners / 部分圆角
layer.ss.setCorners(12, corners: [.leftTop, .rightTop])

// CACornerMask shortcuts / CACornerMask快捷方式
CACornerMask.all          // All four corners / 四个角
CACornerMask.bothTop      // Top two corners / 上方两个角
CACornerMask.bothBottom   // Bottom two corners / 下方两个角
```

### UINavigationBar

```swift
// Global settings (call once at app launch) / 全局设置（应用启动时调用一次）
UINavigationBar.setBackgroundColor(.white)
UINavigationBar.setTitleColor(.black)
UINavigationBar.setTintColor(.blue)
UINavigationBar.setShadowColor(.clear)  // Hide separator / 隐藏分割线

// Per-instance settings / 实例级设置
navigationBar.ss.setBackgroundColor(.red)
navigationBar.ss.setLineHidden(hidden: true)  // Hide separator line / 隐藏分割线
navigationBar.ss.setAlphaElements(0.5)        // Set transparency / 设置透明度
```

### UINavigationController (Smooth nav bar show/hide / 导航栏平滑显示隐藏)

```swift
// ① Initialize at app launch / 应用启动时初始化
SwiftBrick.inits()

// ② In VC that needs hidden nav bar / 在需要隐藏导航栏的VC中
override var prefersNavigationBarHidden: Bool? {
    return true  // or false / 或 false
}
```

### UITabBar

```swift
// Global settings / 全局设置
UITabBar.setTitleColor(normal: .gray, selected: .blue)
UITabBar.setShadowColor(.clear)

// Badge management / 角标管理
tabBar.ss.showBadgeOnItemIndex(index: 1)           // Show badge at index 1 / 在索引1显示角标
tabBar.ss.hiddenRedPointOnIndex(index: 1, animation: true)  // Hide badge / 隐藏角标
```

### UIStackView

```swift
// Quick init / 快速初始化
let stack = UIStackView(axis: .vertical, spacing: 12, alignment: .fill, distribution: .fillEqually)

// Add background / 添加背景
stack.ss.addBackground(color: .white, cornerRadius: 8)

// Add/remove arranged subviews / 添加/移除排列子视图
stack.ss.addArrangedSubviews([view1, view2, view3])
stack.ss.removeArrangedSubviews()
stack.ss.removeArrangedView(view1)
```

### UITextView (Placeholder support / 占位符支持)

```swift
textView.holderText = "Enter text..."
textView.holderColor = .lightGray
textView.holderFont = .systemFont(ofSize: 14)
```

### UITableViewCell (Custom separators / 自定义分割线)

```swift
// Full lines (including header/footer) / 完整线条（含头尾）
cell.ss.addAllLine(tableView: tableView, indexPath: indexPath, leftMarign: 16, rightMarign: 16)

// Middle lines only (no header/footer lines) / 仅中间线条
cell.ss.addMiddleLine(indexPath: indexPath, leftMarign: 16, rightMarign: 16)

// Bottom line only / 仅底部线条
cell.ss.addDownLine(leftMarign: 16, rightMarign: 16)
```

### UIGestureRecognizer (Closure-based / 闭包手势)

```swift
let tap = UITapGestureRecognizer { recognizer in
    print("tapped!")
}
view.addGestureRecognizer(tap)
```

---

## Utilities / 工具类

### Taptic Feedback / 触觉反馈

```swift
TapBuzz.light()       // Light impact / 轻度冲击
TapBuzz.medium()      // Medium impact / 中度冲击
TapBuzz.heavy()       // Heavy impact / 重度冲击
TapBuzz.selection()   // Selection change / 选择变更
TapBuzz.success()     // Success notification / 成功通知
TapBuzz.warning()     // Warning notification / 警告通知
TapBuzz.error()       // Error notification / 错误通知
```

### Dispatch / 多线程

```swift
// Main thread / 主线程
Dispatch.main().run { /* update UI / 更新UI */ }
Dispatch.main().after(1.0) { /* delayed / 延迟执行 */ }

// Background / 后台线程
Dispatch.background().run { /* heavy work / 耗时操作 */ }

// User-initiated (high priority) / 用户发起（高优先级）
Dispatch.userInitiated().run { /* fetch data / 获取数据 */ }

// Check main thread / 检查是否主线程
let isMain = DispatchQueue.isMainQueue
```

### UserDefaults / 用户默认存储

```swift
// Property wrapper / 属性包裹器
@UserDefault("username", defaultValue: "guest")
static var username: String?

// Suite (shared defaults) / 共享组
@UserDefaultSuite("appGroup", key: "token", defaultValue: "")
static var token: String?

// Codable support / Codable支持
UserDefaults.standard.ss.set(object: myModel, forKey: "model")
let model: MyModel? = UserDefaults.standard.ss.getT(objectType: MyModel.self, forKey: "model")

// Subscript / 下标
UserDefaults.standard.ss["key"] = "value"
```

### Logging / 日志 (iOS 14+)

```swift
logger.log("Message")           // Default / 默认
logger.debug("Debug info")      // Debug / 调试
logger.info("Info")             // Info / 信息
logger.warning("Warning")       // Warning / 警告
logger.error("Error")           // Error / 错误
logger.critical("Critical")     // Critical / 严重
logger.fault("Fault")           // Fault / 故障
logger.log("Private", isPrivate: true)  // Private data / 私有数据
```

### Image Utilities / 图片工具

```swift
// SF Symbols / SF符号
UIImage.symbol("house", size: 24, color: .blue)
UIImage.symbol("chevron.backward")  // Back arrow / 返回箭头

// Built-in icons / 内置图标
UIImage.icon_back   // Back icon / 返回图标
UIImage.icon_close  // Close icon / 关闭图标

// Extract colors from image / 从图片提取颜色
image.ss.colors()  // Returns (background, primary, secondary, detail)

// Get color at point / 获取某点颜色
image.ss.color(at: CGPoint(x: 50, y: 50)) { color in
    // use color / 使用颜色
}

// SHA256 hash / SHA256哈希
let hash = image.ss.sha256
```

### String / 字符串

```swift
// SHA256 / SHA256哈希
"hello".ss.sha256

// JSON string to dictionary / JSON字符串转字典
let dict = jsonString.ss.toDictionary()

// Localization / 本地化
"welcome_key".localizedBrick  // From SwiftBrick bundle / 从SwiftBrick资源包
"welcome_key".localized       // From main bundle / 从主资源包
```

### Array / 数组

```swift
array.indexValue(safe: 5)      // Safe index access / 安全索引访问
array.indexes("item")          // Find all indexes / 查找所有索引
array.firstIndex("item")       // First occurrence / 首次出现
array.lastIndex("item")        // Last occurrence / 末次出现
array.remove("item")           // Remove element(s) / 删除元素
array.toJSON()                 // Array to JSON string / 数组转JSON字符串
["a", "b", "c"].toStrinig(separator: "-")  // "a-b-c"
```

### Dictionary / 字典

```swift
dict.ss.has("key")             // Check if key exists / 检查键是否存在
dict.ss.allKeys()              // All keys / 所有键
dict.ss.allValues()            // All values / 所有值
dict.ss.toJSON()               // Dict to JSON string / 字典转JSON字符串
```

### Version Comparison / 版本比较

```swift
let version = Version()  // Current iOS version / 当前iOS版本
let v15 = Version(15, 0, 0)

if version >= v15 { /* iOS 15+ */ }
if Version() > Version(16, 0, 0) { /* iOS 16+ */ }
```

### Screen Adapter / 屏幕适配

```swift
// Zoom calculation / 缩放计算
let scaledSize = 16.zoom()  // Scales from 375pt base / 基于375pt基准缩放

// Screen-based conditional / 基于屏幕尺寸的条件
let value = 100.screen
    .width(...667, is: 100, zoomed: 120)
    .width(667..., is: 120)
    .value

// Screen info / 屏幕信息
let screen = UIScreen.main.screen
screen.inch      // .inch._6_1, etc. / 屏幕尺寸
screen.level     // .compact, .regular, .full / 屏幕级别
screen.aspectRatio        // "201:437" / 真实宽高比
screen.standardAspectRatio // "9:19.5" / 标准宽高比
screen.isZoomedMode        // Display Zoom enabled? / 是否放大模式
```

### Locale / 语言环境

```swift
SwiftBrick.Locale.currentLanguage  // "en", "zh", etc. / 当前系统语言代码
```

### Resource Loader / 资源加载器

```swift
L.color("customColor")   // Load color from bundle / 从资源包加载颜色
L.image("customImage")   // Load image from bundle / 从资源包加载图片
```

---

## Common Patterns / 常用模式

### Complete VC Example / 完整VC示例

```swift
class HomeVC: TableViewController {
    
    var items: [String] = ["Item 1", "Item 2", "Item 3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        mainDatas = items
        tableView?.ss.registerCell(HomeCell.self)
        
        // Right bar button / 右侧按钮
        ss.addRightBarButton(normalImage: UIImage.symbol("gearshape")) { [weak self] _ in
            self?.showSettings()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ss.dequeueReusableCell(HomeCell.self)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TapBuzz.selection()
        let detail = DetailVC()
        navigationController?.pushViewController(detail, animated: true)
    }
}
```

### Auto Layout Example / 自动布局示例

```swift
let container = UIView()
view.addSubview(container)

container.ss.makeConstraints { maker in
    maker.topAnchor(equalTo: view.ss.safeTopAnchor).offset(16)
    maker.leadingAnchor(equalTo: view.ss.safeLeadingAnchor).offset(16)
    maker.trailingAnchor(equalTo: view.ss.safeTrailingAnchor).offset(-16)
    maker.heightAnchor(200)
}

container.ss.setBackColor([UIColor(r: 100, g: 150, b: 255), UIColor(r: 50, g: 100, b: 200)])
container.layer.ss.setCorners(12, corners: .all)
```

---

## Architecture / 架构

```
SwiftBrick/
├── Util/           # Utilities: Define, Device, Font, Version, TapBuzz, etc.
│                   # 工具类: 定义、设备、字体、版本、震动反馈等
├── Extensions/     # UIKit extensions via .ss accessor
│                   # UIKit扩展: 通过.ss访问器
├── BaseVC/         # Base view controllers
│                   # 基础视图控制器
├── BaseCell/       # Reusable cell base classes & protocols
│                   # 可复用单元格基类与协议
└── ViewFactory/    # Custom views (InsetLabel, UILineView)
                    # 自定义视图
```
