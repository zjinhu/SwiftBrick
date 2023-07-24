

![](Image/logo.png)


[![Version](https://img.shields.io/cocoapods/v/SwiftBrick.svg?style=flat)](http://cocoapods.org/pods/SwiftBrick)
[![SPM](https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat)](https://swift.org/package-manager/)
![Xcode 11.0+](https://img.shields.io/badge/Xcode-11.0%2B-blue.svg)
![iOS 13.0+](https://img.shields.io/badge/iOS-13.0%2B-blue.svg)
![Swift 5.0+](https://img.shields.io/badge/Swift-5.0%2B-orange.svg)

此Package与[Gitee](https://gitee.com/zjinhu/swift-brick)同步，如果觉得SPM引入github地址偏慢可以使用Gitee。

SwiftBrick是一个简单易用、功能丰富的UI基础框架，主要目的是为了快速搭建APP UI 。

内含部分颜色资源（都支持暗黑模式）。

## 功能

### BaseVC

- 包括几种常见的ViewController基类，TableViewController、CollectionViewController、WKWebViewController，ViewController，UIHostingController等VC封装
- BaseVC协议：处理导航栏左右按钮

### BaseCell

Cell基类协议-- TableView、CollectionView的Cell以及Header/Footer注册，方便复用

### Extensions



- [x] UINavigationBar扩展背景色修改，分割线隐藏，透明度变化
- [x] UINavigationController扩展出入栈导航栏隐藏展示的平滑切换
- [x] UIViewController扩展StatusBar展示和隐藏
- [x] UIView扩展渐变色背景
- [x] UITableViewCell扩展各种样式分割线
- [x] UIButton扩展图文排版
- [x] UIGestureRecognizer扩展闭包
- [x] Array扩展
- [x] CALayer扩展
- [x] CGSize扩展
- [x] Dictionary扩展
- [x] Dispatch扩展
- [x] Layout扩展
- [x] NSObject扩展
- [x] String扩展
- [x] SFSymbol扩展
- [x] UIImage扩展
- [x] UIStackView扩展
- [x] UITabBar扩展
- [x] UITextView扩展
- [x] UIColor扩展
- [x] UserDefault、UserDefaultSuite属性包裹器

### Util

各种Swift宏定义

震动反馈工具

iOS系统版本对比判断

### ViewFactory

自定义View



## 安装

### cocoapods

几个Group可单独引用也可全体引入
比如 `pod ‘SwiftBrick/ViewFactory’`

1.在 Podfile 中添加 `pod ‘SwiftBrick’`

2.执行 `pod install 或 pod update`

3.导入 `import SwiftBrick`

### Swift Package Manager

从 Xcode 11 开始，集成了 Swift Package Manager，使用起来非常方便。SwiftBrick 也支持通过 Swift Package Manager 集成。

在 Xcode 的菜单栏中选择 `File > Swift Packages > Add Pacakage Dependency`，然后在搜索栏输入

`https://github.com/jackiehu/SwiftBrick`，即可完成集成

### 手动集成

SwiftBrick 也支持手动集成，只需把Sources文件夹中的SwiftBrick文件夹拖进需要集成的项目即可



## 更多砖块工具加速APP开发

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftMediator&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftMediator)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftLog&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftLog)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftMesh&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftMesh)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftNotification&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftNotification)



