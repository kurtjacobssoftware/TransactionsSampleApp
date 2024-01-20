import UIKit
import OnboardingUI
import OnboardingDomain
import TransactionsUI
import CommonUI

public protocol AppCoordinatorDependencies: OnboardingCoordinatorDependencies,
                                            TransactionListingCoordinatorDependencies { }

public class AppCoordinator {

    var uiEngineType: UIEngineType

    // MARK: - Variable

    private var dependencies: AppCoordinatorDependencies
    public private (set) var navigationController: UINavigationController?

    // MARK: - Coordinator

    private var onboardingCoordinator: OnboardingCoordinator?
    private var transactionListingCoordinator: TransactionListingCoordinator?

    // MARK: - Initialiser

    public init(dependencies: AppCoordinatorDependencies,
                uiEngineType: UIEngineType) {
        self.dependencies = dependencies
        self.uiEngineType = uiEngineType
    }

    // MARK: - Public Function

    public func start() {
        let response = dependencies.onboardingStateUseCase.currentState(OnboardingStateRequest())
        let state = OnboardingUI.OnboardingState(rawValue: response.state) ?? .incomplete
        if state == .incomplete {
            onboardingCoordinator = OnboardingCoordinator(dependencies: dependencies, uiEngineType: uiEngineType)
            onboardingCoordinator?.delegate = self
            onboardingCoordinator?.start()
            navigationController = onboardingCoordinator?.navigationController
        } else {
            transactionListingCoordinator = TransactionListingCoordinator(dependencies: dependencies, uiEngineType: uiEngineType)
            transactionListingCoordinator?.start()
            navigationController = transactionListingCoordinator?.navigationController
        }
    }
}

// MARK: - Extension

extension AppCoordinator: OnboardingCoordinatorDelegate {

    public func didCompleteOnboarding(_ coordinator: OnboardingCoordinator) {
        transactionListingCoordinator = TransactionListingCoordinator(dependencies: dependencies, uiEngineType: uiEngineType)
        transactionListingCoordinator?.start()
        guard let window = UIApplication.shared.delegate?.window! else { return }
        window.rootViewController = transactionListingCoordinator?.navigationController
        UIView.transition(with: window, duration: 0.45, options: [.transitionFlipFromLeft], animations: nil)
        onboardingCoordinator = nil
    }
}
