import Foundation

public struct OnboardingStateUpdateRequest {

    public private (set) var state: String

    public init(state: String) {
        self.state = state
    }
}
