import SwiftUI

struct UseNavigationStackPolicyKey: EnvironmentKey {
    static let defaultValue = UseNavigationStackPolicy.never
}

struct IsWithinNavigationStackKey: EnvironmentKey {
    static let defaultValue = false
}

@available(iOS 13.0, *)
extension EnvironmentValues {
    var useNavigationStack: UseNavigationStackPolicy {
        get { self[UseNavigationStackPolicyKey.self] }
        set { self[UseNavigationStackPolicyKey.self] = newValue }
    }
    
    var isWithinNavigationStack: Bool {
        get { self[IsWithinNavigationStackKey.self] }
        set { self[IsWithinNavigationStackKey.self] = newValue }
    }
}
