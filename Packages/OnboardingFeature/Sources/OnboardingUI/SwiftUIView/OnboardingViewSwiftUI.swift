import SwiftUI
import OnboardingDomain

struct OnboardingViewSwiftUI: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    public weak var delegate: OnboardingViewControllerDelegate?

    var body: some View {
        ZStack {
            Button("Complete Onboarding") {
                viewModel.completeOnboarding()
            }
        }
        .onReceive(viewModel.$isComplete) { complete in
            if complete == true {
                delegate?.didCompleteOnboarding()
            }
        }
    }
}

struct OnboardingViewSwiftUI_Previews: PreviewProvider {
    class OnboardingStateProviderPreviews: OnboardingStateProvider {

        func currentState() -> OnboardingDomain.OnboardingState { .incomplete }

        func update(state: OnboardingDomain.OnboardingState) { }
    }

    class OnboardingViewModelDependenciesPreviews: OnboardingViewModelDependencies {
        var onboardingStateUseCase: OnboardingStateUseCase

        init(onboardingStateUseCase: OnboardingStateUseCase) {
            self.onboardingStateUseCase = onboardingStateUseCase
        }
    }

    static var previews: some View {
        let provider = OnboardingStateProviderPreviews()
        let useCase = OnboardingStateInteractor(onboardingStateProvider: provider)
        let dependencies = OnboardingViewModelDependenciesPreviews(onboardingStateUseCase: useCase)
        let viewModel = OnboardingViewModel(dependencies: dependencies)

        NavigationView {
            OnboardingViewSwiftUI().environmentObject(viewModel)
                .navigationTitle("Onboarding")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
