import UIKit

/**
  Helper service that configures a `ProvideReasonViewController` with the
  necessary CleanArchitecture reference classes.
 */
final class ProvideReasonConfigurator {

    /// Configures a given `ProvideReasonViewController` with
    /// the necessary reference.
    ///
    /// - Parameter viewController: The view controller to be configured.
    static func configure(viewController: ProvideReasonViewController) {
        let router = ProvideReasonRouter(viewController: viewController)
        let presenter = ProvideReasonPresenter(output: viewController, router: router)
        let interactor = ProvideReasonInteractor(output: presenter)

        viewController.output = interactor
    }
}
