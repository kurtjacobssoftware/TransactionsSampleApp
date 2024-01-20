import Foundation

public struct TransactionListingItemsResponse {

    public var id: String
    public var title: String
    public var subtitle: String?
    public var amount: NSDecimalNumber
    public var currency: String
    public var lineItems: [String]
}

extension Transaction {
    func response() -> TransactionListingItemsResponse {
        TransactionListingItemsResponse(id: id,
                                   title: title,
                                   subtitle: subtitle,
                                   amount: amount.decimalValue,
                                   currency: amount.currency,
                                   lineItems: additionalTexts.lineItems)
    }
}
