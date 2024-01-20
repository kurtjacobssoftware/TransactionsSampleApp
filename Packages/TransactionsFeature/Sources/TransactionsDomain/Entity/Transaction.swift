import Foundation

public struct Transaction {

    public let id: String
    public let title: String
    public let subtitle: String?
    public let sender: AccountNumber
    public let senderName: String?
    public let senderOriginator: String?
    public let senderReference: String
    public let senderBankReference: String?
    public let receiver: AccountNumber
    public let receiverName: String?
    public let receiverReference: String
    public let creditorId: String
    public let amount: Amount
    public let amountSender: Amount
    public let bookingDate: Date
    public let valuationDate: Date
    public let importDate: Date
    public let dueDate: Date?
    public let exchangeDate: Date?
    public let insertTimestamp: Date
    public let reference: String
    public let originatorSystem: String
    public let additionalTexts: AdditionalTexts
    public let note: String?
    public let bookingType: String
    public let bookingTypeTranslation: String?
    public let orderRole: String
    public let orderCategory: String?
    public let cardId: String
    public let maskedCardNumber: String
    public let invoiceId: String?
    public let location: String
    public let partnerName: String?
    public let partnerOriginator: String?
    public let partnerAddress: [String]

    public init(id: String,
                title: String,
                subtitle: String?,
                sender: AccountNumber,
                senderName: String?,
                senderOriginator: String?,
                senderReference: String,
                senderBankReference: String?,
                receiver: AccountNumber,
                receiverName: String?,
                receiverReference: String,
                creditorId: String,
                amount: Amount,
                amountSender: Amount,
                bookingDate: Date,
                valuationDate: Date,
                importDate: Date,
                dueDate: Date?,
                exchangeDate: Date?,
                insertTimestamp: Date,
                reference: String,
                originatorSystem: String,
                additionalTexts: AdditionalTexts,
                note: String?,
                bookingType: String,
                bookingTypeTranslation: String?,
                orderRole: String,
                orderCategory: String?,
                cardId: String,
                maskedCardNumber: String,
                invoiceId: String?,
                location: String,
                partnerName: String?,
                partnerOriginator: String?,
                partnerAddress: [String]) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.sender = sender
        self.senderName = senderName
        self.senderOriginator = senderOriginator
        self.senderReference = senderReference
        self.senderBankReference = senderBankReference
        self.receiver = receiver
        self.receiverName = receiverName
        self.receiverReference = receiverReference
        self.creditorId = creditorId
        self.amount = amount
        self.amountSender = amountSender
        self.bookingDate = bookingDate
        self.valuationDate = valuationDate
        self.importDate = importDate
        self.dueDate = dueDate
        self.exchangeDate = exchangeDate
        self.insertTimestamp = insertTimestamp
        self.reference = reference
        self.originatorSystem = originatorSystem
        self.additionalTexts = additionalTexts
        self.note = note
        self.bookingType = bookingType
        self.bookingTypeTranslation = bookingTypeTranslation
        self.orderRole = orderRole
        self.orderCategory = orderCategory
        self.cardId = cardId
        self.maskedCardNumber = maskedCardNumber
        self.invoiceId = invoiceId
        self.location = location
        self.partnerName = partnerName
        self.partnerOriginator = partnerOriginator
        self.partnerAddress = partnerAddress
    }

}
