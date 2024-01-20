import UIKit
import Combine

public class TransactionDetailViewController: UIViewController {

    // MARK: - Variable

    private var viewModel: TransactionDetailViewModel
    private var cancelBag: Set<AnyCancellable> = []
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var contentStack = UIStackView()

    // MARK: - Initialiaser

    public init(viewModel: TransactionDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
        configureHierachy()
        configureConstraints()
        configureProperties()
        Task { try await viewModel.refresh() }
    }

    // MARK: - Binding

    private func configureBindings() {
        viewModel.$transactionsDetail.receive(on: DispatchQueue.main).sink { [weak self] transactionDetail in
            guard let self = self else { return }
            self.titleLabel.text = transactionDetail?.title
            self.subtitleLabel.text = transactionDetail?.subtitle
        }.store(in: &cancelBag)
    }

    // MARK: - Private Function

    private func configureHierachy() {
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(subtitleLabel)
        view.addSubview(contentStack)
    }

    private func configureConstraints() {
        contentStack.snp.makeConstraints {
            $0.right.left.centerY.equalToSuperview()
        }
    }

    private func configureProperties() {
        title = "Transaction Details"
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        titleLabel.textAlignment = .center
        subtitleLabel.textAlignment = .center
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        subtitleLabel.font = .preferredFont(forTextStyle: .body)
        titleLabel.numberOfLines = 0
        subtitleLabel.numberOfLines = 0
        titleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.adjustsFontForContentSizeCategory = true
        view.backgroundColor = .dynamicColor(dark: .black, light: .white)
    }
}
