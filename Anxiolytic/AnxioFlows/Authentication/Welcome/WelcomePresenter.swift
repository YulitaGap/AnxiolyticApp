import UIKit

/**
  Data that will be directed out of the `WelcomePresenter` to the
  `WelcomeViewController`. This protocol stores the presentation
  logic methods.
 */
protocol WelcomePresenterOutput: AnyObject {

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: WelcomeViewModel)
}

/**
  Formats the response into a `WelcomeViewModel` and pass the result back to
  the `WelcomeViewController`. The `WelcomePresenter` will be in charge
  of the presentation logic. This component decides how the data will be
  presented to the user. Also, when there is a need for transition, it will 
  communicate with the `WelcomeRouter`.
 */
final class WelcomePresenter {

    private(set) unowned var output: WelcomePresenterOutput
    private(set) var router: WelcomeRouterProtocol

    // MARK: - Initializers

    /// This will initialize the `WelcomePresenter` using
    /// a given `WelcomePresenterOutput` and `WelcomeRouter`.
    ///
    /// - Parameter output: A reference to the used output.
    /// - Parameter rozter: A reference to the used router.
    init(output: WelcomePresenterOutput, router: WelcomeRouterProtocol) {
        self.output = output
        self.router = router
    }
}

// MARK: - WelcomeInteractorOutput

extension WelcomePresenter: WelcomeInteractorOutput {
    // MARK: - Presentation logic

    func presentUpdateAfterLoading() {
        let viewModel = WelcomeViewModel()
        update(with: viewModel)
    }

    func update(with viewModel: WelcomeViewModel) {
        output.update(with: viewModel)
    }

    func presentLogInFlow() {
        router.navigateToLogIn()
    }

    func presentRegistrationFlow() {
        router.navigateToRegister()
    }
}
