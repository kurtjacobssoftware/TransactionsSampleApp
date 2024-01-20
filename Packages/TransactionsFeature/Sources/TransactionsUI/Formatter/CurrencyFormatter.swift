import Foundation

enum Currency: String {

    case euro = "EUR"
    case dollar = "USD"
    case rand = "ZAR"
}

public class CurrencyFormatter {

    public static func symbolicatedAmount(_ amount: NSDecimalNumber, currency: String) -> String {
        switch Currency(rawValue: currency) {
        case .euro:
            return "€ \(amount.stringValue)"
        case .dollar:
            return "$ \(amount.stringValue)"
        case .rand:
            return "R \(amount.stringValue)"
        default:
            return "\(currency) \(amount.stringValue)"
        }

    }
}
