import SwiftUI
import CommonUI
import TransactionsDomain

struct TransactionListingViewSwiftUI: View {
    @EnvironmentObject var viewModel: TransactionListingViewModel
    public weak var delegate: TransactionListingViewControllerDelegate?

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                if let sumTotal = viewModel.sumTotal {
                    if !viewModel.isLoading {
                        VStack(spacing: 0) {
                            Text(CurrencyFormatter.symbolicatedAmount(sumTotal, currency: "EUR"))
                                .padding(.all, 10)
                                .font(.headline)
                            Rectangle()
                                .foregroundColor(Color(UIColor.dynamicColor(dark: .white, light: .black)).opacity(0.1))
                                .frame(height: 1)
                        }
                    }
                }
                List(viewModel.transactions) { transaction in
                    TransactionListingItemViewSwiftUI(configuration: transaction.swiftUIConfiguration())
                        .contentShape(Rectangle())
                    .onTapGesture {
                        delegate?.didSelectTransaction( transaction: transaction)
                    }
                }
                .listStyle(.plain)
                .opacity(viewModel.isLoading ? 0.1 : 1)
                .disabled(viewModel.isLoading)
                .onFirstAppear {
                    Task { try await viewModel.refresh() }
                }
                .alert(isPresented: $viewModel.error) {
                    Alert(
                        title: Text("Error"),
                        message: Text("An Error Occured. Please Try Refreshing."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            ActivityIndicator(isAnimating: viewModel.isLoading)
        }
        .navigationBarItems(trailing: Button("Reload", action: {
            Task { try await viewModel.refresh() }
        }))
    }
}

#Preview {
    let provider: TransactionProvider = TransactionProviderPreviews()
    let useCase: TransactionListingUseCase = TransactionListingInteractor(transactionProvider: provider)
    let dependencies = TransactionListingViewModelDependenciesPreviews(transactionsListingUseCase: useCase)
    let viewModel = TransactionListingViewModel(dependencies: dependencies)

    return NavigationView {
        TransactionListingViewSwiftUI(delegate: nil)
            .environmentObject(viewModel)
            .navigationTitle("Transactions")
            .navigationBarTitleDisplayMode(.inline)
    }
    .previewLayout(.sizeThatFits)
}
