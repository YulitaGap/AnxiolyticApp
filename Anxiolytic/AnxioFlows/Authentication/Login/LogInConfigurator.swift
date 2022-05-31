import UIKit

/**
  Helper service that configures a `LogInViewController` with the
  necessary CleanArchitecture reference classes.
 */
final class LogInConfigurator {

    /// Configures a given `LogInViewController` with
    /// the necessary reference.
    ///
    /// - Parameter viewController: The view controller to be configured.
    static func configure(viewController: LogInViewController) {
        let router = LogInRouter(viewController: viewController)
        let presenter = LogInPresenter(output: viewController, router: router)
        let interactor = LogInInteractor(output: presenter)

        viewController.output = interactor
    }
}
