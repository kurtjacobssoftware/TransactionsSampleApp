import Foundation
import TransactionsData
import TransactionsDomain

public class MockConditionalSuccessRateProvider: ConditionalSuccessRateProvider {

    public var success: Bool = false

    public func getConditionalSuccess(failurePercentage: UInt64) -> Bool {
        return success
    }
}
