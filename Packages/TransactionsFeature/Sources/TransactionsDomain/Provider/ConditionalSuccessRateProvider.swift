import Foundation

public protocol ConditionalSuccessRateProvider {

    func getConditionalSuccess(failurePercentage: UInt64) -> Bool
}
