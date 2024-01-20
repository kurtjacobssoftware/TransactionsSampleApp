import Foundation
import TransactionsDomain

public struct AmountDTO: Decodable {

    let value: Int
    let precision: Int
    let currency: String

}

// MARK: - Mapping

extension AmountDTO {

    func entity() -> Amount {
        Amount(value: value,
               precision: precision,
               currency: currency)
    }
}
