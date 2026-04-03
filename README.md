

![](Image/logo.png)

[![Version](https://img.shields.io/cocoapods/v/SwiftBrick.svg?style=flat)](http://cocoapods.org/pods/SwiftBrick)
[![SPM](https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat)](https://swift.org/package-manager/)
![Xcode 11.0+](https://img.shields.io/badge/Xcode-11.0%2B-blue.svg)
![iOS 13.0+](https://img.shields.io/badge/iOS-13.0%2B-blue.svg)
![Swift 5.0+](https://img.shields.io/badge/Swift-5.0%2B-orange.svg)

This Package is also available on [Gitee](https://gitee.com/zjinhu/swift-brick). If you find SPM from GitHub is slow, try Gitee.

SwiftBrick is an easy-to-use, feature-rich UI basic framework designed to rapidly build app UI. It includes color assets (all dark mode compatible), base view controllers, reusable cells, UIKit extensions, and utility tools.

## Features

### BaseVC

- Common ViewController base classes: `TableViewController`, `CollectionViewController`, `WebViewController`, `ViewController`, `SwiftUIVC`
- `BaseVC` protocol: handles navigation bar left/right buttons with closure support
- Smooth navigation bar show/hide transitions between VCs

### BaseCell

- Cell base classes & protocols for TableView, CollectionView
- Header/Footer registration for easy reuse
- `Reusable` protocol eliminates boilerplate registration code

### Extensions

| Extension | Description |
|-----------|-------------|
| `UINavigationBar` | Background color, separator line hide/show, transparency |
| `UINavigationController` | Smooth nav bar show/hide on push/pop |
| `UIViewController` | Status bar show/hide, nav bar button helpers |
| `UIView` | Gradient background, tap gesture with closure, parent VC finder |
| `UITableViewCell` | Custom separator lines (full, middle, bottom) |
| `UIButton` | Image-text layout, closure-based actions, IBInspectable state properties |
| `UIGestureRecognizer` | Closure-based gesture handlers |
| `UIStackView` | Convenience init, background view, batch add/remove |
| `UITabBar` | Badge management, global appearance |
| `UITextView` | Placeholder text support |
| `UIColor` | RGB/Hex/Random colors, dynamic light/dark, gradient generation |
| `UIImage` | SF Symbol helpers, color extraction, SHA256 |
| `UIImageView` | Placeholder image caching |
| `CALayer` | Shadow, border, corner radius (partial corners) |
| `Array` | Safe indexing, element search, remove, JSON conversion |
| `Dictionary` | Key check, all keys/values, JSON conversion |
| `String` | SHA256, JSON parsing, localization |
| `Data` | SHA256 hashing |
| `Dispatch` | QoS-based dispatch with delay support |
| `UserDefaults` | Codable support, subscript access |
| `Layout` | Auto Layout constraint maker, safe area anchors, adaptive scaling |

### Utilities

| Utility | Description |
|---------|-------------|
| `Define` | Screen dimensions, nav/tab bar heights, 1px line width |
| `Device` | Device detection (iPhone X, iPad), iOS version checks |
| `Version` | iOS version comparison (`Version() > Version(15, 0, 0)`) |
| `Font` | System fonts, PingFang SC with weights, adaptive sizing |
| `TapBuzz` | Haptic feedback (impact, selection, notification) |
| `BrickLog` | Structured logging with levels (iOS 14+) |
| `AppState` | Detect debug/testflight/appstore environment |
| `Application` | App name, version, build, bundle ID |
| `UIAdapter` | Screen-adaptive scaling for all UI types |
| `Locale` | Current system language code |
| `Loader` | Bundle resource loading (colors, images) |

### ViewFactory

- `InsetLabel`: UILabel with configurable text insets
- `UILineView`: Draw solid/dashed lines (horizontal/vertical)

## Install

### Cocoapods

1. Add `pod 'SwiftBrick'` to Podfile
2. Run `pod install` or `pod update`
3. Import `import SwiftBrick`

### Swift Package Manager

Select `File > Swift Packages > Add Package Dependency` in Xcode, then enter:

`https://github.com/jackiehu/SwiftBrick`

### Manual

Drag the `SwiftBrick` folder from `Sources` into your project.

## Quick Usage

```swift
import SwiftBrick

// Access screen metrics
let width = Define.screenWidth
let height = Define.screenHeight
let fitW = Define.fitWidth    // e.g., 30 * fitW for adaptive width

// Device detection
if Device.isiPhoneX { /* has notch */ }
if Device.isiPad { /* is iPad */ }

// Haptic feedback
TapBuzz.light()
TapBuzz.success()

// Color helpers
let color = UIColor(r: 255, g: 128, b: 0)
let hexColor = UIColor(hex: 0xFF8000)
let hexStrColor = UIColor("#FF8000")

// Gradient background
view.ss.setBackColor([.red, .blue])

// Auto Layout
view.ss.makeConstraints { maker in
    maker.topAnchor(equalTo: view.ss.safeTopAnchor).offset(20)
    maker.leadingAnchor(equalTo: view.ss.safeLeadingAnchor).offset(16)
    maker.trailingAnchor(equalTo: view.ss.safeTrailingAnchor).offset(-16)
    maker.heightAnchor(44)
}

// Button with closure
button.addTouchUpInSideBtnAction { sender in
    print("tapped")
}

// Navigation bar global setup
UINavigationBar.setBackgroundColor(.white)
UINavigationBar.setTitleColor(.black)
UINavigationBar.setShadowColor(.clear)

// UserDefaults with property wrapper
@UserDefault("username", defaultValue: "guest")
static var username: String?
```

## AI Skills Integration

SwiftBrick includes a comprehensive **SKILLS.md** file designed for AI assistants. This file provides:

- Complete API reference with bilingual descriptions
- Usage patterns and code examples for every feature
- Architecture overview
- Common implementation patterns

### How to Use SKILLS.md with AI

When working with AI coding assistants (like Cursor, GitHub Copilot, or Claude), reference the SKILLS.md file to get accurate SwiftBrick code suggestions:

**1. Include the file in your project context**

Add `SKILLS.md` to your AI tool's context or reference it in prompts:

```
Reference: @SKILLS.md
```

**2. Ask for specific features**

```
Using SwiftBrick, create a TableViewController with custom cells and gradient background.
See SKILLS.md for API reference.
```

**3. Get correct constraint syntax**

```
How do I add Auto Layout constraints with SwiftBrick? Check SKILLS.md Layout section.
```

**4. Verify API usage**

```
What's the correct way to register and dequeue cells in SwiftBrick?
Refer to SKILLS.md Base Cells section.
```

### Example AI Prompt

```
@SKILLS.md 

Create a HomeVC that:
1. Extends TableViewController with grouped style
2. Has a gradient background (blue to purple)
3. Registers a custom cell
4. Adds a right nav bar button with SF Symbol icon
5. Shows haptic feedback on cell selection
```

## More Brick Tools

[![ReadMe Card](https://github-readme-stats-sigma-five.vercel.app/api/pin/?username=zjinhu&repo=SwiftMediator&theme=radical)](https://github.com/zjinhu/SwiftMediator)

[![ReadMe Card](https://github-readme-stats-sigma-five.vercel.app/api/pin/?username=zjinhu&repo=SwiftLog&theme=radical)](https://github.com/zjinhu/SwiftLog)

[![ReadMe Card](https://github-readme-stats-sigma-five.vercel.app/api/pin/?username=zjinhu&repo=SwiftMesh&theme=radical)](https://github.com/zjinhu/SwiftMesh)

[![ReadMe Card](https://github-readme-stats-sigma-five.vercel.app/api/pin/?username=zjinhu&repo=SwiftNotification&theme=radical)](https://github.com/zjinhu/SwiftNotification)
