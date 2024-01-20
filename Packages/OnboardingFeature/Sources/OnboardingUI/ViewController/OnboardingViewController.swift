import UIKit
import Combine
import OnboardingDomain
import SnapKit

public protocol OnboardingViewControllerDelegate: AnyObject {

    func didCompleteOnboarding()
}

public class OnboardingViewController: UIViewController {

    // MARK: - Variable

    private var viewModel: OnboardingViewModel
    private var cancelBag: Set<AnyCancellable> = []
    private var completeButton: UIButton = UIButton()
    weak var delegate: OnboardingViewControllerDelegate?

    // MARK: - Initialiaser

    public init(viewModel: OnboardingViewModel) {
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
    }

    // MARK: - Binding

    private func configureBindings() {
        viewModel.$isComplete.receive(on: DispatchQueue.main).sink { [weak self] isComplete in
            guard let self = self else { return }
            if isComplete {
                self.delegate?.didCompleteOnboarding()
            }
        }.store(in: &cancelBag)

        viewModel.$error.receive(on: DispatchQueue.main).sink { [weak self] error in
            guard let self = self else { return }
            if let error {
                switch error {
                case OnboardingStateInteractorError.invalidOnboardingState:
                    let alertController = UIAlertController(title: "Error",
                                                            message: "An Error Occurred, Please Try Again.",
                                                            preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alertController, animated: true) { }
                default: break
                }
            }
        }.store(in: &cancelBag)
    }

    // MARK: - Private Function

    private func configureHierachy() {
        view.addSubview(completeButton)
    }

    private func configureConstraints() {
        completeButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func configureProperties() {
        title = "Onboarding"
        completeButton.setTitle("Complete Onboarding", for: .normal)
        completeButton.setTitleColor(.systemBlue, for: .normal)
        completeButton.addTarget(self, action: #selector(complete), for: .touchUpInside)
        view.backgroundColor = .systemGray6
    }

    @objc func complete() {
        viewModel.completeOnboarding()
    }
}
