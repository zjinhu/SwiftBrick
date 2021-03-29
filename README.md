# UI工具组件--SwiftBrick
这是一个UI工具类集合，方便快速搭建APP UI ，依赖SnapKit。涉及到的设计模式有：工厂，装饰，抽象等等，加快APP开发搭建进度。

支持CocoaPods，SwiftPM。

内含部分图片颜色资源（支持暗黑模式）。

## 功能

- VC基类、协议--继承后即可使用，包括处理导航栏左右按钮，TableView、CollectionView、WKWebview等VC封装
- Cell基类、协议-- TableView、CollectionView的Cell以及Header/Footer注册，复用
- UINavigationBar背景色修改，分割线隐藏
- UINavigationController出入栈导航栏隐藏展示的平滑切换
- UIStatusBar样式以及展示隐藏
- View渐变色背景
- UITableViewCell各种样式分割线
- UIButton扩展图文
- 各种View的扩展工厂
- UIColor扩展
- UserDefault、UserDefaultSuite属性包裹器
- iOS系统版本对比判断
- 震动反馈工具
- 各种Swift宏定义

## 文件目录
1. ### ViewFactory

  基于SnapKit封装常用UI控件，一个函数创建UI控件，比如UILabel
```swift
    /// 快速初始化UILabel 包含默认参数,初始化过程可以删除部分默认参数简化方法
    /// - Parameters:
    ///   - font: 字体 有默认参数
    ///   - lines: 行数 有默认参数
    ///   - text: 内容 有默认参数
    ///   - textColor: 字体颜色 有默认参数
    ///   - supView: 被添加的位置 有默认参数
    ///   - textAlignment: textAlignment 有默认参数
    ///   - snapKitMaker: SnapKit 有默认参数
    ///   - backColor: 背景色
    @discardableResult
    class func snpLabel(supView: UIView? = nil,
                        backColor: UIColor? = .clear,
                        font: UIFont = UIFont.systemFont(ofSize: 14),
                        lines: Int = 0,
                        text: String = "",
                        textColor: UIColor = .black,
                        textAlignment: NSTextAlignment = .left,
                        snapKitMaker: ((ConstraintMaker) -> Void)? = nil) -> UILabel 
```
可以根据参数需要更改的做保留，不需要更改的直接使用默认参数，例子：
```swift
let _ = UILabel.snpLabel(text: “我是Label”, textColor: .red, supView: self.view, snapKitMaker: { (make) in
            make.center.equalToSuperview()
        })
```
常用的UI控件都做了SnapKit封装，方便实用，且添加了点击手势闭包以及UIButton点击闭包。
2. ### Extensions

  添加几个常用的扩展，方便开发使用
* UIGestureRecognizer — 添加闭包回调handleAction
* CALayer  —添加阴影的扩展方法swSetShadow，方便一行代码添加阴影
* UIColor —扩展UIColor，方便字符串类型的色值设置
* UINavigationController —对Nav做扩展，给VC添加属性，方便设置隐藏导航栏，以及解决多级页面导航栏隐藏显示过程中的动画问题，
仅需要在VC的viewDidLoad中设置 `self.prefersNavigationBarHidden = true/false`来控制当前页面的导航栏是否隐藏（ios13需SceneDelegate中添加SwizzleNavBar.swizzle进行方法交换）详细请参考DEMO
* StatusBaEx --添加状态栏控制工具，添加UIViewController专属参数控制状态栏样式以及显示隐藏，不局限于VC，可在任意位置控制，只要递归到最上层VC即可（参考：https://github.com/jackiehu/SwiftMediator）
* UITableViewCell -- 分割线快速添加
* UIButton -- 图文混排按钮扩展
3. ### BaseVC

  针对几个常用的VC做了父类化封装。方便开发过程中的VC创建，只需要继承相关父类，调用相关方法执行相应的代理即可
* JHViewController   --继承后方便设置导航栏左右按钮以及可选某些页面关闭滑动返回，统一返回方法
* JHTableViewController  --继承后方便创建列表VC针对数据源做了处理，子类只需要设置mainDatas，代理方法不需要关心个数等等
* JHCollectionViewController  --同上
* JHWebViewController --方便创建WKWebView视图VC，可选择更改UA、注入Cookie等，退出清理缓存
详细用法参见DEMO
4. ### BaseCell
* 泛型封装Table、Collection的Cell以及HeaderView，方便快速注册，复用，传递Model，只需要继承后在configViews里做相关布局UI即可。
5. ### Util
* 常量，工具

具体使用代码api详细参见Demo

### 更多砖块工具加速APP开发

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftMediator&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftMediator)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftShow&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftShow)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftLog&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftLog)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftyForm&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftyForm)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftEmptyData&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftEmptyData)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftPageView&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftPageView)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=JHTabBarController&theme=radical&locale=cn)](https://github.com/jackiehu/JHTabBarController)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftMesh&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftMesh)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftNotification&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftNotification)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftNetSwitch&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftNetSwitch)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftButton&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftButton)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftDatePicker&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftDatePicker)

## 安装
#### cocoapods导入
几个Group可单独引用也可全体引入
比如 `pod ‘SwiftBrick/ViewFactory’`
* 1.在 Podfile 中添加 `pod ‘SwiftBrick’`
* 2.执行 `pod install 或 pod update`
* 3.导入 `import SwiftBrick`
#### SPM导入

`https://github.com/jackiehu/SwiftBrick`

#### 手动导入

或者手动拖入代码即可
