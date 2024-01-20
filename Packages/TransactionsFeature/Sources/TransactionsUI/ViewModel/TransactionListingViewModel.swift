import Foundation
import TransactionsDomain
import Combine
import SwiftUI

public protocol TransactionListingViewModelDependencies {

    var transactionsListingUseCase: TransactionListingUseCase { get set }
}

public class TransactionListingViewModel: ObservableObject {

    // MARK: - Variable

    @Published public private (set) var isLoading: Bool = false
    @Published public private (set) var transactions: [TransactionListingViewConfiguration] = []
    @Published public private (set) var sumTotal: NSDecimalNumber?
    @Published public var error: Bool = false

    private var dependencies: TransactionListingViewModelDependencies

    // MARK: - Initialiser

    public init(dependencies: TransactionListingViewModelDependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Public Function

    @MainActor
    public func refresh() async throws {
        withAnimation { isLoading = true }
        do {
            transactions = try await dependencies.transactionsListingUseCase.fetchTransactionListing(TransactionListingItemsRequest()).map { $0.uiConfiguration() }
            sumTotal = try await dependencies.transactionsListingUseCase.fetchSumTotal(TransactionListingSumRequest()).total
        } catch { self.error = true }
        withAnimation { isLoading = false }
    }
}
