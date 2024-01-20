import Foundation
import TransactionsDomain

public protocol TransactionDetailViewModelDependencies {

    var transactionDetailUseCase: TransactionDetailUseCase { get set }
}

public class TransactionDetailViewModel: ObservableObject {

    // MARK: - Variable

    @Published public private (set) var transactionsDetail: TransactionDetailViewConfiguration?

    private var dependencies: TransactionDetailViewModelDependencies
    private var id: String

    // MARK: - Initialiser

    public init(id: String, dependencies: TransactionDetailViewModelDependencies) {
        self.dependencies = dependencies
        self.id = id
    }

    // MARK: - Public Function

    @MainActor
    public func refresh() async throws {
        transactionsDetail = try await dependencies.transactionDetailUseCase
            .fetchTransactionDetail(TransactionDetailRequest(id: id))?
            .viewConfiguration()
    }
}
