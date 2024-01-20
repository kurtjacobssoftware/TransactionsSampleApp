import Foundation
import TransactionsDomain

public final class LocalSimulatedNetworkDelayTimeProvider: SimulatedNetworkDelayTimeProvider {

    // MARK: - Initialiser

    public init() {}

    // MARK: - Public Function

    public func getDelay() -> UInt64 {
        return UInt64.random(in: 0..<5_000_000_000)
    }
}
