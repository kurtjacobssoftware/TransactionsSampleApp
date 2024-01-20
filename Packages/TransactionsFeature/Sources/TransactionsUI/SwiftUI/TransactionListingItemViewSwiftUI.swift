import SwiftUI

public struct TransactionListingItemViewSWUIConfiguration {

    var title: String
    var subtitle: String?
    var amount: NSDecimalNumber
    var currency: String
    var other: String?
}

struct TransactionListingItemViewSwiftUI: View {

    var configuration: TransactionListingItemViewSWUIConfiguration

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
            Text(configuration.title)
                .font(.headline)
                .fontWeight(.bold)
                Spacer()
            }
            .padding(.bottom, 1)

            if let subtitle = configuration.subtitle {
                HStack {
                    Text(subtitle)
                        .font(.footnote)
                    Spacer()
                }
                .padding(.bottom, 1)
            }

            HStack {
                Text(CurrencyFormatter.symbolicatedAmount(configuration.amount, currency: configuration.currency))
                    .foregroundColor(configuration.amount.decimalValue >= 0 ? .green : .red)
                    .font(.body)
                    .padding(.bottom, 1)
            }

            if let other = configuration.other {
                HStack {
                    Text(other)
                        .font(.caption)
                        .padding(.bottom, 1)
                }
            }
        }
        .padding()
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

#Preview {
    VStack {
        TransactionListingItemViewSwiftUI(configuration: TransactionListingItemViewSWUIConfiguration(
            title: "MA 10 Wiener Kindergaerten",
            subtitle: "MA 10 Wiener Kindergaerten/Wilma Ri",
            amount: -65.35,
            currency: "EUR",
            other: "MA 10 Wiener Kindergaerten/Wilma Ri\nnner/Elternbeitraege Wiener Kinderg\naert/PDezember 2017 V121282892"))
        TransactionListingItemViewSwiftUI(configuration: TransactionListingItemViewSWUIConfiguration(
            title: "MA 10 Wiener Kindergaerten",
            subtitle: "MA 10 Wiener Kindergaerten/Wilma Ri",
            amount: 65.35,
            currency: "EUR",
            other: ""))
    }
    .previewLayout(.sizeThatFits)
}
