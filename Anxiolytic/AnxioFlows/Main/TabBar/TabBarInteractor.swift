import UIKit

/**
  Data that will be directed out of the `TabBarInteractor`
  to the `TabBarPresenter`.
 */
protocol TabBarInteractorOutput {

    /// Updates the view controller after the view is loaded.
    func presentUpdateAfterLoading()

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: TabBarViewModel)
}

/**
  This is the “mediator” between the `TabBarWorker` and the `TabBarPresenter`.
  First, it communicates with the `TabBarViewController` which passes all
  the request params needed for the `TabBarWorker`. Before proceeding
  to the `TabBarWorker`, a validation is done to check
  if everything is sent properly. The `TabBarWorker` returns a response
  and the `TabBarInteractor` passes that response towards the `TabBarPresenter.
 */
final class TabBarInteractor {

    private let output: TabBarInteractorOutput
    private let worker: TabBarWorkerInput

    // MARK: - Initializers

    /// This will initialise the `TabBarInteractor` using
    /// a given `TabBarInteractorOutput` and `TabBarWorker`.
    ///
    /// - Parameters:
    ///   - output: A reference to the used output.
    ///   - worker: A reference to the used worker
    ///
    /// - Note: The worker parameter's default value
    ///         is the `TabBarWorker`.
    init(
        output: TabBarInteractorOutput,
        worker: TabBarWorkerInput = TabBarWorker()
    ) {
        self.output = output
        self.worker = worker
        self.worker.output = self
    }
}

// MARK: - TabBarViewControllerOutput

extension TabBarInteractor: TabBarViewControllerOutput {

    // MARK: - Business logic

    func viewLoaded() {
        output.presentUpdateAfterLoading()
    }

    func viewContentUpdated(with viewModel: TabBarViewModel) {
        output.update(with: viewModel)
    }
}

extension TabBarInteractor: TabBarWorkerOutput {

    func didSomeWork() {
        // TODO: Fill with content
    }
}
