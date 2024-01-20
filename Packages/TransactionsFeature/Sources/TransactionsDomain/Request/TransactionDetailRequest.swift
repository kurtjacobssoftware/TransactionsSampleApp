import Foundation

public struct TransactionDetailRequest {

    public private (set) var id: String

    public init(id: String) {
        self.id = id
    }
}
