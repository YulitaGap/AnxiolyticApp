import UIKit

/**
  Helper service that configures a `JournalingViewController` with the
  necessary CleanArchitecture reference classes.
 */
final class JournalingConfigurator {

    /// Configures a given `JournalingViewController` with
    /// the necessary reference.
    ///
    /// - Parameter viewController: The view controller to be configured.
    static func configure(viewController: JournalingViewController) {
        let router = JournalingRouter(viewController: viewController)
        let presenter = JournalingPresenter(output: viewController, router: router)
        let interactor = JournalingInteractor(output: presenter)

        viewController.output = interactor
    }
}
