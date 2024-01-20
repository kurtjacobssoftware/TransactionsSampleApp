import Foundation
import TransactionsDomain

public final class LocalConditionalSuccessRateProvider: ConditionalSuccessRateProvider {

    // MARK: - Initialiser

    public init() {}

    // MARK: - Public Function

    public func getConditionalSuccess(failurePercentage: UInt64) -> Bool {
        let successRate = UInt64.random(in: 0..<100)
        switch successRate {
        case 0..<failurePercentage:
            return false
        default:
            return true
        }
    }
}
