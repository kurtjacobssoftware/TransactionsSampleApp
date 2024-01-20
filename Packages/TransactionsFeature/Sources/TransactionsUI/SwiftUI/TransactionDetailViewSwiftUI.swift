import SwiftUI
import TransactionsDomain

struct TransactionDetailViewSwiftUI: View {
    @EnvironmentObject var viewModel: TransactionDetailViewModel

    var body: some View {
        VStack {
            Text(viewModel.transactionsDetail?.title ?? "")
                .font(.headline)
            Text(viewModel.transactionsDetail?.subtitle ?? "")
                .font(.body)
        }
        .onAppear {
            Task { try await viewModel.refresh() }
        }
    }
}

#Preview {
    let provider: TransactionProvider = TransactionProviderPreviews()
    let useCase: TransactionDetailUseCase = TransactionDetailInteractor(transactionProvider: provider)
    let dependencies = TransactionDetailViewModelDependenciesPreviews(transactionDetailUseCase: useCase)
    let viewModel = TransactionDetailViewModel(id: "1", dependencies: dependencies)

    return NavigationView {
        TransactionDetailViewSwiftUI()
            .environmentObject(viewModel)
            .navigationTitle("Transaction Details")
            .navigationBarTitleDisplayMode(.inline)
    }
    .previewLayout(.sizeThatFits)
}
