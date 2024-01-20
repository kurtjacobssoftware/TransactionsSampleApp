import Foundation

public protocol TransactionDetailUseCase {

    func fetchTransactionDetail(_ request: TransactionDetailRequest) async throws -> TransactionDetailResponse?
}
