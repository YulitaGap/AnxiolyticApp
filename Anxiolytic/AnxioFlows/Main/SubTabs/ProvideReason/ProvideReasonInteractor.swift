import UIKit

/**
  Data that will be directed out of the `ProvideReasonInteractor`
  to the `ProvideReasonPresenter`.
 */
protocol ProvideReasonInteractorOutput {

    /// Updates the view controller after the view is loaded.
    func presentUpdateAfterLoading()

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: ProvideReasonViewModel)
}

/**
  This is the “mediator” between the `ProvideReasonWorker` and the `ProvideReasonPresenter`.
  First, it communicates with the `ProvideReasonViewController` which passes all
  the request params needed for the `ProvideReasonWorker`. Before proceeding
  to the `ProvideReasonWorker`, a validation is done to check
  if everything is sent properly. The `ProvideReasonWorker` returns a response
  and the `ProvideReasonInteractor` passes that response towards the `ProvideReasonPresenter.
 */
final class ProvideReasonInteractor {

    private let output: ProvideReasonInteractorOutput
    private let worker: ProvideReasonWorkerInput

    // MARK: - Initializers

    /// This will initialise the `ProvideReasonInteractor` using
    /// a given `ProvideReasonInteractorOutput` and `ProvideReasonWorker`.
    ///
    /// - Parameters:
    ///   - output: A reference to the used output.
    ///   - worker: A reference to the used worker
    ///
    /// - Note: The worker parameter's default value
    ///         is the `ProvideReasonWorker`.
    init(
        output: ProvideReasonInteractorOutput,
        worker: ProvideReasonWorkerInput = ProvideReasonWorker()
    ) {
        self.output = output
        self.worker = worker
        self.worker.output = self
    }
}

// MARK: - ProvideReasonViewControllerOutput

extension ProvideReasonInteractor: ProvideReasonViewControllerOutput {

    // MARK: - Business logic

    func viewLoaded() {
        output.presentUpdateAfterLoading()
    }

    func viewContentUpdated(with viewModel: ProvideReasonViewModel) {
        output.update(with: viewModel)
    }
}

extension ProvideReasonInteractor: ProvideReasonWorkerOutput {
    
    func didSomeWork() {
        // TODO: Fill with content
    }
}

