import XCTest
import Combine

@testable import TransactionsData
@testable import TransactionsDomain
@testable import TransactionsUI

final class TransactionsUILayerTests: XCTestCase {

    class TransactionListingViewModelDependenciesTest: TransactionListingViewModelDependencies {

        var transactionsListingUseCase: TransactionListingUseCase

        init(transactionsListingUseCase: TransactionListingUseCase) {
            self.transactionsListingUseCase = transactionsListingUseCase
        }
    }

    class TransactionDetailViewModelDependenciesTest: TransactionDetailViewModelDependencies {

        var transactionDetailUseCase: TransactionDetailUseCase

        init(transactionDetailUseCase: TransactionDetailUseCase) {
            self.transactionDetailUseCase = transactionDetailUseCase
        }
    }

    private let simulatedNetworkDelayProvider = MockSimulatedNetworkDelayTimeProvider()
    private let conditionalSuccessRateProvider = MockConditionalSuccessRateProvider()

    override func setUpWithError() throws { }
    override func tearDownWithError() throws { }

    func testTransactionsListingViewModelSuccess() async throws {

        conditionalSuccessRateProvider.success = true
        simulatedNetworkDelayProvider.delay = 0

        let expectation = XCTestExpectation(description: "Fetch Transactions Successfully")
        var cancelBag: Set<AnyCancellable> = []

        let provider: TransactionProvider = JSONTransactionProvider(conditionalSuccessRateProvider: conditionalSuccessRateProvider,
                                                                    simulatedNetworkDelayTimeProvider: simulatedNetworkDelayProvider)
        let transactionListingUseCase: TransactionListingUseCase = TransactionListingInteractor(transactionProvider: provider)
        let sut = TransactionListingViewModel(dependencies: TransactionListingViewModelDependenciesTest(transactionsListingUseCase: transactionListingUseCase))

        sut.$transactions.dropFirst().sink { transactions in
            XCTAssertEqual(transactions.count, 45)
            expectation.fulfill()
        }.store(in: &cancelBag)

        try await sut.refresh()

        await fulfillment(of: [expectation], timeout: 1)
    }

    func testTransactionsListingViewModelFailed() async throws {

        conditionalSuccessRateProvider.success = false
        simulatedNetworkDelayProvider.delay = 0

        let expectation = XCTestExpectation(description: "Fetch Transactions With Error")
        var cancelBag: Set<AnyCancellable> = []

        let provider: TransactionProvider = JSONTransactionProvider(conditionalSuccessRateProvider: conditionalSuccessRateProvider,
                                                                    simulatedNetworkDelayTimeProvider: simulatedNetworkDelayProvider)
        let transactionListingUseCase: TransactionListingUseCase = TransactionListingInteractor(transactionProvider: provider)
        let sut = TransactionListingViewModel(dependencies: TransactionListingViewModelDependenciesTest(transactionsListingUseCase: transactionListingUseCase))

        sut.$transactions.dropFirst().sink { _ in
            XCTFail("Expect Error")
        }.store(in: &cancelBag)

        sut.$error.dropFirst().sink { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }.store(in: &cancelBag)

        try await sut.refresh()

        await fulfillment(of: [expectation], timeout: 1)
    }

    func testTransactionsListingViewModelSumTotal() async throws {

        conditionalSuccessRateProvider.success = true
        simulatedNetworkDelayProvider.delay = 0

        let expectation = XCTestExpectation(description: "Fetch Transactions Sum Total Successfully")
        var cancelBag: Set<AnyCancellable> = []

        let provider: TransactionProvider = JSONTransactionProvider(conditionalSuccessRateProvider: conditionalSuccessRateProvider,
                                                                    simulatedNetworkDelayTimeProvider: simulatedNetworkDelayProvider)
        let transactionListingUseCase: TransactionListingUseCase = TransactionListingInteractor(transactionProvider: provider)
        let sut = TransactionListingViewModel(dependencies: TransactionListingViewModelDependenciesTest(transactionsListingUseCase: transactionListingUseCase))

        sut.$sumTotal.dropFirst().sink { sumTotal in
            XCTAssertEqual(sumTotal, -1182.59)
            expectation.fulfill()
        }.store(in: &cancelBag)

        try await sut.refresh()

        await fulfillment(of: [expectation], timeout: 1)
    }

    func testTransactionsDetailsViewModelSuccess() async throws {

        conditionalSuccessRateProvider.success = true
        simulatedNetworkDelayProvider.delay = 0

        let expectation = XCTestExpectation(description: "Fetch Transactions Details Successfully")
        var cancelBag: Set<AnyCancellable> = []

        let provider: TransactionProvider = JSONTransactionProvider(conditionalSuccessRateProvider: conditionalSuccessRateProvider,
                                                                    simulatedNetworkDelayTimeProvider: simulatedNetworkDelayProvider)
        let transactionListingUseCase: TransactionListingUseCase = TransactionListingInteractor(transactionProvider: provider)
        let transactionDetailUseCase: TransactionDetailUseCase = TransactionDetailInteractor(transactionProvider: provider)
        let listingViewModel = TransactionListingViewModel(dependencies: TransactionListingViewModelDependenciesTest(transactionsListingUseCase: transactionListingUseCase))
        let sut = TransactionDetailViewModel(id: "D3D8F78368E31201", dependencies: TransactionDetailViewModelDependenciesTest(transactionDetailUseCase: transactionDetailUseCase))

        sut.$transactionsDetail.dropFirst().sink { transactionD3D8F78368E31201 in
            XCTAssertEqual(transactionD3D8F78368E31201?.title, "Birgit Mayer")
            XCTAssertEqual(transactionD3D8F78368E31201?.subtitle, "Miete Februar")
            expectation.fulfill()
        }.store(in: &cancelBag)

        try await listingViewModel.refresh()
        try await sut.refresh()

        await fulfillment(of: [expectation], timeout: 1)
    }
}
