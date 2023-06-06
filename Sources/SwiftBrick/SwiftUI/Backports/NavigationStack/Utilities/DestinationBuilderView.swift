import Foundation
import SwiftUI

/// Builds a view from the given Data, using the destination builder environment object.
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
struct DestinationBuilderView<Data>: View {
    let data: Data
    
    @EnvironmentObject var destinationBuilder: DestinationBuilderHolder
    
    var body: some View {
        return destinationBuilder.build(data)
    }
}
