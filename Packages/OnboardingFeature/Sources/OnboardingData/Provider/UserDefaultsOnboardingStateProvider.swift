import Foundation
import OnboardingDomain

public final class UserDefaultsOnboardingStateProvider: OnboardingStateProvider {

    private var userDefaults: UserDefaults

    // MARK: - Initialiser

    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    // MARK: - Public Function

    public func update(state: OnboardingState) {
        userDefaults.set(state.rawValue, forKey: "onboardingState")
    }

    public func currentState() -> OnboardingState {
        guard let rawValue = userDefaults.string(forKey: "onboardingState") else { return .incomplete }
        return OnboardingState(rawValue: rawValue) ?? .incomplete
    }
}
