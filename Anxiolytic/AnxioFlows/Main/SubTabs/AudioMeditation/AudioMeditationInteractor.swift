import UIKit

/**
  Data that will be directed out of the `AudioMeditationInteractor`
  to the `AudioMeditationPresenter`.
 */
protocol AudioMeditationInteractorOutput {

    /// Updates the view controller after the view is loaded.
    func presentUpdateAfterLoading()

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: AudioMeditationViewModel)
}

/**
  This is the “mediator” between the `AudioMeditationWorker` and the `AudioMeditationPresenter`.
  First, it communicates with the `AudioMeditationViewController` which passes all
  the request params needed for the `AudioMeditationWorker`. Before proceeding
  to the `AudioMeditationWorker`, a validation is done to check
  if everything is sent properly. The `AudioMeditationWorker` returns a response
  and the `AudioMeditationInteractor` passes that response towards the `AudioMeditationPresenter.
 */
final class AudioMeditationInteractor {

    private let output: AudioMeditationInteractorOutput
    private let worker: AudioMeditationWorkerInput

    // MARK: - Initializers

    /// This will initialise the `AudioMeditationInteractor` using
    /// a given `AudioMeditationInteractorOutput` and `AudioMeditationWorker`.
    ///
    /// - Parameters:
    ///   - output: A reference to the used output.
    ///   - worker: A reference to the used worker
    ///
    /// - Note: The worker parameter's default value
    ///         is the `AudioMeditationWorker`.
    init(
        output: AudioMeditationInteractorOutput,
        worker: AudioMeditationWorkerInput = AudioMeditationWorker()
    ) {
        self.output = output
        self.worker = worker
        self.worker.output = self
    }
}

// MARK: - AudioMeditationViewControllerOutput

extension AudioMeditationInteractor: AudioMeditationViewControllerOutput {

    // MARK: - Business logic

    func viewLoaded() {
        output.presentUpdateAfterLoading()
    }

    func viewContentUpdated(with viewModel: AudioMeditationViewModel) {
        output.update(with: viewModel)
    }
}

extension AudioMeditationInteractor: AudioMeditationWorkerOutput {
    
    func didSomeWork() {
        // TODO: Fill with content
    }
}

