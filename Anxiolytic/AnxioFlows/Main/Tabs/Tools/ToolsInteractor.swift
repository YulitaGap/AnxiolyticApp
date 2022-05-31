import UIKit

/**
  Data that will be directed out of the `ToolsInteractor`
  to the `ToolsPresenter`.
 */
protocol ToolsInteractorOutput {

    /// Updates the view controller after the view is loaded.
    func presentUpdateAfterLoading()

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: ToolsViewModel)
}

/**
  This is the “mediator” between the `ToolsWorker` and the `ToolsPresenter`.
  First, it communicates with the `ToolsViewController` which passes all
  the request params needed for the `ToolsWorker`. Before proceeding
  to the `ToolsWorker`, a validation is done to check
  if everything is sent properly. The `ToolsWorker` returns a response
  and the `ToolsInteractor` passes that response towards the `ToolsPresenter.
 */
final class ToolsInteractor {

    private let output: ToolsInteractorOutput
    private let worker: ToolsWorkerInput

    // MARK: - Initializers

    /// This will initialise the `ToolsInteractor` using
    /// a given `ToolsInteractorOutput` and `ToolsWorker`.
    ///
    /// - Parameters:
    ///   - output: A reference to the used output.
    ///   - worker: A reference to the used worker
    ///
    /// - Note: The worker parameter's default value
    ///         is the `ToolsWorker`.
    init(
        output: ToolsInteractorOutput,
        worker: ToolsWorkerInput = ToolsWorker()
    ) {
        self.output = output
        self.worker = worker
        self.worker.output = self
    }
}

// MARK: - ToolsViewControllerOutput

extension ToolsInteractor: ToolsViewControllerOutput {

    // MARK: - Business logic

    func viewLoaded() {
        output.presentUpdateAfterLoading()
    }

    func viewContentUpdated(with viewModel: ToolsViewModel) {
        output.update(with: viewModel)
    }
}

extension ToolsInteractor: ToolsWorkerOutput {

    func didSomeWork() {
        // TODO: Fill with content
    }
}
