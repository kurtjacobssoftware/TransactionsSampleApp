import Foundation

public protocol OnboardingStateProvider {

    func currentState() -> OnboardingState
    func update(state: OnboardingState)
}
