import UIKit

/**
  Helper service that configures a `DashboardViewController` with the
  necessary CleanArchitecture reference classes.
 */
final class DashboardConfigurator {

    /// Configures a given `DashboardViewController` with
    /// the necessary reference.
    ///
    /// - Parameter viewController: The view controller to be configured.
    static func configure(viewController: DashboardViewController) {
        let router = DashboardRouter(viewController: viewController)
        let presenter = DashboardPresenter(output: viewController, router: router)
        let interactor = DashboardInteractor(output: presenter)

        viewController.output = interactor
    }
}
