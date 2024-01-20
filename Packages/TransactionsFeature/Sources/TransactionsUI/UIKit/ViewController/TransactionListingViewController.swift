import UIKit
import Combine
import SnapKit
import NVActivityIndicatorView

public protocol TransactionListingViewControllerDelegate: AnyObject {

    func didSelectTransaction(transaction: TransactionListingViewConfiguration)
}

public class TransactionListingViewController: UIViewController {

    // MARK: - Variable

    weak var delegate: TransactionListingViewControllerDelegate?
    private var viewModel: TransactionListingViewModel
    private var cancelBag: Set<AnyCancellable> = []
    private lazy var collectionView: UICollectionView = UICollectionView(frame: .zero,
                                                                         collectionViewLayout: UICollectionViewCompositionalLayout(
                                                                            sectionProvider: { _, _ in
        return UICollectionViewCompositionalLayout.listLayout()
    }))
    private var hairline = UIView()
    private var refreshControl = UIRefreshControl()
    private var sumTotalLabel = UILabel()
    private var loadingIndicator = NVActivityIndicatorView(frame: .zero)

    // MARK: - Initialiaser

    public init(viewModel: TransactionListingViewModel) {
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
        refresh()
    }

    // MARK: - Binding

    private func configureBindings() {
        viewModel.$transactions
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.collectionView.reloadData()
            }.store(in: &cancelBag)

        viewModel.$sumTotal
            .receive(on: DispatchQueue.main)
            .sink { [weak self] sumTotal in
                guard let self = self else { return }
                guard let total = sumTotal else { return }
                self.sumTotalLabel.text = CurrencyFormatter.symbolicatedAmount(total, currency: "EUR")
            }.store(in: &cancelBag)

        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                if isLoading == false { self.refreshControl.endRefreshing() }
                if isLoading == true {
                    UIView.animate(withDuration: 0.5) {
                        self.sumTotalLabel.alpha = 0
                        self.hairline.alpha = 0
                        self.collectionView.alpha = 0.25
                        self.collectionView.isUserInteractionEnabled = false
                        self.loadingIndicator.startAnimating()
                    }
                } else {
                    UIView.animate(withDuration: 0.5) {
                        self.sumTotalLabel.alpha = 1
                        self.hairline.alpha = 1
                        self.collectionView.isUserInteractionEnabled = true
                        self.loadingIndicator.stopAnimating()
                        self.collectionView.alpha = 1
                    }
                }
            }.store(in: &cancelBag)

        viewModel.$error
            .receive(on: DispatchQueue.main)
            .delay(for: 0.2, scheduler: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self = self else { return }
                if error {
                    if self.viewModel.transactions.count == 0 { self.hairline.alpha = 0 } else { self.hairline.alpha = 1 }
                    let alertController = UIAlertController(title: "Error",
                                                            message: "An Error Occurred, Please Try Refreshing.",
                                                            preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alertController, animated: true) {
                        self.refreshControl.endRefreshing()
                    }
                }
            }.store(in: &cancelBag)
    }

    // MARK: - Private Function

    private func configureHierachy() {
        view.addSubview(sumTotalLabel)
        view.addSubview(collectionView)
        view.addSubview(loadingIndicator)
        view.addSubview(hairline)
    }

    private func configureConstraints() {
        sumTotalLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
        }

        hairline.snp.makeConstraints {
            $0.top.equalTo(sumTotalLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0.5)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(hairline.snp.bottom)
            $0.left.bottom.right.equalToSuperview()
        }

        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(50)
        }
    }

    private func configureProperties() {
        title = "Transactions"
        hairline.alpha = 0
        hairline.backgroundColor = .dynamicColor(dark: .white, light: .black).withAlphaComponent(0.1)
        sumTotalLabel.textAlignment = .center
        sumTotalLabel.numberOfLines = 0
        sumTotalLabel.font = .preferredFont(forTextStyle: .headline)
        sumTotalLabel.adjustsFontForContentSizeCategory = true
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        loadingIndicator.color = .systemBlue
        loadingIndicator.type = .ballBeat
        view.backgroundColor = .dynamicColor(dark: .black, light: .white)
        collectionView.backgroundColor = .dynamicColor(dark: .black, light: .white)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refreshControl
        collectionView.register(TransactionListingCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }

    @objc private func refresh() {
        Task { try await viewModel.refresh() }
    }
}

// MARK: - Extensions

extension TransactionListingViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.transactions[indexPath.row]
        delegate?.didSelectTransaction(transaction: item)
    }
}

extension TransactionListingViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.transactions.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                as? TransactionListingCollectionViewCell else { return UICollectionViewCell() }
        let item = viewModel.transactions[indexPath.row]
        cell.configure(item.collectionViewCellConfiguration())
        return cell
    }
}
