import UIKit

/**
  Helper service that configures a `TabBarViewController` with the
  necessary CleanArchitecture reference classes.
 */
final class TabBarConfigurator {

    /// Configures a given `TabBarViewController` with
    /// the necessary reference.
    ///
    /// - Parameter viewController: The view controller to be configured.
    static func configure(viewController: TabBarViewController) {
        let router = TabBarRouter(viewController: viewController)
        let presenter = TabBarPresenter(output: viewController, router: router)
        let interactor = TabBarInteractor(output: presenter)

        viewController.output = interactor
    }
}
