import XCTest

@testable import OnboardingData
@testable import OnboardingDomain
@testable import OnboardingUI

final class OnboardingDomainLayerTests: XCTestCase {

    let provider: OnboardingStateProvider = UserDefaultsOnboardingStateProvider(userDefaults: UserDefaults(suiteName: "TestSuite")!)

    override func setUpWithError() throws {
        UserDefaults().removePersistentDomain(forName: "TestSuite")
    }

    override func tearDownWithError() throws {
        UserDefaults().removePersistentDomain(forName: "TestSuite")
    }

    func testOnboardingUseCase() throws {
        let sut: OnboardingStateUseCase = OnboardingStateInteractor(onboardingStateProvider: provider)

        var state = OnboardingDomain.OnboardingState(rawValue: sut.currentState(OnboardingStateRequest()).state)

        XCTAssertEqual(state, .incomplete)

        try sut.update(OnboardingStateUpdateRequest(state: "complete"))

        state = OnboardingDomain.OnboardingState(rawValue: sut.currentState(OnboardingStateRequest()).state)

        XCTAssertEqual(state, .complete)
    }

}
