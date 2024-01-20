import XCTest
import Combine

@testable import OnboardingData
@testable import OnboardingDomain
@testable import OnboardingUI

final class OnboardingUILayerTests: XCTestCase {

    let provider: OnboardingStateProvider = UserDefaultsOnboardingStateProvider(userDefaults: UserDefaults(suiteName: "TestSuite")!)

    class ViewModelDepedenciesTest: OnboardingViewModelDependencies {
        var onboardingStateUseCase: OnboardingStateUseCase

        init(onboardingStateUseCase: OnboardingStateUseCase) {
            self.onboardingStateUseCase = onboardingStateUseCase
        }
    }

    override func setUpWithError() throws { UserDefaults().removePersistentDomain(forName: "TestSuite") }
    override func tearDownWithError() throws { UserDefaults().removePersistentDomain(forName: "TestSuite") }

    @MainActor func testOnboardingViewModel() {
        let expectation = XCTestExpectation(description: "Onboarding Completed Successfully")
        var cancelBag: Set<AnyCancellable> = []

        let useCase: OnboardingStateUseCase = OnboardingStateInteractor(onboardingStateProvider: provider)
        let dependencies = ViewModelDepedenciesTest(onboardingStateUseCase: useCase)
        let viewModel = OnboardingViewModel(dependencies: dependencies)

        XCTAssertEqual(viewModel.currentState(), .incomplete)

        viewModel.$isComplete.dropFirst().sink { _ in
            XCTAssertEqual(viewModel.currentState(), .complete)
            expectation.fulfill()
        }.store(in: &cancelBag)

        viewModel.completeOnboarding()

        wait(for: [expectation], timeout: 1)
    }

}
