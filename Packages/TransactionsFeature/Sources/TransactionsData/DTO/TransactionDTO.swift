import Foundation
import TransactionsDomain

public struct TransactionDTO: Decodable {

    let id: String
    let title: String
    let subtitle: String?
    let sender: AccountNumberDTO
    let senderName: String?
    let senderOriginator: String?
    let senderReference: String
    let senderBankReference: String?
    let receiver: AccountNumberDTO
    let receiverName: String?
    let receiverReference: String
    let creditorId: String
    let amount: AmountDTO
    let amountSender: AmountDTO
    let bookingDate: Date
    let valuationDate: Date
    let importDate: Date
    let dueDate: Date?
    let exchangeDate: Date?
    let insertTimestamp: Date
    let reference: String
    let originatorSystem: String
    let additionalTexts: AdditionalTextsDTO
    let note: String?
    let bookingType: String
    let bookingTypeTranslation: String?
    let orderRole: String
    let orderCategory: String?
    let cardId: String
    let maskedCardNumber: String
    let invoiceId: String?
    let location: String
    let partnerName: String?
    let partnerOriginator: String?
    let partnerAddress: [String]

}

// MARK: - Mapping

extension TransactionDTO {

    func entity() -> Transaction {
        return Transaction(id: id,
                           title: title,
                           subtitle: subtitle,
                           sender: sender.entity(),
                           senderName: senderName,
                           senderOriginator: senderOriginator,
                           senderReference: senderReference,
                           senderBankReference: senderBankReference,
                           receiver: receiver.entity(),
                           receiverName: receiverName,
                           receiverReference: receiverReference,
                           creditorId: creditorId,
                           amount: amount.entity(),
                           amountSender: amountSender.entity(),
                           bookingDate: bookingDate,
                           valuationDate: valuationDate,
                           importDate: importDate,
                           dueDate: dueDate,
                           exchangeDate: exchangeDate,
                           insertTimestamp: insertTimestamp,
                           reference: reference,
                           originatorSystem: originatorSystem,
                           additionalTexts: additionalTexts.entity(),
                           note: note,
                           bookingType: bookingType,
                           bookingTypeTranslation: bookingTypeTranslation,
                           orderRole: orderRole,
                           orderCategory: orderCategory,
                           cardId: cardId,
                           maskedCardNumber: maskedCardNumber,
                           invoiceId: invoiceId,
                           location: location,
                           partnerName: partnerName,
                           partnerOriginator: partnerOriginator,
                           partnerAddress: partnerAddress)
    }
}
