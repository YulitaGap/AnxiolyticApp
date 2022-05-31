import UIKit

/**
  Helper service that configures a `SettingsViewController` with the
  necessary CleanArchitecture reference classes.
 */
final class SettingsConfigurator {

    /// Configures a given `SettingsViewController` with
    /// the necessary reference.
    ///
    /// - Parameter viewController: The view controller to be configured.
    static func configure(viewController: SettingsViewController) {
        let router = SettingsRouter(viewController: viewController)
        let presenter = SettingsPresenter(output: viewController, router: router)
        let interactor = SettingsInteractor(output: presenter)

        viewController.output = interactor
    }
}
