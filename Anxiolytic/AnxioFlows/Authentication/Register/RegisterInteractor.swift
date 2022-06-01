import UIKit

/**
  Data that will be directed out of the `RegisterInteractor`
  to the `RegisterPresenter`.
 */
protocol RegisterInteractorOutput {

    /// Updates the view controller after the view is loaded.
    func presentUpdateAfterLoading()

    func presentDashboard()

    func presentRegistrationError(error: Error)

    func presentMissingCredsError()

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: RegisterViewModel)
}

/**
  This is the “mediator” between the `RegisterWorker` and the `RegisterPresenter`.
  First, it communicates with the `RegisterViewController` which passes all
  the request params needed for the `RegisterWorker`. Before proceeding
  to the `RegisterWorker`, a validation is done to check
  if everything is sent properly. The `RegisterWorker` returns a response
  and the `RegisterInteractor` passes that response towards the `RegisterPresenter.
 */
final class RegisterInteractor {

    private let output: RegisterInteractorOutput
    private let worker: RegisterWorkerInput

    // MARK: - Initializers

    /// This will initialise the `RegisterInteractor` using
    /// a given `RegisterInteractorOutput` and `RegisterWorker`.
    ///
    /// - Parameters:
    ///   - output: A reference to the used output.
    ///   - worker: A reference to the used worker
    ///
    /// - Note: The worker parameter's default value
    ///         is the `RegisterWorker`.
    init(
        output: RegisterInteractorOutput,
        worker: RegisterWorkerInput = RegisterWorker()
    ) {
        self.output = output
        self.worker = worker
        self.worker.output = self
    }
}

// MARK: - RegisterViewControllerOutput

extension RegisterInteractor: RegisterViewControllerOutput {
    // MARK: - Business logic

    func registerButtonTapped(email: String, password: String) {
        worker.attemptRegister(email: email, password: password)
    }

    func viewLoaded() {
        output.presentUpdateAfterLoading()
    }

    func viewContentUpdated(with viewModel: RegisterViewModel) {
        output.update(with: viewModel)
    }

    func noCredentialsEntered() {
        output.presentMissingCredsError()
    }
}

extension RegisterInteractor: RegisterWorkerOutput {
    func didFailedRegisterUser(error: Error) {
        self.output.presentRegistrationError(error: error)
    }

    func didRegisterUser() {
        output.presentDashboard()
    }

    func didFailedRegisterUser() {
        output.presentUpdateAfterLoading()
    }
}
