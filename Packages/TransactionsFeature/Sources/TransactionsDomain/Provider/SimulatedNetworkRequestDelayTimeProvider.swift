import Foundation

public protocol SimulatedNetworkDelayTimeProvider {

    func getDelay() -> UInt64
}
