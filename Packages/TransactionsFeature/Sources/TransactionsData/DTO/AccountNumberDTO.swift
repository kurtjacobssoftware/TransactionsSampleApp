import Foundation
import TransactionsDomain

public struct AccountNumberDTO: Decodable {

    let iban: String?
    let bic: String?
    let number: String?
    let bankCode: String?
    let prefix: String?
    let countryCode: String?

}

// MARK: - Mapping

extension AccountNumberDTO {

    func entity() -> AccountNumber {
        return AccountNumber(iban: iban,
                             bic: bic,
                             number: number,
                             bankCode: bankCode,
                             prefix: prefix,
                             countryCode: countryCode)
    }
}
