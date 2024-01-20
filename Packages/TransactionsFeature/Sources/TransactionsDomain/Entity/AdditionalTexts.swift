import Foundation

public struct AdditionalTexts {

    public let text1: String
    public let text2: String
    public let text3: String
    public let lineItems: [String]
    public let constantSymbol: String?
    public let variableSymbol: String?
    public let specificSymbol: String?

    public init(text1: String, text2: String, text3: String, lineItems: [String], constantSymbol: String?, variableSymbol: String?, specificSymbol: String?) {
        self.text1 = text1
        self.text2 = text2
        self.text3 = text3
        self.lineItems = lineItems
        self.constantSymbol = constantSymbol
        self.variableSymbol = variableSymbol
        self.specificSymbol = specificSymbol
    }
}
