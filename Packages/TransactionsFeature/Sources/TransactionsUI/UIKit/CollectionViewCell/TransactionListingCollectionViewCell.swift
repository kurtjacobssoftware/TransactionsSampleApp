import UIKit

public struct TransactionListingCollectionViewCellConfiguration {

    var title: String
    var subtitle: String?
    var amount: NSDecimalNumber
    var currency: String
    var other: String?
}

public class TransactionListingCollectionViewCell: UICollectionViewCell {

    // MARK: - Variable

    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var amountLabel = UILabel()
    private var otherLabel = UILabel()
    private var stackView = UIStackView()

    // MARK: - Initialiser

    public override init(frame: CGRect) {

        super.init(frame: frame)
        configureHierarchy()
        configureConstraints()
        configureProperties()
    }

    public required init?(coder: NSCoder) {

        super.init(coder: coder)
        configureHierarchy()
        configureConstraints()
        configureProperties()
    }

    // MARK: - Public Function

    public func configure(_ configuration: TransactionListingCollectionViewCellConfiguration) {

        titleLabel.text = configuration.title
        subtitleLabel.text = configuration.subtitle
        amountLabel.text = CurrencyFormatter.symbolicatedAmount(configuration.amount, currency: configuration.currency)
        otherLabel.text = configuration.other
        amountLabel.textColor = configuration.amount.decimalValue >= 0 ? .systemGreen : .systemRed
    }

    public override func layoutSubviews() {

        super.layoutSubviews()
        layer.shadowColor = UIColor.dynamicColor(dark: .white, light: .black).cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
    }

    // MARK: - Private Function

    private func configureHierarchy() {

        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(amountLabel)
        stackView.addArrangedSubview(otherLabel)
    }

    private func configureConstraints() {

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }

    private func configureProperties() {

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        titleLabel.isUserInteractionEnabled = false
        subtitleLabel.isUserInteractionEnabled = false
        amountLabel.isUserInteractionEnabled = false
        otherLabel.isUserInteractionEnabled = false
        titleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.adjustsFontForContentSizeCategory = true
        amountLabel.adjustsFontForContentSizeCategory = true
        otherLabel.adjustsFontForContentSizeCategory = true
        titleLabel.textColor = .dynamicColor(dark: .white, light: .black)
        amountLabel.textColor = .dynamicColor(dark: .white, light: .black)
        otherLabel.textColor = .dynamicColor(dark: .white, light: .black)
        contentView.backgroundColor = .dynamicColor(dark: .black, light: .white)
        titleLabel.numberOfLines = 0
        subtitleLabel.numberOfLines = 0
        amountLabel.numberOfLines = 0
        otherLabel.numberOfLines = 0
        titleLabel.font = .preferredFont(forTextStyle: .headline, compatibleWith: nil)
        subtitleLabel.font = .preferredFont(forTextStyle: .footnote, compatibleWith: nil)
        amountLabel.font = .preferredFont(forTextStyle: .body, compatibleWith: nil)
        otherLabel.font = .preferredFont(forTextStyle: .caption1, compatibleWith: nil)
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        layer.shadowColor = UIColor.dynamicColor(dark: .white, light: .black).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        layer.cornerRadius = 10
    }
}
