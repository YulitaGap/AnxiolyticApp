import UIKit

/**
  Data that will be directed out of the `AddAttackInteractor`
  to the `AddAttackPresenter`.
 */
protocol AddAttackInteractorOutput {

    /// Updates the view controller after the view is loaded.
    func presentUpdateAfterLoading()

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: AddAttackViewModel)
}

/**
  This is the “mediator” between the `AddAttackWorker` and the `AddAttackPresenter`.
  First, it communicates with the `AddAttackViewController` which passes all
  the request params needed for the `AddAttackWorker`. Before proceeding
  to the `AddAttackWorker`, a validation is done to check
  if everything is sent properly. The `AddAttackWorker` returns a response
  and the `AddAttackInteractor` passes that response towards the `AddAttackPresenter.
 */
final class AddAttackInteractor {

    private let output: AddAttackInteractorOutput
    private let worker: AddAttackWorkerInput

    // MARK: - Initializers

    /// This will initialise the `AddAttackInteractor` using
    /// a given `AddAttackInteractorOutput` and `AddAttackWorker`.
    ///
    /// - Parameters:
    ///   - output: A reference to the used output.
    ///   - worker: A reference to the used worker
    ///
    /// - Note: The worker parameter's default value
    ///         is the `AddAttackWorker`.
    init(
        output: AddAttackInteractorOutput,
        worker: AddAttackWorkerInput = AddAttackWorker()
    ) {
        self.output = output
        self.worker = worker
        self.worker.output = self
    }
}

// MARK: - AddAttackViewControllerOutput

extension AddAttackInteractor: AddAttackViewControllerOutput {

    // MARK: - Business logic

    func viewLoaded() {
        output.presentUpdateAfterLoading()
    }

    func viewContentUpdated(with viewModel: AddAttackViewModel) {
        output.update(with: viewModel)
    }
}

extension AddAttackInteractor: AddAttackWorkerOutput {

    func didSomeWork() {
        // TODO: Fill with content
    }
}
