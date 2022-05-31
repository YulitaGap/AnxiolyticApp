import UIKit

/**
  Data that will be directed out of the `DashboardInteractor`
  to the `DashboardPresenter`.
 */
protocol DashboardInteractorOutput {

    /// Updates the view controller after the view is loaded.
    func presentUpdateAfterLoading()

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: DashboardViewModel)
}

/**
  This is the “mediator” between the `DashboardWorker` and the `DashboardPresenter`.
  First, it communicates with the `DashboardViewController` which passes all
  the request params needed for the `DashboardWorker`. Before proceeding
  to the `DashboardWorker`, a validation is done to check
  if everything is sent properly. The `DashboardWorker` returns a response
  and the `DashboardInteractor` passes that response towards the `DashboardPresenter.
 */
final class DashboardInteractor {

    private let output: DashboardInteractorOutput
    private let worker: DashboardWorkerInput

    // MARK: - Initializers

    /// This will initialise the `DashboardInteractor` using
    /// a given `DashboardInteractorOutput` and `DashboardWorker`.
    ///
    /// - Parameters:
    ///   - output: A reference to the used output.
    ///   - worker: A reference to the used worker
    ///
    /// - Note: The worker parameter's default value
    ///         is the `DashboardWorker`.
    init(
        output: DashboardInteractorOutput,
        worker: DashboardWorkerInput = DashboardWorker()
    ) {
        self.output = output
        self.worker = worker
        self.worker.output = self
    }
}

// MARK: - DashboardViewControllerOutput

extension DashboardInteractor: DashboardViewControllerOutput {

    // MARK: - Business logic

    func viewLoaded() {
        output.presentUpdateAfterLoading()
    }

    func viewContentUpdated(with viewModel: DashboardViewModel) {
        output.update(with: viewModel)
    }
}

extension DashboardInteractor: DashboardWorkerOutput {

    func didSomeWork() {
        // TODO: Fill with content
    }
}
