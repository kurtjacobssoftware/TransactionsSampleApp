import Foundation

public protocol OnboardingStateUseCase {

    func currentState(_ request: OnboardingStateRequest) -> OnboardingStateResponse
    func update(_ request: OnboardingStateUpdateRequest) throws
}
