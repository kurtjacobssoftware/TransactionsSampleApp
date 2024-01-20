import Foundation
import TransactionsDomain
import TransactionsData
import OnboardingDomain
import OnboardingData

final class AppDependencies: AppCoordinatorDependencies {

    // MARK: - Initialiser

    init() { }

    // MARK: - Provider

    private var conditionalSuccessRateProvider: ConditionalSuccessRateProvider = LocalConditionalSuccessRateProvider()
    private var simulatedNetworkDelayTimeProvider: SimulatedNetworkDelayTimeProvider = LocalSimulatedNetworkDelayTimeProvider()
    private lazy var transactionsProvider: TransactionProvider = JSONTransactionProvider(conditionalSuccessRateProvider: conditionalSuccessRateProvider,
                                                                                         simulatedNetworkDelayTimeProvider: simulatedNetworkDelayTimeProvider)
    private var onboardingStateProvider: OnboardingStateProvider = UserDefaultsOnboardingStateProvider()

    // MARK: - UseCase

    lazy var transactionsListingUseCase: TransactionListingUseCase = TransactionListingInteractor(transactionProvider: transactionsProvider)
    lazy var transactionDetailUseCase: TransactionDetailUseCase = TransactionDetailInteractor(transactionProvider: transactionsProvider)
    lazy var onboardingStateUseCase: OnboardingStateUseCase = OnboardingStateInteractor(onboardingStateProvider: onboardingStateProvider)
}
