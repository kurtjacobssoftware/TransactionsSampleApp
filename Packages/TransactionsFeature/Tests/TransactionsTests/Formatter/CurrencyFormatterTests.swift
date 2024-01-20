import XCTest

@testable import TransactionsDomain
@testable import TransactionsUI
@testable import TransactionsData

final class CurrencyFormatterTests: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func testCurrencySymbolication() throws {

        let euro = CurrencyFormatter.symbolicatedAmount(509.33, currency: "EUR")
        let usd = CurrencyFormatter.symbolicatedAmount(509.33, currency: "USD")
        let zar = CurrencyFormatter.symbolicatedAmount(509.33, currency: "ZAR")
        let unknown = CurrencyFormatter.symbolicatedAmount(509.33, currency: "UNK")

        XCTAssertEqual(euro, "€ 509.33")
        XCTAssertEqual(usd, "$ 509.33")
        XCTAssertEqual(zar, "R 509.33")
        XCTAssertEqual(unknown, "UNK 509.33")
    }
}
