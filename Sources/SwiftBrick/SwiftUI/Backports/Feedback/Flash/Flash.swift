import SwiftUI

@available(iOS 14, *)
public extension AnyFeedback {
    /// Specifies feedback that flashes the screen
    static var flash: Self {
        .init(Flash(color: .accentColor, duration: 0.15))
    }

    /// Specifies feedback that flashes the screen
    /// - Parameters:
    ///   - color: The color to use for the flash
    ///   - duration: The animation duration for the flash
    static func flash(_ color: Color, duration: Double = 0.15) -> Self {
        .init(Flash(color: color, duration: duration))
    }
}

@available(iOS 14, *)
private struct Flash: Feedback {
    var color: Color
    var duration: Double
    
    @MainActor
    func perform() async {
#if os(iOS)
        guard
            let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
            let window = scene.windows.first else { return }
        
        let view = UIView()
        view.backgroundColor = UIColor(color)
        window.addSubview(view)
        view.frame = window.bounds
        view.alpha = 0
        view.layer.compositingFilter = filters[7]
        
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut, .allowUserInteraction]) { 
            view.alpha = 0.85
        } completion: { _ in
            UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut, .allowUserInteraction, .allowAnimatedContent]) { 
                view.alpha = 0
            } completion: { _ in
                view.removeFromSuperview()
            }
        }
#else
#warning("macOS flash not implemented")
#endif
    }

    let filters = [
        "addition",
        "maximum",
        "minimum",
        "multiply",
        "sourceAtop",
        "sourceIn",
        "sourceOut",
        "sourceOver" // 7
    ]

    let blendModes = [
        "colorBlendMode",
        "colorBurnBlendMode",
        "colorDodgeBlendMode",
        "darkenBlendMode", // 3
        "differenceBlendMode",
        "divideBlendMode",
        "exclusionBlendMode",
        "hardLightBlendMode",
        "hueBlendMode",
        "lightenBlendMode",
        "linearBurnBlendMode", // 10
        "linearDodgeBlendMode",
        "linearLightBlendMode",
        "luminosityBlendMode",
        "multiplyBlendMode", // 14
        "overlayBlendMode",
        "pinLightBlendMode",
        "saturationBlendMode",
        "screenBlendMode",
        "softLightBlendMode",
        "subtractBlendMode",
        "vividLightBlendMode" // 21
    ]
}
