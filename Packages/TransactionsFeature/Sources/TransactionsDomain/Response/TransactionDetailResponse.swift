import Foundation

public struct TransactionDetailResponse {

    public var id: String
    public var title: String
    public var subtitle: String?
}

extension Transaction {
    func response() -> TransactionDetailResponse {
        TransactionDetailResponse(id: id,
                                  title: title,
                                  subtitle: subtitle)
    }
}
