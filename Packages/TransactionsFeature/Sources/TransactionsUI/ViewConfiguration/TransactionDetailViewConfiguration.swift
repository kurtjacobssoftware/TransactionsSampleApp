import Foundation
import TransactionsDomain

public struct TransactionDetailViewConfiguration: Identifiable {

    public var id: String
    public var title: String
    public var subtitle: String
}

// MARK: - Mapping

extension TransactionDetailResponse {

    func viewConfiguration() -> TransactionDetailViewConfiguration {
        return TransactionDetailViewConfiguration(id: id,
                                                  title: title,
                                                  subtitle: subtitle ?? "")
    }
}
