import Foundation

public final class TransactionDetailInteractor: TransactionDetailUseCase {

    private var transactionProvider: TransactionProvider

    public init(transactionProvider: TransactionProvider) {
        self.transactionProvider = transactionProvider
    }

    public func fetchTransactionDetail(_ request: TransactionDetailRequest) async throws -> TransactionDetailResponse? {
        return try await transactionProvider.getTransaction(with: request.id)?.response()
    }
}
