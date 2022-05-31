import UIKit

/**
  Data that will be directed out of the `SettingsInteractor`
  to the `SettingsPresenter`.
 */
protocol SettingsInteractorOutput {

    /// Updates the view controller after the view is loaded.
    func presentUpdateAfterLoading()

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: SettingsViewModel)
}

/**
  This is the “mediator” between the `SettingsWorker` and the `SettingsPresenter`.
  First, it communicates with the `SettingsViewController` which passes all
  the request params needed for the `SettingsWorker`. Before proceeding
  to the `SettingsWorker`, a validation is done to check
  if everything is sent properly. The `SettingsWorker` returns a response
  and the `SettingsInteractor` passes that response towards the `SettingsPresenter.
 */
final class SettingsInteractor {

    private let output: SettingsInteractorOutput
    private let worker: SettingsWorkerInput

    // MARK: - Initializers

    /// This will initialise the `SettingsInteractor` using
    /// a given `SettingsInteractorOutput` and `SettingsWorker`.
    ///
    /// - Parameters:
    ///   - output: A reference to the used output.
    ///   - worker: A reference to the used worker
    ///
    /// - Note: The worker parameter's default value
    ///         is the `SettingsWorker`.
    init(
        output: SettingsInteractorOutput,
        worker: SettingsWorkerInput = SettingsWorker()
    ) {
        self.output = output
        self.worker = worker
        self.worker.output = self
    }
}

// MARK: - SettingsViewControllerOutput

extension SettingsInteractor: SettingsViewControllerOutput {

    // MARK: - Business logic

    func viewLoaded() {
        output.presentUpdateAfterLoading()
    }

    func viewContentUpdated(with viewModel: SettingsViewModel) {
        output.update(with: viewModel)
    }
}

extension SettingsInteractor: SettingsWorkerOutput {

    func didSomeWork() {
        // TODO: Fill with content
    }
}
