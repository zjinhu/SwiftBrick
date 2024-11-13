
import Foundation
#if os(iOS)
import UIKit

public enum UIAdapter {
    
    public enum Zoom {
        
        /// 设置转换闭包
        ///
        /// - Parameter conversion: 转换闭包
        public static func set(conversion: @escaping ((Double) -> Double)) {
            conversionClosure = conversion
        }
        
        /// 转换 用于数值的等比例计算 如需自定义可重新设置
        static var conversionClosure: ((Double) -> Double) = { (origin) in
            guard UIDevice.current.userInterfaceIdiom == .phone else {
                return origin
            }
            
            let base = 375.0
            let screenWidth = Double(UIScreen.main.bounds.width)
            let screenHeight = Double(UIScreen.main.bounds.height)
            let width = min(screenWidth, screenHeight)
            let result = origin * (width / base)
            let scale = Double(UIScreen.main.scale)
            return (result * scale).rounded(.up) / scale
        }
    }
}

extension UIAdapter.Zoom {
    
    static func conversion(_ value: Double) -> Double {
        return conversionClosure(value)
    }
}

public protocol UIAdapterZoomCalculationable {
    
    /// 缩放计算
    ///
    /// - Returns: 结果
    func zoom() -> Self
}

extension Double: UIAdapterZoomCalculationable {
    
    public func zoom() -> Double {
        return UIAdapter.Zoom.conversion(self)
    }
}

extension BinaryInteger {
    
    public func zoom() -> Double {
        let temp = Double("\(self)") ?? 0
        return temp.zoom()
    }
    public func zoom<T>() -> T where T : BinaryInteger {
        let temp = Double("\(self)") ?? 0
        return temp.zoom()
    }
    public func zoom<T>() -> T where T : BinaryFloatingPoint {
        let temp = Double("\(self)") ?? 0
        return temp.zoom()
    }
}

extension BinaryFloatingPoint {
    
    public func zoom() -> Double {
        let temp = Double("\(self)") ?? 0
        return temp.zoom()
    }
    public func zoom<T>() -> T where T : BinaryInteger {
        let temp = Double("\(self)") ?? 0
        return T(temp.zoom())
    }
    public func zoom<T>() -> T where T : BinaryFloatingPoint {
        let temp = Double("\(self)") ?? 0
        return T(temp.zoom())
    }
}

extension CGPoint: UIAdapterZoomCalculationable {
    
    public func zoom() -> CGPoint {
        return CGPoint(x: x.zoom(), y: y.zoom())
    }
}

extension CGSize: UIAdapterZoomCalculationable {
    
    public func zoom() -> CGSize {
        return CGSize(width: width.zoom(), height: height.zoom())
    }
}

extension CGRect: UIAdapterZoomCalculationable {
    
    public func zoom() -> CGRect {
        return CGRect(origin: origin.zoom(), size: size.zoom())
    }
}

extension CGVector: UIAdapterZoomCalculationable {
    
    public func zoom() -> CGVector {
        return CGVector(dx: dx.zoom(), dy: dy.zoom())
    }
}

extension UIOffset: UIAdapterZoomCalculationable {
    
    public func zoom() -> UIOffset {
        return UIOffset(horizontal: horizontal.zoom(), vertical: vertical.zoom())
    }
}

extension UIEdgeInsets: UIAdapterZoomCalculationable {
    
    public func zoom() -> UIEdgeInsets {
        return UIEdgeInsets(
            top: top.zoom(),
            left: left.zoom(),
            bottom: bottom.zoom(),
            right: right.zoom()
        )
    }
}


extension NSLayoutConstraint {
    
    @IBInspectable private var zoomConstant: Bool {
        get { return false }
        set {
            guard newValue else { return }
            
            constant = constant.zoom()
        }
    }
}

extension UIView {
    
    @IBInspectable private var zoomCornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            let value: CGFloat = newValue.zoom()
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(value * 100)) / 100)
        }
    }
}

extension UILabel {
    
    @IBInspectable private var zoomFont: Bool {
        get { return false }
        set {
            guard newValue else { return }
            guard let text = attributedText?.mutableCopy() as? NSMutableAttributedString else {
                return
            }
            
            font = font.withSize(font.pointSize.zoom())
            attributedText = text.reset(font: { $0.zoom() })
        }
    }
    
    @IBInspectable private var zoomLine: Bool {
        get { return false }
        set {
            guard newValue else { return }
            guard let text = attributedText else { return }
            
            attributedText = text.reset(line: { $0.zoom() })
        }
    }
    
    @IBInspectable private var zoomShadowOffset: Bool {
        get { return false }
        set {
            guard newValue else { return }
            
            shadowOffset = shadowOffset.zoom()
        }
    }
}

extension UITextView {
    
    @IBInspectable private var zoomFont: Bool {
        get { return false }
        set {
            guard newValue else { return }
            guard let font = font else { return }
            
            self.font = font.withSize(font.pointSize.zoom())
        }
    }
}

extension UITextField {
    
    @IBInspectable private var zoomFont: Bool {
        get { return false }
        set {
            guard newValue else { return }
            guard let font = font else { return }
            
            self.font = font.withSize(font.pointSize.zoom())
        }
    }
}

extension UIImageView {
    
    @IBInspectable private var zoomImage: Bool {
        get { return false }
        set {
            guard newValue else { return }
            
            if let width = image?.size.width {
                image = image?.scaled(to: width.zoom())
            }
            if let width = highlightedImage?.size.width {
                highlightedImage = highlightedImage?.scaled(to: width.zoom())
            }
        }
    }
}

extension UIButton {
    
    @IBInspectable private var zoomTitle: Bool {
        get { return false }
        set {
            guard newValue else { return }
            
            let states: [UIControl.State] = [
                .normal,
                .highlighted,
                .selected,
                .disabled
            ]
            
            if
                let _ = title(for: state),
                let label = titleLabel,
                let font = label.font {
                label.font = font.withSize(font.pointSize.zoom())
            }
            
            let titles = states.enumerated().compactMap {
                (i, state) -> (Int, NSAttributedString)? in
                guard let t = attributedTitle(for: state) else { return nil }
                return (i, t)
            }
            titles.filtered(duplication: { $0.1 }).forEach {
                setAttributedTitle(
                    $0.1.reset(font: { $0.zoom() }),
                    for: states[$0.0]
                )
            }
        }
    }
    
    @IBInspectable private var zoomImage: Bool {
        get { return false }
        set {
            guard newValue else { return }
            
            let states: [UIControl.State] = [
                .normal,
                .highlighted,
                .selected,
                .disabled
            ]
            
            let images = states.enumerated().compactMap {
                (i, state) -> (Int, UIImage)? in
                guard let v = image(for: state) else { return nil }
                return (i, v)
            }
            images.filtered(duplication: { $0.1 }).forEach {
                setImage(
                    $0.1.scaled(to: $0.1.size.width.zoom()),
                    for: states[$0.0]
                )
            }
            
            let backgrounds = states.enumerated().compactMap {
                (i, state) -> (Int, UIImage)? in
                guard let v = backgroundImage(for: state) else { return nil }
                return (i, v)
            }
            backgrounds.filtered(duplication: { $0.1 }).forEach {
                setBackgroundImage(
                    $0.1.scaled(to: $0.1.size.width.zoom()),
                    for: states[$0.0]
                )
            }
        }
    }
    
    @IBInspectable private var zoomTitleInsets: Bool {
        get { return false }
        set {
            guard newValue else { return }
            
            titleEdgeInsets = titleEdgeInsets.zoom()
        }
    }
    
    @IBInspectable private var zoomImageInsets: Bool {
        get { return false }
        set {
            guard newValue else { return }
            
            imageEdgeInsets = imageEdgeInsets.zoom()
        }
    }
    
    @IBInspectable private var zoomContentInsets: Bool {
        get { return false }
        set {
            guard newValue else { return }
            
            contentEdgeInsets = contentEdgeInsets.zoom()
        }
    }
}

@available(iOS 9.0, *)
extension UIStackView {
    
    @IBInspectable private var zoomSpacing: Bool {
        get { return false }
        set {
            guard newValue else { return }
            
            spacing = spacing.zoom()
        }
    }
}

fileprivate extension NSAttributedString {
    
    func reset(font size: (CGFloat) -> CGFloat) -> NSAttributedString {
        let string = NSMutableAttributedString(attributedString: self)
        enumerateAttributes(
            in: NSRange(location: 0, length: length),
            options: .longestEffectiveRangeNotRequired
        ) { (attributes, range, stop) in
            var temp = attributes
            if let font = attributes[.font] as? UIFont {
                temp[.font] = font.withSize(size(font.pointSize))
            }
            string.setAttributes(temp, range: range)
        }
        return string
    }
    
    func reset(line spacing: (CGFloat) -> CGFloat) -> NSAttributedString {
        let string = NSMutableAttributedString(attributedString: self)
        enumerateAttributes(
            in: NSRange(location: 0, length: length),
            options: .longestEffectiveRangeNotRequired
        ) { (attributes, range, stop) in
            var temp = attributes
            if let paragraph = attributes[.paragraphStyle] as? NSMutableParagraphStyle {
                paragraph.lineSpacing = spacing(paragraph.lineSpacing)
                temp[.paragraphStyle] = paragraph
            }
            string.setAttributes(temp, range: range)
        }
        return string
    }
}

fileprivate extension UIImage {
    
    func scaled(to width: CGFloat, opaque: Bool = false) -> UIImage? {
        guard self.size.width > 0 else {
            return nil
        }
        
        let scale = width / self.size.width
        let size = CGSize(width: width, height: self.size.height * scale)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        draw(in: CGRect(origin: .zero, size: size))
        let new = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return new
    }
}

fileprivate extension Array {
    
    func filtered<E: Equatable>(duplication closure: (Element) throws -> E) rethrows -> [Element] {
        return try reduce(into: [Element]()) { (result, e) in
            let contains = try result.contains { try closure($0) == closure(e) }
            result += contains ? [] : [e]
        }
    }
}

public extension Double {
    
    func rounded(_ decimalPlaces: Int) -> Double {
        let divisor = pow(10.0, Double(max(0, decimalPlaces)))
        return (self * divisor).rounded() / divisor
    }
}

public extension BinaryFloatingPoint {
    
    func rounded(_ decimalPlaces: Int) -> Double {
        let temp = Double("\(self)") ?? 0
        return temp.rounded(decimalPlaces)
    }
    
    func rounded<T>(_ decimalPlaces: Int) -> T where T: BinaryFloatingPoint {
        let temp = Double("\(self)") ?? 0
        return T(temp.rounded(decimalPlaces))
    }
}

public extension CGPoint {
    
    func rounded(_ decimalPlaces: Int) -> CGPoint {
        return CGPoint(x: x.rounded(decimalPlaces), y: y.rounded(decimalPlaces))
    }
}

public extension CGSize {
    
    func rounded(_ decimalPlaces: Int) -> CGSize {
        return CGSize(width: width.rounded(decimalPlaces), height: height.rounded(decimalPlaces))
    }
}

public extension CGRect {
    
    func rounded(_ decimalPlaces: Int) -> CGRect {
        return CGRect(origin: origin.rounded(decimalPlaces), size: size.rounded(decimalPlaces))
    }
}

public extension UIEdgeInsets {
    
    func rounded(_ decimalPlaces: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: top.rounded(decimalPlaces),
            left: left.rounded(decimalPlaces),
            bottom: bottom.rounded(decimalPlaces),
            right: right.rounded(decimalPlaces)
        )
    }
}

public class UIAdapterScreenWrapper<Base> {
    
    let base: Screen
    
    public private(set) var value: Base
    
    init(_ value: Base) {
        self.base = .main
        self.value = value
    }
    
    init(_ value: Base, _ screen: UIScreen) {
        self.base = .init(screen)
        self.value = value
    }
}

public protocol UIAdapterScreenCompatible {
    associatedtype ScreenCompatibleType
    var screen: ScreenCompatibleType { get }
    
    func screen(_: UIScreen) -> ScreenCompatibleType
}

extension UIAdapterScreenCompatible {
    
    public var screen: UIAdapterScreenWrapper<Self> {
        get { return UIAdapterScreenWrapper(self) }
    }
    
    public func screen(_ screen: UIScreen) -> UIAdapterScreenWrapper<Self> {
        return UIAdapterScreenWrapper(self, screen)
    }
}

extension UIAdapterScreenWrapper {
    
    public typealias Screen = UIAdapter.Screen
    
    public func width(_ range: Range<CGFloat>, is value: Base, zoomed: Base? = nil) -> Self {
        return width({ range.contains($0) }, is: value, zoomed: zoomed ?? value)
    }
    public func width(_ range: ClosedRange<CGFloat>, is value: Base, zoomed: Base? = nil) -> Self {
        return width({ range.contains($0) }, is: value, zoomed: zoomed ?? value)
    }
    public func width(_ range: PartialRangeFrom<CGFloat>, is value: Base, zoomed: Base? = nil) -> Self {
        return width({ range.contains($0) }, is: value, zoomed: zoomed ?? value)
    }
    public func width(_ range: PartialRangeUpTo<CGFloat>, is value: Base, zoomed: Base? = nil) -> Self {
        return width({ range.contains($0) }, is: value, zoomed: zoomed ?? value)
    }
    public func width(_ range: PartialRangeThrough<CGFloat>, is value: Base, zoomed: Base? = nil) -> Self {
        return width({ range.contains($0) }, is: value, zoomed: zoomed ?? value)
    }
    
    public func width(greaterThan base: CGFloat, is value: Base, zoomed: Base? = nil) -> Self {
        return width({ $0 > base }, is: value, zoomed: zoomed ?? value)
    }
    public func width(lessThan base: CGFloat, is value: Base, zoomed: Base? = nil) -> Self {
        return width({ $0 < base }, is: value, zoomed: zoomed ?? value)
    }
    public func width(equalTo base: CGFloat, is value: Base, zoomed: Base? = nil) -> Self {
        return width({ $0 == base }, is: value, zoomed: zoomed ?? value)
    }
    private func width(_ matching: (CGFloat) -> Bool, is value: Base, zoomed: Base) -> Self {
        if matching(base.size.width) {
            self.value = base.isZoomedMode ? zoomed : value
        }
        return self
    }
    
    public func height(_ range: Range<CGFloat>, is value: Base, zoomed: Base? = nil) -> Self {
        return height({ range.contains($0) }, is: value, zoomed: zoomed ?? value)
    }
    public func height(_ range: ClosedRange<CGFloat>, is value: Base, zoomed: Base? = nil) -> Self {
        return height({ range.contains($0) }, is: value, zoomed: zoomed ?? value)
    }
    public func height(_ range: PartialRangeFrom<CGFloat>, is value: Base, zoomed: Base? = nil) -> Self {
        return height({ range.contains($0) }, is: value, zoomed: zoomed ?? value)
    }
    public func height(_ range: PartialRangeUpTo<CGFloat>, is value: Base, zoomed: Base? = nil) -> Self {
        return height({ range.contains($0) }, is: value, zoomed: zoomed ?? value)
    }
    public func height(_ range: PartialRangeThrough<CGFloat>, is value: Base, zoomed: Base? = nil) -> Self {
        return height({ range.contains($0) }, is: value, zoomed: zoomed ?? value)
    }
    
    public func height(greaterThan base: CGFloat, is value: Base, zoomed: Base? = nil) -> Self {
        return height({ $0 > base }, is: value, zoomed: zoomed ?? value)
    }
    public func height(lessThan base: CGFloat, is value: Base, zoomed: Base? = nil) -> Self {
        return height({ $0 < base }, is: value, zoomed: zoomed ?? value)
    }
    public func height(equalTo base: CGFloat, is value: Base, zoomed: Base? = nil) -> Self {
        return height({ $0 == base }, is: value, zoomed: zoomed ?? value)
    }
    private func height(_ matching: (CGFloat) -> Bool, is value: Base, zoomed: Base) -> Self {
        if matching(base.size.height) {
            self.value = base.isZoomedMode ? zoomed : value
        }
        return self
    }
    
    public func inch(_ range: Range<Double>, is value: Base, zoomed: Base? = nil) -> Self {
        return inch({ range.contains($0.rawValue) }, is: value, zoomed: zoomed ?? value)
    }
    public func inch(_ range: ClosedRange<Double>, is value: Base, zoomed: Base? = nil) -> Self {
        return inch({ range.contains($0.rawValue) }, is: value, zoomed: zoomed ?? value)
    }
    public func inch(_ range: PartialRangeFrom<Double>, is value: Base, zoomed: Base? = nil) -> Self {
        return inch({ range.contains($0.rawValue) }, is: value, zoomed: zoomed ?? value)
    }
    public func inch(_ range: PartialRangeUpTo<Double>, is value: Base, zoomed: Base? = nil) -> Self {
        return inch({ range.contains($0.rawValue) }, is: value, zoomed: zoomed ?? value)
    }
    public func inch(_ range: PartialRangeThrough<Double>, is value: Base, zoomed: Base? = nil) -> Self {
        return inch({ range.contains($0.rawValue) }, is: value, zoomed: zoomed ?? value)
    }
    private func inch(_ matching: (Screen.Inch) -> Bool, is value: Base, zoomed: Base) -> Self {
        if matching(base.inch) {
            self.value = base.isZoomedMode ? zoomed : value
        }
        return self
    }
    
    public func inch(_ types: Screen.Inch..., is value: Base, zoomed: Base? = nil) -> Self {
        return inch(types, is: value, zoomed: zoomed ?? value)
    }
    public func inch(_ types: [Screen.Inch], is value: Base, zoomed: Base? = nil) -> Self {
        for type in types where base.inch == type {
            self.value = base.isZoomedMode ? zoomed ?? value : value
        }
        return self
    }
    
    public func level(_ types: Screen.Level..., is value: Base, zoomed: Base? = nil) -> Self {
        return level(types, is: value, zoomed: zoomed ?? value)
    }
    public func level(_ types: [Screen.Level], is value: Base, zoomed: Base? = nil) -> Self {
        for type in types where base.level == type {
            self.value = base.isZoomedMode ? zoomed ?? value : value
        }
        return self
    }
}

extension UIAdapter {
    
    public class Screen {
        
        let base: UIScreen
        
        init(_ base: UIScreen) {
            self.base = base
        }
        
        public var size: CGSize {
            base.bounds.size
        }
        public var nativeSize: CGSize {
            base.nativeBounds.size
        }
        public var scale: CGFloat {
            base.scale
        }
        public var nativeScale: CGFloat {
            base.nativeScale
        }
        
        /// 是否为显示缩放模式
        public var isZoomedMode: Bool {
            guard !UIDevice.iPhonePlus else { return size.width == 375 }
            guard !UIDevice.iPhoneMini else { return size.width == 320 }
            return scale != nativeScale
        }
        
        /// 真实宽高比 例如: iPhone 16 Pro (201:437)
        public var aspectRatio: String {
            if
                let cache = _aspectRatio,
                cache.0 == nativeSize {
                return cache.1
                
            } else {
                let result = base.aspectRatio
                _aspectRatio = (nativeSize, result)
                return result
            }
        }
        private var _aspectRatio: (CGSize, String)?
        
        /// 标准宽高比 例如: iPhone 16 Pro (9:19.5)
        public var standardAspectRatio: String {
            if
                let cache = _standardAspectRatio,
                cache.0 == nativeSize {
                return cache.1
                
            } else {
                let result = base.standardAspectRatio
                _standardAspectRatio = (nativeSize, result)
                return result
            }
        }
        private var _standardAspectRatio: (CGSize, String)?
    }
}

extension UIAdapter.Screen {
    
    /// 当前主屏幕
    public static let main = UIAdapter.Screen(.main)
}

extension UIAdapter.Screen {
    
    public enum Inch: Double {
        case unknown = -1
        case _3_5 = 3.5
        case _4_0 = 4.0
        case _4_7 = 4.7
        case _5_4 = 5.4
        case _5_5 = 5.5
        case _5_8 = 5.8
        case _6_1 = 6.1
        case _6_3 = 6.3
        case _6_5 = 6.5
        case _6_7 = 6.7
        case _6_9 = 6.9
    }
    
    public var inch: Inch {
        switch (nativeSize.width / scale, nativeSize.height / scale, scale) {
        case (320, 480, 2):
            return ._3_5
            
        case (320, 568, 2):
            return ._4_0
            
        case (375, 667, 2):
            return ._4_7
            
        case (360, 780, 3) where UIDevice.iPhoneMini, (375, 812, 3) where UIDevice.iPhoneMini:
            return ._5_4
            
        case (360, 640, 3) where UIDevice.iPhonePlus, (414, 736, 3) where UIDevice.iPhonePlus:
            return ._5_5
        
        case (375, 812, 3):
            return ._5_8
            
        case (414, 896, 2), (390, 844, 3), (393, 852, 3):
            return ._6_1
            
        case (402, 874, 3):
            return ._6_3

        case (414, 896, 3):
            return ._6_5
            
        case (428, 926, 3), (430, 932, 3):
            return ._6_7
            
        case (440, 956, 3):
            return ._6_9
            
        default:
            return .unknown
        }
    }
    
    public enum Level: Int {
        case unknown = -1
        /// 3: 2
        case compact
        /// 16: 9
        case regular
        /// 19.5: 9
        case full
        
        public var isCompact: Bool {
            self == .compact
        }
        
        public var isRegular: Bool {
            self == .regular
        }
        
        public var isFull: Bool {
            self == .full
        }
    }
    
    public var level: Level {
        switch standardAspectRatio {
        case "3:4", "4:3":
            return .compact
            
        case "9:16", "16:9":
            return .regular
        
        case "9:19.5", "19.5:9":
            return .full
            
        default:
            return .unknown
        }
    }
}

extension Int: UIAdapterScreenCompatible {}
extension Bool: UIAdapterScreenCompatible {}
extension Float: UIAdapterScreenCompatible {}
extension Double: UIAdapterScreenCompatible {}
extension String: UIAdapterScreenCompatible {}
extension CGRect: UIAdapterScreenCompatible {}
extension CGSize: UIAdapterScreenCompatible {}
extension CGFloat: UIAdapterScreenCompatible {}
extension CGPoint: UIAdapterScreenCompatible {}
extension UIImage: UIAdapterScreenCompatible {}
extension UIColor: UIAdapterScreenCompatible {}
extension UIFont: UIAdapterScreenCompatible {}
extension UIEdgeInsets: UIAdapterScreenCompatible {}


fileprivate extension UIDevice {
    
    /// 是否使用了降采样
    static var isUsingDownsampling: Bool {
        return iPhoneMini || iPhonePlus
    }
    
    static var iPhoneMini: Bool {
        let temp = ["iPhone13,1", "iPhone14,4"]
        
        switch identifier {
        case "iPhone13,1", "iPhone14,4":
            return true
            
        case "i386", "x86_64", "arm64":
            return temp.contains(ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "")
            
        default:
            return false
        }
    }
    
    static var iPhonePlus: Bool {
        let temp = [
            "iPhone7,1",
            "iPhone8,2",
            "iPhone9,2",
            "iPhone9,4",
            "iPhone10,2",
            "iPhone10,5"
        ]
        
        switch identifier {
        case
            "iPhone7,1",
            "iPhone8,2",
            "iPhone9,2",
            "iPhone9,4",
            "iPhone10,2",
            "iPhone10,5":
            return true
            
        case "i386", "x86_64", "arm64":
            return temp.contains(ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "")
            
        default:
            return false
        }
    }
    
    private static let identifier: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let mirror = Mirror(reflecting: systemInfo.machine)
        
        let identifier = mirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    } ()
}

extension UIScreen {
    
    /// 真实宽高比 例如: iPhone 16 Pro (201:437)
    var aspectRatio: String {
        // 计算宽高比
        let (ratioWidth, ratioHeight) = calculateAspectRatio(
            width: nativeBounds.width,
            height: nativeBounds.height
        )
        return "\(ratioWidth):\(ratioHeight)"
    }
    
    /// 标准宽高比 例如: iPhone 16 Pro (9:19.5)
    var standardAspectRatio: String {
        // 获取近似的标准比例
        return getStandardAspectRatio(
            width: nativeBounds.width,
            height: nativeBounds.height
        )
    }
    
    private func calculateAspectRatio(width: CGFloat, height: CGFloat) -> (Int, Int) {
        // 计算最大公约数（欧几里得算法）
        func gcd(_ a: Int, _ b: Int) -> Int {
            var a = a
            var b = b
            while b != 0 {
                let temp = b
                b = a % b
                a = temp
            }
            return a
        }
        
        let precision: CGFloat = 1000  // 精度倍数
        let widthInt = Int(width * precision)
        let heightInt = Int(height * precision)
        
        let gcdValue = gcd(widthInt, heightInt)
        
        let ratioWidth = widthInt / gcdValue
        let ratioHeight = heightInt / gcdValue
        
        return (ratioWidth, ratioHeight)
    }
    
    private func getStandardAspectRatio(width: CGFloat, height: CGFloat) -> String {
        let aspectRatio = width / height
        
        // 常见的屏幕比例
        let commonRatios: [(ratio: CGFloat, description: String)] = [
            (16.0/9.0, "16:9"),
            (9.0/16.0, "9:16"),
            (4.0/3.0, "4:3"),
            (3.0/4.0, "3:4"),
            (19.5/9.0, "19.5:9"),
            (9.0/19.5, "9:19.5"),
            (2.0/1.0, "2:1"),
            (1.0/2.0, "1:2"),
            (1.0/1.0, "1:1")
        ]
        
        var closestRatio = commonRatios[0]
        var smallestDifference = abs(aspectRatio - closestRatio.ratio)
        
        for ratio in commonRatios {
            let difference = abs(aspectRatio - ratio.ratio)
            if difference < smallestDifference {
                smallestDifference = difference
                closestRatio = ratio
            }
        }
        
        return closestRatio.description
    }
}

#endif
