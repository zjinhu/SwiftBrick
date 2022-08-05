
import UIKit

extension UIView {
    
    public static let classInit: Void = {
        let originalSelector = #selector(layoutSubviews)
        let swizzledSelector = #selector(swizzled_layoutSubviews)
        swizzling(UIView.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
    
    @objc func swizzled_layoutSubviews() {
        swizzled_layoutSubviews();
        
        let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
        if(Params.active[tmpAddress] == true) {
            setup()
        }
    }
    
    struct Params {
        ///阴影开关
        static var active = [String:Bool]()
        ///圆角
        static var cornerRadius = [String:CGFloat]()
        ///左侧圆角
        static var cornersLeft = [String:Bool]()
        ///右侧圆角
        static var cornersRight = [String:Bool]()
        ///反转阴影
        static var reverse = [String:Bool]()
        
        static var darkShadowColor = [String:UIColor]()
        static var lightShadowColor = [String:UIColor]()
        static var shadowDarkOffsetX = [String:CGFloat]()
        static var shadowDarkOffsetY = [String:CGFloat]()
        static var shadowLightOffsetX = [String:CGFloat]()
        static var shadowLightOffsetY = [String:CGFloat]()
        static var shadowRadius = [String:CGFloat]()

    }
    
    ///阴影开关
    public var active: Bool {
        set (active) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            Params.active[tmpAddress] = active
        }

        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return Params.active[tmpAddress] ?? true
        }
    }
    
    ///圆角
    public var cornerRadius: CGFloat {
        set (radius) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            Params.cornerRadius[tmpAddress] = radius
        }

        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return Params.cornerRadius[tmpAddress] ?? 0.0
        }
    }
    
    
    ///阴影角
    public var shadowRadius: CGFloat {
        set (radius) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            Params.shadowRadius[tmpAddress] = radius
        }

        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return Params.shadowRadius[tmpAddress] ?? 4.0
        }
    }
    
    ///左侧圆角
    public var cornersLeft: Bool {
        set (cornersLeft) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            Params.cornersLeft[tmpAddress] = cornersLeft
        }

        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return Params.cornersLeft[tmpAddress] ?? true
        }
    }
    
    ///右侧圆角
    public var cornersRight: Bool {
        set (cornersRight) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            Params.cornersRight[tmpAddress] = cornersRight
        }

        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return Params.cornersRight[tmpAddress] ?? true
        }
    }
    
    ///反转阴影，反转未按下与按下的阴影位置
    public var reverse: Bool {
        set (reverse) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            Params.reverse[tmpAddress] = reverse
        }

        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return Params.reverse[tmpAddress] ?? false
        }
    }

    public var shadowDarkOffsetX: CGFloat{
        set (shadowDarkOffsetX) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            Params.shadowDarkOffsetX[tmpAddress] = shadowDarkOffsetX
        }

        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return Params.shadowDarkOffsetX[tmpAddress] ?? 2.0
        }
    }
 
    public var shadowDarkOffsetY: CGFloat {
        set (shadowDarkOffsetY) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            Params.shadowDarkOffsetY[tmpAddress] = shadowDarkOffsetY
        }

        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return Params.shadowDarkOffsetY[tmpAddress] ?? 2.0
        }
    }
 
    public var shadowLightOffsetX: CGFloat {
        set (shadowLightOffsetX) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            Params.shadowLightOffsetX[tmpAddress] = shadowLightOffsetX
        }

        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return Params.shadowLightOffsetX[tmpAddress] ?? 2.0
        }
    }
 
    public var shadowLightOffsetY: CGFloat {
        set (shadowLightOffsetY) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            Params.shadowLightOffsetY[tmpAddress] = shadowLightOffsetY
        }

        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return Params.shadowLightOffsetY[tmpAddress] ?? 2.0
        }
    }
 
    public var darkShadowColor: UIColor {
        set (darkShadowColor) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            Params.darkShadowColor[tmpAddress] = darkShadowColor
        }

        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return Params.darkShadowColor[tmpAddress] ?? UIColor.black
        }
    }
 
    public var lightShadowColor: UIColor {
        set (lightShadowColor) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            Params.lightShadowColor[tmpAddress] = lightShadowColor
        }

        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return Params.lightShadowColor[tmpAddress] ?? UIColor.black
        }
    }

    open func setup() {
        let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))

        if(Params.active[tmpAddress] != true){
            return
        }
        
        var shadowLayerDark: CAShapeLayer = CAShapeLayer()
        var shadowLayerLight: CAShapeLayer = CAShapeLayer()
        
        var hasDark = false
        var hasLight = false
        for item in self.layer.sublayers! {
            if item.name == "shadowDark" {
                shadowLayerDark = item as! CAShapeLayer
                hasDark = true
            }
            if item.name == "shadowLight" {
                shadowLayerLight = item as! CAShapeLayer
                hasLight = true
            }
        }

        var corners:UIRectCorner = UIRectCorner()
        
        if let cornersLeft = Params.cornersLeft[tmpAddress], cornersLeft == true{
                corners.insert(.topLeft)
                corners.insert(.bottomLeft)
        }else{
            corners.insert(.topLeft)
            corners.insert(.bottomLeft)
        }
        
        if let cornersRight = Params.cornersLeft[tmpAddress], cornersRight == true{
                corners.insert(.topRight)
                corners.insert(.bottomRight)
        }else{
            corners.insert(.topRight)
            corners.insert(.bottomRight)
        }
        
        cornerRadius = Params.cornerRadius[tmpAddress] ?? 0.0
        shadowRadius = Params.shadowRadius[tmpAddress] ?? 4.0
        
        if(!hasDark) {
            shadowLayerDark.name = "shadowDark"
            layer.insertSublayer(shadowLayerDark, at: 0)
            let content:CAShapeLayer = CAShapeLayer()
            content.frame = bounds
            content.backgroundColor = backgroundColor?.cgColor
            roundCorners(layer:content, corners: corners, radius: cornerRadius)
            content.masksToBounds = true
            shadowLayerDark.addSublayer(content)
        }
        
        shadowLayerDark.frame = bounds
        shadowLayerDark.shadowRadius = shadowRadius
        shadowLayerDark.shadowOpacity = 1
        
        let reverse: CGFloat = Params.reverse[tmpAddress] == true ? -1.0 : 1.0

        let darkOffsetX: CGFloat = Params.shadowDarkOffsetX[tmpAddress] ?? 2.0
        let darkOffsetY: CGFloat = Params.shadowDarkOffsetY[tmpAddress] ?? 2.0
        shadowLayerDark.shadowOffset = CGSize( width: reverse*darkOffsetX, height: reverse*darkOffsetY)
        
        if let darkShadowColor = Params.darkShadowColor[tmpAddress]{
            shadowLayerDark.shadowColor = darkShadowColor.cgColor
        }else{
            shadowLayerDark.shadowColor = UIColor(red: 8/255, green: 8/255, blue: 33/255, alpha: 0.12).cgColor
        }
        
        if(!hasLight) {
            shadowLayerLight.name = "shadowLight"
            layer.insertSublayer(shadowLayerLight, at: 0)
            let content:CAShapeLayer = CAShapeLayer()
            content.frame = bounds
            content.backgroundColor = backgroundColor?.cgColor
            
            roundCorners(layer:content, corners: corners, radius: Params.cornerRadius[tmpAddress]!)
            content.masksToBounds = true
            shadowLayerLight.addSublayer(content)
        }
        
        shadowLayerLight.frame = bounds
        shadowLayerLight.shadowRadius = shadowRadius
        shadowLayerLight.shadowOpacity = 1
        
        let lightOffsetX:CGFloat = Params.shadowLightOffsetX[tmpAddress] ?? 2.0
        let lightOffsetY:CGFloat = Params.shadowLightOffsetY[tmpAddress] ?? 2.0
        shadowLayerLight.shadowOffset = CGSize( width: reverse*lightOffsetX, height: reverse*lightOffsetY)

        if let lightShadowColor = Params.lightShadowColor[tmpAddress]{
            shadowLayerLight.shadowColor = lightShadowColor.cgColor
        }else{
            shadowLayerLight.shadowColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7).cgColor
        }
        
        self.backgroundColor = UIColor.clear
    }
    
    open func delete() {
        if(self.layer.sublayers != nil){
            for item in self.layer.sublayers! {
                if item.name == "shadowDark" {
                    self.backgroundColor = UIColor(cgColor: item.sublayers![0].backgroundColor!);
                    item.removeFromSuperlayer();
                }
                if item.name == "shadowLight" {
                    self.backgroundColor = UIColor(cgColor: item.sublayers![0].backgroundColor!);
                    item.removeFromSuperlayer();
                }
            }
        }
    }
    
    func roundCorners(layer: CALayer, corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: layer.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.backgroundColor = UIColor.red.cgColor
        mask.path = path.cgPath
        layer.mask = mask
    }
    
}

// MARK: ===================================工厂类:按钮 圆角 阴影=========================================
extension UIButton {
    
    struct ButtonParams {
        ///触感反馈
        static var hapticLevel = [String:Int]()        //0: disabled; 1: light; 2: medium; 3: heavy light; 4: soft; 5: rigid (4 - 5 only iOS 13)
        ///是否可选中
        static var isToggle = [String:Bool]()
        ///非选中模式背景色
        static var normalColor = [String:UIColor]()
        ///选中模式背景色
        static var highligthColor = [String:UIColor]()

    }

    ///触感反馈--shadow工具
    public var hapticLevel: Int {
        set (hapticLevel) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            ButtonParams.hapticLevel[tmpAddress] = hapticLevel
        }
        
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return ButtonParams.hapticLevel[tmpAddress] ?? 0
        }
    }
    
    ///是否可选中--shadow工具
    public var isToggle: Bool {
        set (isToggle) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            ButtonParams.isToggle[tmpAddress] = isToggle
        }
        
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return ButtonParams.isToggle[tmpAddress] ?? true
        }
    }
    
    /// 阴影模式下按钮普通模式背景色--shadow工具
    public var normalColor: UIColor {
        set (normalColor) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            ButtonParams.normalColor[tmpAddress] = normalColor
        }

        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return ButtonParams.normalColor[tmpAddress] ?? UIColor.black
        }
    }
    
    /// 阴影模式下按钮选中背景色--shadow工具
    public var highligthColor: UIColor {
        set (highligthColor) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            ButtonParams.highligthColor[tmpAddress] = highligthColor
        }

        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return ButtonParams.highligthColor[tmpAddress] ?? UIColor.black
        }
    }
    
    @objc open override func draw(_ rect: CGRect) {
        super.draw(rect)
        let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
        if(Params.active[tmpAddress] == true){
            setupShadows()
        }
        self.backgroundColor = UIColor.clear
    }
    
    open func setupShadows() {
        var shadowLayerDark: CAShapeLayer = CAShapeLayer()
        var shadowLayerLight: CAShapeLayer = CAShapeLayer()
        var hasDark = false
        var hasLight = false
        for item in self.layer.sublayers! {
            if item.name == "shadowDark" {
                shadowLayerDark = item as! CAShapeLayer
                hasDark = true
            }
            if item.name == "shadowLight" {
                shadowLayerLight = item as! CAShapeLayer
                hasLight = true
            }
        }
        
        let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
        
        var corners: UIRectCorner = UIRectCorner()
        
        if let cornersLeft = Params.cornersLeft[tmpAddress], cornersLeft == true{
                corners.insert(.topLeft)
                corners.insert(.bottomLeft)
        }else{
            corners.insert(.topLeft)
            corners.insert(.bottomLeft)
        }
        
        if let cornersRight = Params.cornersLeft[tmpAddress], cornersRight == true{
                corners.insert(.topRight)
                corners.insert(.bottomRight)
        }else{
            corners.insert(.topRight)
            corners.insert(.bottomRight)
        }
        
        var bgColor: UIColor? = backgroundColor
        
        if let color = ButtonParams.normalColor[tmpAddress] {
            bgColor = color
        }
        
        cornerRadius = Params.cornerRadius[tmpAddress] ?? 0.0
        shadowRadius = Params.shadowRadius[tmpAddress] ?? 4.0
        
        if(!hasDark) {
            shadowLayerDark.name = "shadowDark"
            layer.insertSublayer(shadowLayerDark, at: 0)
            let content:CAShapeLayer = CAShapeLayer()
            content.frame = bounds
            content.backgroundColor = bgColor?.cgColor
            roundCorners(layer:content, corners: corners, radius: cornerRadius)
            content.masksToBounds = true
            shadowLayerDark.addSublayer(content)
        }
        shadowLayerDark.frame = bounds
        shadowLayerDark.shadowRadius = shadowRadius
        shadowLayerDark.shadowOpacity = 1
        
        let reverse: CGFloat = Params.reverse[tmpAddress] == true ? -1.0 : 1.0
        
        let darkOffsetX: CGFloat = Params.shadowDarkOffsetX[tmpAddress] ?? 2.0
        let darkOffsetY: CGFloat = Params.shadowDarkOffsetY[tmpAddress] ?? 2.0
        shadowLayerDark.shadowOffset = CGSize( width: reverse*darkOffsetX, height: reverse*darkOffsetY)
        if(isEnabled){
            if let darkShadowColor = Params.darkShadowColor[tmpAddress]{
                shadowLayerDark.shadowColor = darkShadowColor.cgColor
            }else{
                shadowLayerDark.shadowColor = UIColor(red: 8/255, green: 8/255, blue: 33/255, alpha: 0.12).cgColor
            }
        }else{
            shadowLayerDark.shadowColor = UIColor.clear.cgColor
        }
        
        if(!hasLight) {
            shadowLayerLight.name = "shadowLight"
            layer.insertSublayer(shadowLayerLight, at: 0)
            let content:CAShapeLayer = CAShapeLayer()
            content.frame = bounds
            content.backgroundColor = bgColor?.cgColor
            
            roundCorners(layer:content, corners: corners, radius: cornerRadius)
            content.masksToBounds = true
            shadowLayerLight.addSublayer(content)
        }
        shadowLayerLight.frame = bounds
        shadowLayerLight.shadowRadius = shadowRadius
        shadowLayerLight.shadowOpacity = 1
        
        let lightOffsetX: CGFloat = Params.shadowLightOffsetX[tmpAddress] ?? 2.0
        let lightOffsetY: CGFloat = Params.shadowLightOffsetY[tmpAddress] ?? 2.0
        shadowLayerLight.shadowOffset = CGSize( width: reverse*lightOffsetX, height: reverse*lightOffsetY)
        if(isEnabled){
            if let lightShadowColor = Params.lightShadowColor[tmpAddress]{
                shadowLayerLight.shadowColor = lightShadowColor.cgColor
            }else{
                shadowLayerLight.shadowColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7).cgColor
            }
        }else{
            shadowLayerLight.shadowColor = UIColor.clear.cgColor
        }

    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
        if(Params.active[tmpAddress] != true){
            super.touchesBegan(touches, with: event)
            return
        }
        
        if(Params.active[tmpAddress] == true){
            Params.reverse[tmpAddress] = (Params.reverse[tmpAddress] != nil) ? !Params.reverse[tmpAddress]! : true
            setupShadows()
        }
        
        var bgColor: UIColor? = backgroundColor
        if let color = ButtonParams.normalColor[tmpAddress] {
            bgColor = color
        }
        
        var fgColor: UIColor? = backgroundColor
        if let color = ButtonParams.highligthColor[tmpAddress] {
            fgColor = color
        }
        
        let isToggle = ButtonParams.isToggle[tmpAddress] ?? false

        
        if isToggle {
            isSelected = !isSelected
            if isSelected {
                layer.sublayers?.forEach({ item in
                    if item.name == "shadowDark" {
                        item.sublayers?.first?.backgroundColor = fgColor?.cgColor
                    }
                    if item.name == "shadowLight" {
                        item.sublayers?.first?.backgroundColor = fgColor?.cgColor
                    }
                })
            }else{
                layer.sublayers?.forEach({ item in
                    if item.name == "shadowDark" {
                        item.sublayers?.first?.backgroundColor = bgColor?.cgColor
                    }
                    if item.name == "shadowLight" {
                        item.sublayers?.first?.backgroundColor = bgColor?.cgColor
                    }
                })
            }
        }
        
        if let hapticLevel = ButtonParams.hapticLevel[tmpAddress] , hapticLevel != 0{
                let force: UIImpactFeedbackGenerator.FeedbackStyle = UIImpactFeedbackGenerator.FeedbackStyle(rawValue: hapticLevel-1)!
                UIImpactFeedbackGenerator(style: force).impactOccurred()
        }
        

        super.touchesBegan(touches, with: event)
        
    }

    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
        
        if(Params.active[tmpAddress] != true){
            super.touchesEnded(touches, with: event)
            return
        }
        
        let isToggle = ButtonParams.isToggle[tmpAddress] ?? false
 
        if(Params.active[tmpAddress] == true){
            if(!isToggle){
                Params.reverse[tmpAddress] = (Params.reverse[tmpAddress] != nil) ? !Params.reverse[tmpAddress]! : false
                setupShadows()
            }
        }
        
        super.touchesEnded(touches, with: event)
    }

    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
        
        if(Params.active[tmpAddress] != true){
            super.touchesCancelled(touches, with: event)
            return
        }
        
        let isToggle = ButtonParams.isToggle[tmpAddress] ?? false
        
        
        if(Params.active[tmpAddress] == true){
            if(!isToggle){
                Params.reverse[tmpAddress] = (Params.reverse[tmpAddress] != nil) ? !Params.reverse[tmpAddress]! : false
                setupShadows()
            }
        }
        
        super.touchesCancelled(touches, with: event)
    }
    
}
