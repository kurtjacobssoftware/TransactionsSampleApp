import Foundation

public struct Amount: Decodable {

    public let value: Int
    public let precision: Int
    public let currency: String

    public init(value: Int, precision: Int, currency: String) {
        self.value = value
        self.precision = precision
        self.currency = currency
    }
}

// MARK: - Extensions

public extension Amount {

    var decimalValue: NSDecimalNumber {
        let mantissa =  llabs(Int64(value))
        let exponent = Int16(precision * -1)

        return NSDecimalNumber(
            mantissa: UInt64(mantissa),
            exponent: exponent,
            isNegative: self.value < 0
        )
    }

    init(decimalValue: NSDecimalNumber, currency: String) {
        self.currency = currency
        self.precision = 2

        self.value = decimalValue.integerValueWithPrecision2
    }

}

public extension NSDecimalNumber {

    var integerValueWithPrecision2: Int {
        let decimalNumberBehavior = NSDecimalNumberHandler(
            roundingMode: NSDecimalNumber.RoundingMode.plain,
            scale: 0,
            raiseOnExactness: false,
            raiseOnOverflow: false,
            raiseOnUnderflow: false,
            raiseOnDivideByZero: false
        )

        let beforeComma = self.rounding(accordingToBehavior: decimalNumberBehavior)
        let afterComma = self.subtracting(beforeComma)

        let beforeCommaMultipliedBy100 = beforeComma.multiplying(
            byPowerOf10: 2,
            withBehavior: decimalNumberBehavior
        )

        if afterComma != NSDecimalNumber.zero {
            let afterCommaCommaMultipliedBy100 = afterComma.multiplying(
                byPowerOf10: 2,
                withBehavior: decimalNumberBehavior
            )
            return beforeCommaMultipliedBy100.adding(afterCommaCommaMultipliedBy100).intValue
        } else {
            return beforeCommaMultipliedBy100.intValue
        }
    }

}
