import Foundation
import XCTest
import Combine

@testable import TransactionsData
@testable import TransactionsDomain
@testable import TransactionsUI

final class TransactionsDomainLayerTests: XCTestCase {

    private let simulatedNetworkDelayProvider = MockSimulatedNetworkDelayTimeProvider()
    private let conditionalSuccessRateProvider = MockConditionalSuccessRateProvider()

    override func setUpWithError() throws { }
    override func tearDownWithError() throws { }

    func testTransactionsListingUseCaseSuccess() async throws {
        conditionalSuccessRateProvider.success = true
        simulatedNetworkDelayProvider.delay = 0

        let provider: TransactionProvider = JSONTransactionProvider(conditionalSuccessRateProvider: conditionalSuccessRateProvider,
                                                                    simulatedNetworkDelayTimeProvider: simulatedNetworkDelayProvider)
        let sut: TransactionListingUseCase = TransactionListingInteractor(transactionProvider: provider)

        let transactions = try await sut.fetchTransactionListing(TransactionListingItemsRequest())

        XCTAssertEqual(transactions.count, 45)
    }

    func testTransactionsListingUseCaseFailed() async throws {
        conditionalSuccessRateProvider.success = false
        simulatedNetworkDelayProvider.delay = 0

        let provider: TransactionProvider = JSONTransactionProvider(conditionalSuccessRateProvider: conditionalSuccessRateProvider,
                                                                    simulatedNetworkDelayTimeProvider: simulatedNetworkDelayProvider)
        let sut: TransactionListingUseCase = TransactionListingInteractor(transactionProvider: provider)

        do {
            _ = try await sut.fetchTransactionListing(TransactionListingItemsRequest())
            XCTFail("Error should be captured.")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func testTransactionsListingSumTotalSuccess() async throws {
        conditionalSuccessRateProvider.success = true
        simulatedNetworkDelayProvider.delay = 0

        let provider: TransactionProvider = JSONTransactionProvider(conditionalSuccessRateProvider: conditionalSuccessRateProvider,
                                                                    simulatedNetworkDelayTimeProvider: simulatedNetworkDelayProvider)
        let sut: TransactionListingUseCase = TransactionListingInteractor(transactionProvider: provider)

        let transactionsSumTotal = try await sut.fetchSumTotal(TransactionListingSumRequest())

        XCTAssertEqual(transactionsSumTotal.total, -1182.59)
    }

    func testTransactionsDetailsUseCaseSuccess() async throws {
        conditionalSuccessRateProvider.success = true
        simulatedNetworkDelayProvider.delay = 0

        let provider: TransactionProvider = JSONTransactionProvider(conditionalSuccessRateProvider: conditionalSuccessRateProvider,
                                                                    simulatedNetworkDelayTimeProvider: simulatedNetworkDelayProvider)
        let listingUseCase: TransactionListingUseCase = TransactionListingInteractor(transactionProvider: provider)
        let sut: TransactionDetailUseCase = TransactionDetailInteractor(transactionProvider: provider)

        _ = try await listingUseCase.fetchTransactionListing(TransactionListingItemsRequest())
        let transactionD3D8F78368E31201 = try await sut.fetchTransactionDetail(TransactionDetailRequest(id: "D3D8F78368E31201"))

        XCTAssertEqual(transactionD3D8F78368E31201?.title, "Birgit Mayer")
        XCTAssertEqual(transactionD3D8F78368E31201?.subtitle, "Miete Februar")
    }

}
