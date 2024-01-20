import Foundation

public enum OnboardingStateInteractorError: Error {

    case invalidOnboardingState
}

public final class OnboardingStateInteractor: OnboardingStateUseCase {

    private var onboardingStateProvider: OnboardingStateProvider

    public init(onboardingStateProvider: OnboardingStateProvider) {
        self.onboardingStateProvider = onboardingStateProvider
    }

    public func currentState(_ request: OnboardingStateRequest) -> OnboardingStateResponse {
        return OnboardingStateResponse(state: onboardingStateProvider.currentState().rawValue)
    }

    public func update(_ request: OnboardingStateUpdateRequest) throws {
        guard let state = OnboardingState(rawValue: request.state) else { throw OnboardingStateInteractorError.invalidOnboardingState }
        onboardingStateProvider.update(state: state)
    }
}
