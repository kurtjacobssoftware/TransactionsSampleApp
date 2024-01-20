import UIKit
import SwiftUI
import CommonUI

public protocol TransactionListingCoordinatorDependencies: TransactionListingViewModelDependencies,
                                                           TransactionDetailViewModelDependencies { }

public class TransactionListingCoordinator {

    var uiEngineType: UIEngineType

    // MARK: - Navigation

    public private (set) var navigationController: UINavigationController = UINavigationController()

    // MARK: - Variable

    private var dependencies: TransactionListingCoordinatorDependencies

    // MARK: - Initialiser

    public init(dependencies: TransactionListingCoordinatorDependencies, uiEngineType: UIEngineType) {

        self.dependencies = dependencies
        self.uiEngineType = uiEngineType
    }

    // MARK: - Public Function

    public func start() {
        switch uiEngineType {
        case .uikit:
            let viewController = TransactionListingViewController(viewModel: TransactionListingViewModel(dependencies: dependencies))
            viewController.delegate = self
            navigationController.viewControllers = [viewController]
        case .swiftui:
            let view = TransactionListingViewSwiftUI(delegate: self)
                .environmentObject(TransactionListingViewModel(dependencies: dependencies))
            let viewController = UIHostingController(rootView: view)
            viewController.title = "Transactions"
            navigationController.viewControllers = [viewController]
        }
    }

}

// MARK: - Extension

extension TransactionListingCoordinator: TransactionListingViewControllerDelegate {

    public func didSelectTransaction(transaction: TransactionListingViewConfiguration) {
        switch uiEngineType {
        case .uikit:
            let viewController = TransactionDetailViewController(viewModel: TransactionDetailViewModel(id: transaction.id,
                                                                                                       dependencies: dependencies))
            navigationController.pushViewController(viewController, animated: true)
        case .swiftui:
            let view = TransactionDetailViewSwiftUI()
                .environmentObject(TransactionDetailViewModel(id: transaction.id, dependencies: dependencies))
            let viewController = UIHostingController(rootView: view)
            viewController.title = "Transaction Details"
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
