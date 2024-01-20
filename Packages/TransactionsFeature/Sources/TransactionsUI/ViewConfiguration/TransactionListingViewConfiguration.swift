import Foundation
import TransactionsDomain

public struct TransactionListingViewConfiguration: Identifiable {

    public var id: String
    public var title: String
    public var subtitle: String?
    public var amount: NSDecimalNumber
    public var currency: String
    public var lineItems: [String]?
}

// MARK: - Domain Layer Mapping

extension TransactionListingItemsResponse {

    func uiConfiguration() -> TransactionListingViewConfiguration {
        return TransactionListingViewConfiguration(id: id,
                                                   title: title,
                                                   subtitle: subtitle,
                                                   amount: amount,
                                                   currency: currency,
                                                   lineItems: lineItems.isEmpty ? nil : lineItems)
    }
}

// MARK: - Swift UI Mapping

extension TransactionListingViewConfiguration {
    func swiftUIConfiguration() -> TransactionListingItemViewSWUIConfiguration {
        return TransactionListingItemViewSWUIConfiguration(title: title, subtitle: subtitle, amount: amount, currency: currency, other: lineItems?.joined(separator: "\n"))
    }
}

// MARK: - CollectionViewCell Mapping

extension TransactionListingViewConfiguration {
    func collectionViewCellConfiguration() -> TransactionListingCollectionViewCellConfiguration {
        return TransactionListingCollectionViewCellConfiguration(title: title, subtitle: subtitle, amount: amount, currency: currency, other: lineItems?.joined(separator: "\n"))
    }
}
