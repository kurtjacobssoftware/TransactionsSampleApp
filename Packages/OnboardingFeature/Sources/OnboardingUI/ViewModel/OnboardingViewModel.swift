import Foundation
import OnboardingDomain

public protocol OnboardingViewModelDependencies {

    var onboardingStateUseCase: OnboardingStateUseCase { get set }
}

public class OnboardingViewModel: ObservableObject {

    // MARK: - Variable

    @Published public private (set) var isComplete: Bool = false
    @Published public private (set) var error: Error?

    private var dependencies: OnboardingViewModelDependencies

    // MARK: - Initialiser

    public init(dependencies: OnboardingViewModelDependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Public Function

    @MainActor
    public func completeOnboarding() {
        Task {
            do {
                try dependencies.onboardingStateUseCase.update(OnboardingStateUpdateRequest(state: OnboardingState.complete.rawValue))
                isComplete = true
            } catch {
                self.error = error
            }
        }
    }

    public func currentState() -> OnboardingState {
        let response = dependencies.onboardingStateUseCase.currentState(OnboardingStateRequest())
        return OnboardingState(rawValue: response.state) ?? .incomplete
    }
}
