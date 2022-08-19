import UIKit

/**
  Data that will be directed out of the `JournalingInteractor`
  to the `JournalingPresenter`.
 */
protocol JournalingInteractorOutput {

    /// Updates the view controller after the view is loaded.
    func presentUpdateAfterLoading()

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: JournalingViewModel)
}

/**
  This is the “mediator” between the `JournalingWorker` and the `JournalingPresenter`.
  First, it communicates with the `JournalingViewController` which passes all
  the request params needed for the `JournalingWorker`. Before proceeding
  to the `JournalingWorker`, a validation is done to check
  if everything is sent properly. The `JournalingWorker` returns a response
  and the `JournalingInteractor` passes that response towards the `JournalingPresenter.
 */
final class JournalingInteractor {

    private let output: JournalingInteractorOutput
    private let worker: JournalingWorkerInput

    // MARK: - Initializers

    /// This will initialise the `JournalingInteractor` using
    /// a given `JournalingInteractorOutput` and `JournalingWorker`.
    ///
    /// - Parameters:
    ///   - output: A reference to the used output.
    ///   - worker: A reference to the used worker
    ///
    /// - Note: The worker parameter's default value
    ///         is the `JournalingWorker`.
    init(
        output: JournalingInteractorOutput,
        worker: JournalingWorkerInput = JournalingWorker()
    ) {
        self.output = output
        self.worker = worker
        self.worker.output = self
    }
}

// MARK: - JournalingViewControllerOutput

extension JournalingInteractor: JournalingViewControllerOutput {

    // MARK: - Business logic

    func viewLoaded() {
        output.presentUpdateAfterLoading()
    }

    func viewContentUpdated(with viewModel: JournalingViewModel) {
        output.update(with: viewModel)
    }
}

extension JournalingInteractor: JournalingWorkerOutput {
    
    func didSomeWork() {
        // TODO: Fill with content
    }
}

