import UIKit

/**
  Helper service that configures a `MeditationsViewController` with the
  necessary CleanArchitecture reference classes.
 */
final class MeditationsConfigurator {

    /// Configures a given `MeditationsViewController` with
    /// the necessary reference.
    ///
    /// - Parameter viewController: The view controller to be configured.
    static func configure(viewController: MeditationsViewController) {
        let router = MeditationsRouter(viewController: viewController)
        let presenter = MeditationsPresenter(output: viewController, router: router)
        let interactor = MeditationsInteractor(output: presenter)

        viewController.output = interactor
    }
}
