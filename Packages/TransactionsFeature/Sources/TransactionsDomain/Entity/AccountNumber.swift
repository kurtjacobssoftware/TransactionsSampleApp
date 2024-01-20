import Foundation

public struct AccountNumber {

    public let iban: String?
    public let bic: String?
    public let number: String?
    public let bankCode: String?
    public let prefix: String?
    public let countryCode: String?

    public init(iban: String?, bic: String?, number: String?, bankCode: String?, prefix: String?, countryCode: String?) {
        self.iban = iban
        self.bic = bic
        self.number = number
        self.bankCode = bankCode
        self.prefix = prefix
        self.countryCode = countryCode
    }

}
