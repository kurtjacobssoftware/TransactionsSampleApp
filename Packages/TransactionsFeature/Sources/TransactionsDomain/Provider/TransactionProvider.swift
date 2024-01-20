import Foundation

public protocol TransactionProvider {

    func getAllTransactions(invalidatesCache: Bool) async throws -> [Transaction]
    func getTransaction(with id: String) async throws -> Transaction?
}
