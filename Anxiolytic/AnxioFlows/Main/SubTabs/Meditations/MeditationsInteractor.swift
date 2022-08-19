import UIKit

/**
  Data that will be directed out of the `MeditationsInteractor`
  to the `MeditationsPresenter`.
 */
protocol MeditationsInteractorOutput {

    /// Updates the view controller after the view is loaded.
    func presentUpdateAfterLoading()

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: MeditationsViewModel)
}

/**
  This is the “mediator” between the `MeditationsWorker` and the `MeditationsPresenter`.
  First, it communicates with the `MeditationsViewController` which passes all
  the request params needed for the `MeditationsWorker`. Before proceeding
  to the `MeditationsWorker`, a validation is done to check
  if everything is sent properly. The `MeditationsWorker` returns a response
  and the `MeditationsInteractor` passes that response towards the `MeditationsPresenter.
 */
final class MeditationsInteractor {

    private let output: MeditationsInteractorOutput
    private let worker: MeditationsWorkerInput

    // MARK: - Initializers

    /// This will initialise the `MeditationsInteractor` using
    /// a given `MeditationsInteractorOutput` and `MeditationsWorker`.
    ///
    /// - Parameters:
    ///   - output: A reference to the used output.
    ///   - worker: A reference to the used worker
    ///
    /// - Note: The worker parameter's default value
    ///         is the `MeditationsWorker`.
    init(
        output: MeditationsInteractorOutput,
        worker: MeditationsWorkerInput = MeditationsWorker()
    ) {
        self.output = output
        self.worker = worker
        self.worker.output = self
    }
}

// MARK: - MeditationsViewControllerOutput

extension MeditationsInteractor: MeditationsViewControllerOutput {

    // MARK: - Business logic

    func viewLoaded() {
        output.presentUpdateAfterLoading()
    }

    func viewContentUpdated(with viewModel: MeditationsViewModel) {
        output.update(with: viewModel)
    }
}

extension MeditationsInteractor: MeditationsWorkerOutput {
    
    func didSomeWork() {
        // TODO: Fill with content
    }
}

