import UIKit

/**
  Data that will be directed out of the `LogInInteractor`
  to the `LogInPresenter`.
 */
protocol LogInInteractorOutput {

    /// Updates the view controller after the view is loaded.
    func presentUpdateAfterLoading()

    func presentCreateNewAccount()

    func presentDashboardForLoggedUser()

    func presentMissingCredsError()

    func presentAuthErrorAlert(error: Error)

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: LogInViewModel)
}

/**
  This is the “mediator” between the `LogInWorker` and the `LogInPresenter`.
  First, it communicates with the `LogInViewController` which passes all
  the request params needed for the `LogInWorker`. Before proceeding
  to the `LogInWorker`, a validation is done to check
  if everything is sent properly. The `LogInWorker` returns a response
  and the `LogInInteractor` passes that response towards the `LogInPresenter.
 */
final class LogInInteractor {

    private let output: LogInInteractorOutput
    private let worker: LogInWorkerInput

    // MARK: - Initializers

    /// This will initialise the `LogInInteractor` using
    /// a given `LogInInteractorOutput` and `LogInWorker`.
    ///
    /// - Parameters:
    ///   - output: A reference to the used output.
    ///   - worker: A reference to the used worker
    ///
    /// - Note: The worker parameter's default value
    ///         is the `LogInWorker`.
    init(
        output: LogInInteractorOutput,
        worker: LogInWorkerInput = LogInWorker()
    ) {
        self.output = output
        self.worker = worker
        self.worker.output = self
    }
}

// MARK: - LogInViewControllerOutput

extension LogInInteractor: LogInViewControllerOutput {
    // MARK: - Business logic

    func viewLoaded() {
        output.presentUpdateAfterLoading()
    }

    func viewContentUpdated(with viewModel: LogInViewModel) {
        output.update(with: viewModel)
    }

    func noCredentialsEntered() {
        output.presentMissingCredsError()
    }

    func logInButtonTapped(email: String, password: String) {
        worker.attemptSignIn(email: email, password: password)
    }
}

extension LogInInteractor: LogInWorkerOutput {
    func didFailedLogginUser(error: Error) {
        if error.localizedDescription.contains("There is no user record corresponding to this identifier") {
            self.output.presentCreateNewAccount()
            return
        }
        self.output.presentAuthErrorAlert(error: error)
    }

    func didFailedLogginUser() {
        self.output.presentCreateNewAccount()
    }

    func didLoggedInUser() {
        self.output.presentDashboardForLoggedUser()
    }
}
