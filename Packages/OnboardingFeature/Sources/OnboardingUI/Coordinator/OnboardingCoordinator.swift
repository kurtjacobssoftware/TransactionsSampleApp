import UIKit
import SwiftUI
import CommonUI

public protocol OnboardingCoordinatorDependencies: OnboardingViewModelDependencies { }

public protocol OnboardingCoordinatorDelegate: AnyObject {

    func didCompleteOnboarding(_ coordinator: OnboardingCoordinator)
}

public class OnboardingCoordinator {

    var uiEngineType: UIEngineType

    // MARK: - ViewController

    private var onboardingViewController: OnboardingViewController?

    // MARK: - Variable

    public weak var delegate: OnboardingCoordinatorDelegate?

    // MARK: - Navigation

    public private (set) var navigationController: UINavigationController = UINavigationController()

    // MARK: - Initialiser

    private var dependencies: OnboardingCoordinatorDependencies

    public init(dependencies: OnboardingCoordinatorDependencies, uiEngineType: UIEngineType) {

        self.dependencies = dependencies
        self.uiEngineType = uiEngineType
    }

    // MARK: - Public Function

    public func start() {
        switch uiEngineType {
        case .uikit:
            let viewController = OnboardingViewController(viewModel: OnboardingViewModel(dependencies: dependencies))
            onboardingViewController = viewController
            viewController.delegate = self
            navigationController.viewControllers = [viewController]
        case .swiftui:
            let view = OnboardingViewSwiftUI(delegate: self).environmentObject(OnboardingViewModel(dependencies: dependencies))
            let viewController = UIHostingController(rootView: view)
            viewController.title = "Onboarding"
            navigationController.viewControllers = [viewController]
        }
    }
}

// MARK: - Extension

extension OnboardingCoordinator: OnboardingViewControllerDelegate {

    public func didCompleteOnboarding() {
        delegate?.didCompleteOnboarding(self)
    }
}
