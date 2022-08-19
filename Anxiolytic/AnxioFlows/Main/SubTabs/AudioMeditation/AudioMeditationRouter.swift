import UIKit

/**
  All the methods used for routing are kept under this protocol.
 */
protocol AudioMeditationRouterProtocol: class {

    var viewController: AudioMeditationViewController? { get }

    func navigateToSomewhere()
}

/**
  The `AudioMeditationRouter` takes care for the transition and passing
  data between view controllers.
 */
final class AudioMeditationRouter {

    weak var viewController: AudioMeditationViewController?

    // MARK: - Initializers

    /// This will initialize the `AudioMeditationRouter` using
    /// an optional `AudioMeditationViewController`.
    ///
    /// - Parameter viewController: A reference to the used view controller.
    init(viewController: AudioMeditationViewController?) {
        self.viewController = viewController
    }
}

// MARK: - AudioMeditationRouterProtocol

extension AudioMeditationRouter: AudioMeditationRouterProtocol {

    // MARK: - Navigation

    func navigateToSomewhere() {
      // TODO: Navigate to other view controller
    }
}
