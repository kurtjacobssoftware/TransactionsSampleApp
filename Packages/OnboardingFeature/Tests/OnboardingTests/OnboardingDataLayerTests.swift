import XCTest

@testable import OnboardingDomain
@testable import OnboardingData
@testable import OnboardingUI

final class OnboardingDataLayerTests: XCTestCase {

    override func setUpWithError() throws {
        UserDefaults().removePersistentDomain(forName: "TestSuite")
    }

    override func tearDownWithError() throws {
        UserDefaults().removePersistentDomain(forName: "TestSuite")
    }

    func testOnboardingCompletion() {
        let sut: OnboardingStateProvider = UserDefaultsOnboardingStateProvider(userDefaults: UserDefaults(suiteName: "TestSuite")!)

        XCTAssertEqual(sut.currentState(), .incomplete)

        sut.update(state: .complete)

        XCTAssertEqual(sut.currentState(), .complete)
    }

}
