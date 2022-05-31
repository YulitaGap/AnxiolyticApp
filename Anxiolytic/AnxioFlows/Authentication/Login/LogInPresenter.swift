import UIKit

/**
  Data that will be directed out of the `LogInPresenter` to the
  `LogInViewController`. This protocol stores the presentation
  logic methods.
 */
protocol LogInPresenterOutput: AnyObject {

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: LogInViewModel)

    func showLoginAlert(alert: UIAlertController)
}

/**
  Formats the response into a `LogInViewModel` and pass the result back to
  the `LogInViewController`. The `LogInPresenter` will be in charge
  of the presentation logic. This component decides how the data will be
  presented to the user. Also, when there is a need for transition, it will 
  communicate with the `LogInRouter`.
 */
final class LogInPresenter {

    private(set) unowned var output: LogInPresenterOutput
    private(set) var router: LogInRouterProtocol

    // MARK: - Initializers

    /// This will initialize the `LogInPresenter` using
    /// a given `LogInPresenterOutput` and `LogInRouter`.
    ///
    /// - Parameter output: A reference to the used output.
    /// - Parameter rozter: A reference to the used router.
    init(output: LogInPresenterOutput, router: LogInRouterProtocol) {
        self.output = output
        self.router = router
    }
}

// MARK: - LogInInteractorOutput

extension LogInPresenter: LogInInteractorOutput {

    // MARK: - Presentation logic

    func presentUpdateAfterLoading() {
        let viewModel = LogInViewModel()
        update(with: viewModel)
    }

    func update(with viewModel: LogInViewModel) {
        output.update(with: viewModel)
    }

    func presentCreateNewAccount() {
        let alert = UIAlertController(title: "Create account", message: "You are not registered yet. Would you like to create an account?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in self.presentRegisterScreen() }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in }))

        output.showLoginAlert(alert: alert)
    }

    func presentDashboardForLoggedUser() {
        router.navigateToDashboard()
    }

    func presentRegisterScreen() {
        router.navigateToRegisterScreen()
    }
}
