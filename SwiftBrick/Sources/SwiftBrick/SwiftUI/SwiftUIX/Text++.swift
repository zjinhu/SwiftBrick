//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftUI

extension Text {
    /// Applies a semi-bold font weight to the text.
    public func semibold() -> Text {
        fontWeight(.semibold)
    }
    
    public func bold() -> Text {
        fontWeight(.bold)
    }
    
    public func medium() -> Text {
        fontWeight(.medium)
    }
}

extension Text {
    /// Applies a linear foreground gradient to the text.
    public func foregroundLinearGradient(
        _ gradient: Gradient,
        startPoint: UnitPoint = .leading,
        endPoint: UnitPoint = .trailing
    ) -> some View {
        overlay(
            LinearGradient(
                gradient: gradient,
                startPoint: startPoint,
                endPoint: endPoint
            )
        )
        .mask(self)
    }
}
