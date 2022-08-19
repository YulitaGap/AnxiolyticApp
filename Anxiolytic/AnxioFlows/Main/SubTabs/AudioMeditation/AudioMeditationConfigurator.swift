import UIKit

/**
  Helper service that configures a `AudioMeditationViewController` with the
  necessary CleanArchitecture reference classes.
 */
final class AudioMeditationConfigurator {

    /// Configures a given `AudioMeditationViewController` with
    /// the necessary reference.
    ///
    /// - Parameter viewController: The view controller to be configured.
    static func configure(viewController: AudioMeditationViewController) {
        let router = AudioMeditationRouter(viewController: viewController)
        let presenter = AudioMeditationPresenter(output: viewController, router: router)
        let interactor = AudioMeditationInteractor(output: presenter)

        viewController.output = interactor
    }
}
