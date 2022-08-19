import UIKit

/**
  Data that will be directed out of the `AudioMeditationPresenter` to the
  `AudioMeditationViewController`. This protocol stores the presentation
  logic methods.
 */
protocol AudioMeditationPresenterOutput: class {

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: AudioMeditationViewModel)
}

/**
  Formats the response into a `AudioMeditationViewModel` and pass the result back to
  the `AudioMeditationViewController`. The `AudioMeditationPresenter` will be in charge
  of the presentation logic. This component decides how the data will be
  presented to the user. Also, when there is a need for transition, it will 
  communicate with the `AudioMeditationRouter`.
 */
final class AudioMeditationPresenter {

    private(set) unowned var output: AudioMeditationPresenterOutput
    private(set) var router: AudioMeditationRouterProtocol

    // MARK: - Initializers

    /// This will initialize the `AudioMeditationPresenter` using
    /// a given `AudioMeditationPresenterOutput` and `AudioMeditationRouter`.
    ///
    /// - Parameter output: A reference to the used output.
    /// - Parameter rozter: A reference to the used router.
    init(output: AudioMeditationPresenterOutput, router: AudioMeditationRouterProtocol) {
        self.output = output
        self.router = router
    }
}

// MARK: - AudioMeditationInteractorOutput

extension AudioMeditationPresenter: AudioMeditationInteractorOutput {

    // MARK: - Presentation logic

    func presentUpdateAfterLoading() {

        // TODO: Format the response from the Interactor
        // and pass the result back to the View Controller

        // TODO: Trigger navigation if needed 

        let viewModel = AudioMeditationViewModel()
        update(with: viewModel)
    }

    func update(with viewModel: AudioMeditationViewModel) {
        output.update(with: viewModel)
    }
}
