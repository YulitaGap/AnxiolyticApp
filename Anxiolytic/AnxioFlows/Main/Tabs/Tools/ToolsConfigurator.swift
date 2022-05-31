import UIKit

/**
  Helper service that configures a `ToolsViewController` with the
  necessary CleanArchitecture reference classes.
 */
final class ToolsConfigurator {

    /// Configures a given `ToolsViewController` with
    /// the necessary reference.
    ///
    /// - Parameter viewController: The view controller to be configured.
    static func configure(viewController: ToolsViewController) {
        let router = ToolsRouter(viewController: viewController)
        let presenter = ToolsPresenter(output: viewController, router: router)
        let interactor = ToolsInteractor(output: presenter)

        viewController.output = interactor
    }
}
