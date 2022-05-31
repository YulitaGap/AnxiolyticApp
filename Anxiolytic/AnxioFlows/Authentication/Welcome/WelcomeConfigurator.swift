import UIKit

/**
  Helper service that configures a `WelcomeViewController` with the
  necessary CleanArchitecture reference classes.
 */
final class WelcomeConfigurator {

    /// Configures a given `WelcomeViewController` with
    /// the necessary reference.
    ///
    /// - Parameter viewController: The view controller to be configured.
    static func configure(viewController: WelcomeViewController) {
        let router = WelcomeRouter(viewController: viewController)
        let presenter = WelcomePresenter(output: viewController, router: router)
        let interactor = WelcomeInteractor(output: presenter)

        viewController.output = interactor
    }
}
