import Foundation
import SwiftUI

/// Modifier for appending a new destination builder.
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
struct DestinationBuilderModifier<TypedData>: ViewModifier {
    let typedDestinationBuilder: DestinationBuilder<TypedData>
    
    @EnvironmentObject var destinationBuilder: DestinationBuilderHolder
    
    func body(content: Content) -> some View {
        destinationBuilder.appendBuilder(typedDestinationBuilder)
        
        return content
            .environmentObject(destinationBuilder)
    }
}
