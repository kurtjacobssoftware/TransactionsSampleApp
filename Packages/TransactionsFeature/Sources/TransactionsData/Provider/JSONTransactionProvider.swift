import Foundation
import TransactionsDomain

public class JSONTransactionProvider: TransactionProvider {

    // MARK: - Variable

    private var conditionalSuccessRateProvider: ConditionalSuccessRateProvider
    private var simulatedNetworkDelayTimeProvider: SimulatedNetworkDelayTimeProvider

    // Naive Cache
    private var cache: [Transaction] = []

    // MARK: - Initialiser

    public init(conditionalSuccessRateProvider: ConditionalSuccessRateProvider,
                simulatedNetworkDelayTimeProvider: SimulatedNetworkDelayTimeProvider) {
        self.conditionalSuccessRateProvider = conditionalSuccessRateProvider
        self.simulatedNetworkDelayTimeProvider = simulatedNetworkDelayTimeProvider
    }

    // MARK: - Public Function

    public func getAllTransactions(invalidatesCache: Bool) async throws -> [Transaction] {
        if !cache.isEmpty && !invalidatesCache {
            return cache
        }

        let simulatedNetworkDelayTime = simulatedNetworkDelayTimeProvider.getDelay()
        try await Task.sleep(nanoseconds: simulatedNetworkDelayTime)
        let isRequestSuccessful = conditionalSuccessRateProvider.getConditionalSuccess(failurePercentage: 25)
        if !isRequestSuccessful {
            throw JSONTransactionProviderError.randomError
        } else {
            let transactions = loadTransactionJSON().map { $0.entity() }
            cache = transactions
            return transactions
        }
    }

    public func getTransaction(with id: String) async throws -> Transaction? {
        return try await getAllTransactions(invalidatesCache: false).first { $0.id == id }
    }

    // MARK: - Private Function

    private func loadTransactionJSON() -> [TransactionDTO] {
        let file = Bundle.module.path(forResource: "transactions", ofType: "json")!
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: file), options: [])
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .millisecondsSince1970
            let transactionResponse = try decoder.decode(TransactionResponseDTO.self, from: data)
            return transactionResponse.collection
        } catch let error {
            assertionFailure("Got error \(error) while parsing transactions.")
            return [TransactionDTO]()
        }
    }
}
