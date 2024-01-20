import Foundation
import TransactionsData
import TransactionsDomain

public class MockSimulatedNetworkDelayTimeProvider: SimulatedNetworkDelayTimeProvider {

    public var delay: UInt64 = 0

    public func getDelay() -> UInt64 {
        return delay
    }
}
