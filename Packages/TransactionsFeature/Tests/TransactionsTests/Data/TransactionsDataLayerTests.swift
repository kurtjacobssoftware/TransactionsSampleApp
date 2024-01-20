import XCTest
import Combine

@testable import TransactionsData
@testable import TransactionsDomain
@testable import TransactionsUI

final class TransactionsDataLayerTests: XCTestCase {

    private let conditionalSuccessRateProvider = MockConditionalSuccessRateProvider()
    private let simulatedNetworkDelayProvider = MockSimulatedNetworkDelayTimeProvider()

    override func setUpWithError() throws { }
    override func tearDownWithError() throws { }

    func testFetchAllTransactionsSuccess() async throws {
        conditionalSuccessRateProvider.success = true
        simulatedNetworkDelayProvider.delay = 0

        let sut: TransactionProvider = JSONTransactionProvider(conditionalSuccessRateProvider: conditionalSuccessRateProvider,
                                                               simulatedNetworkDelayTimeProvider: simulatedNetworkDelayProvider)

        let transactions = try await sut.getAllTransactions(invalidatesCache: true)

        XCTAssertEqual(transactions.count, 45)
    }

    func testFetchAllTransactionsError() async throws {
        conditionalSuccessRateProvider.success = false
        simulatedNetworkDelayProvider.delay = 0

        let sut: TransactionProvider = JSONTransactionProvider(conditionalSuccessRateProvider: conditionalSuccessRateProvider,
                                                               simulatedNetworkDelayTimeProvider: simulatedNetworkDelayProvider)

        do {
            _ = try await sut.getAllTransactions(invalidatesCache: true)
            XCTFail("Error should be captured.")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func testFetchSingleTransactionSuccess() async throws {
        conditionalSuccessRateProvider.success = true
        simulatedNetworkDelayProvider.delay = 0

        let sut: TransactionProvider = JSONTransactionProvider(conditionalSuccessRateProvider: conditionalSuccessRateProvider,
                                                               simulatedNetworkDelayTimeProvider: simulatedNetworkDelayProvider)

        _ = try await sut.getAllTransactions(invalidatesCache: true)
        let transactionD3D8F78368E31201 = try await sut.getTransaction(with: "D3D8F78368E31201")

        XCTAssertEqual(transactionD3D8F78368E31201?.title, "Birgit Mayer")
        XCTAssertEqual(transactionD3D8F78368E31201?.subtitle, "Miete Februar")
        XCTAssertEqual(transactionD3D8F78368E31201?.amount.decimalValue.stringValue, "435")
        XCTAssertEqual(transactionD3D8F78368E31201?.additionalTexts.lineItems, [])
    }

}
