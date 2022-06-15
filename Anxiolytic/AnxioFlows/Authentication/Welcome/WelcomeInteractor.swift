import UIKit
import FirebaseAuth
/**
  Data that will be directed out of the `WelcomeInteractor`
  to the `WelcomePresenter`.
 */
protocol WelcomeInteractorOutput {

    /// Updates the view controller after the view is loaded.
    func presentUpdateAfterLoading()

    func presentLogInFlow()

    func presentRegistrationFlow()

    func presentDashboardForLogged(user: User)

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: WelcomeViewModel)
}

/**
  This is the “mediator” between the `WelcomeWorker` and the `WelcomePresenter`.
  First, it communicates with the `WelcomeViewController` which passes all
  the request params needed for the `WelcomeWorker`. Before proceeding
  to the `WelcomeWorker`, a validation is done to check
  if everything is sent properly. The `WelcomeWorker` returns a response
  and the `WelcomeInteractor` passes that response towards the `WelcomePresenter.
 */
final class WelcomeInteractor {

    private let output: WelcomeInteractorOutput
    private let worker: WelcomeWorkerInput

    // MARK: - Initializers

    /// This will initialise the `WelcomeInteractor` using
    /// a given `WelcomeInteractorOutput` and `WelcomeWorker`.
    ///
    /// - Parameters:
    ///   - output: A reference to the used output.
    ///   - worker: A reference to the used worker
    ///
    /// - Note: The worker parameter's default value
    ///         is the `WelcomeWorker`.
    init(
        output: WelcomeInteractorOutput,
        worker: WelcomeWorkerInput = WelcomeWorker()
    ) {
        self.output = output
        self.worker = worker
        self.worker.output = self
    }
}

// MARK: - WelcomeViewControllerOutput

extension WelcomeInteractor: WelcomeViewControllerOutput {
    // MARK: - Business logic
    func viewLoaded() {
        output.presentUpdateAfterLoading()
    }

    func viewContentUpdated(with viewModel: WelcomeViewModel) {
        output.update(with: viewModel)
    }

    func logInButtonTapped() {
        output.presentLogInFlow()
    }

    func registerButtonTapped() {
        output.presentRegistrationFlow()
    }

    func checkIfLogged() {
        worker.checkIfLogged()
    }
}

extension WelcomeInteractor: WelcomeWorkerOutput {

    func noLoggedUserFound() {

    }


    func foundLoggedUser(user: User) {
        output.presentDashboardForLogged(user: user)
    }
}
