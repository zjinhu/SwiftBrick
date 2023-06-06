import Foundation
import SwiftUI

/// An object that publishes changes to the path Array it holds.
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
class NavigationPathHolder: ObservableObject {
    @Published var path: [AnyHashable] = []
}
