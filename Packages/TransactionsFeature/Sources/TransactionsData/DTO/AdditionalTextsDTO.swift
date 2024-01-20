import Foundation
import TransactionsDomain

public struct AdditionalTextsDTO: Decodable {

    let text1: String
    let text2: String
    let text3: String
    let lineItems: [String]
    let constantSymbol: String?
    let variableSymbol: String?
    let specificSymbol: String?

}

// MARK: - Mapping

extension AdditionalTextsDTO {

    func entity() -> AdditionalTexts {
        AdditionalTexts(text1: text1,
                        text2: text2,
                        text3: text3,
                        lineItems: lineItems,
                        constantSymbol: constantSymbol,
                        variableSymbol: variableSymbol,
                        specificSymbol: specificSymbol)
    }
}
