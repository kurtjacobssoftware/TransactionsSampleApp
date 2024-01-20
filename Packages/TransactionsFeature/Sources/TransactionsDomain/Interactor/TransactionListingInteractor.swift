import Foundation

public final class TransactionListingInteractor: TransactionListingUseCase {

    private var transactionProvider: TransactionProvider

    public init(transactionProvider: TransactionProvider) {
        self.transactionProvider = transactionProvider
    }

    public func fetchTransactionListing(_ request: TransactionListingItemsRequest) async throws -> [TransactionListingItemsResponse] {
        return try await transactionProvider.getAllTransactions(invalidatesCache: true).map { $0.response() }
    }

    public func fetchSumTotal(_ request: TransactionListingSumRequest) async throws -> TransactionListingSumResponse {
        let transactions = try await transactionProvider.getAllTransactions(invalidatesCache: false)
        return TransactionListingSumResponse(total: transactions.reduce(0, { $0.adding($1.amount.decimalValue) }))
    }
}
