import Foundation

public protocol TransactionListingUseCase {

    func fetchTransactionListing(_ request: TransactionListingItemsRequest) async throws -> [TransactionListingItemsResponse]
    func fetchSumTotal(_ request: TransactionListingSumRequest) async throws -> TransactionListingSumResponse
}
