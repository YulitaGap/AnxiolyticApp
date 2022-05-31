import UIKit

/**
  Helper service that configures a `RegisterViewController` with the
  necessary CleanArchitecture reference classes.
 */
final class RegisterConfigurator {

    /// Configures a given `RegisterViewController` with
    /// the necessary reference.
    ///
    /// - Parameter viewController: The view controller to be configured.
    static func configure(viewController: RegisterViewController) {
        let router = RegisterRouter(viewController: viewController)
        let presenter = RegisterPresenter(output: viewController, router: router)
        let interactor = RegisterInteractor(output: presenter)

        viewController.output = interactor
    }
}
