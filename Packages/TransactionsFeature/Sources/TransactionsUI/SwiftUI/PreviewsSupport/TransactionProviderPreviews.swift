//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2024/01/20.
//

import Foundation
import TransactionsDomain

#if DEBUG

class TransactionProviderPreviews: TransactionProvider {
    func getAllTransactions(invalidatesCache: Bool) async throws -> [TransactionsDomain.Transaction] {
        guard let transaction = try await getTransaction(with: "1") else { return [] }
        return [transaction]
    }

    func getTransaction(with id: String) async throws -> TransactionsDomain.Transaction? {
        let accountNumber = AccountNumber(iban: nil, bic: nil, number: nil, bankCode: nil, prefix: nil, countryCode: nil)
        let amount = Amount(decimalValue: 233, currency: "EUR")
        let additionalTexts = AdditionalTexts(text1: "", text2: "", text3: "", lineItems: [ ], constantSymbol: nil, variableSymbol: nil, specificSymbol: nil)
        return TransactionsDomain.Transaction(id: "1",
                                                  title: "SPAR DANKT 4249 WIEN",
                                                  subtitle: "Payment with card 2 on the 9. Feb. at 15:18.",
                                                  sender: accountNumber,
                                                  senderName: nil,
                                                  senderOriginator: nil,
                                                  senderReference: "",
                                                  senderBankReference: nil,
                                                  receiver: accountNumber,
                                                  receiverName: nil,
                                                  receiverReference: "",
                                                  creditorId: "",
                                                  amount: amount,
                                                  amountSender: amount,
                                                  bookingDate: Date(),
                                                  valuationDate: Date(),
                                                  importDate: Date(),
                                                  dueDate: nil,
                                                  exchangeDate: nil,
                                                  insertTimestamp: Date(),
                                                  reference: "",
                                                  originatorSystem: "",
                                                  additionalTexts: additionalTexts,
                                                  note: nil,
                                                  bookingType: "",
                                                  bookingTypeTranslation: "",
                                                  orderRole: "",
                                                  orderCategory: "",
                                                  cardId: "",
                                                  maskedCardNumber: "",
                                                  invoiceId: "",
                                                  location: "",
                                                  partnerName: "",
                                                  partnerOriginator: "",
                                                  partnerAddress: [])
    }
}

#endif
