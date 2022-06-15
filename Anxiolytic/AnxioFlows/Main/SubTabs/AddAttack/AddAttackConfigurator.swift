import UIKit

/**
  Helper service that configures a `AddAttackViewController` with the
  necessary CleanArchitecture reference classes.
 */
final class AddAttackConfigurator {

    /// Configures a given `AddAttackViewController` with
    /// the necessary reference.
    ///
    /// - Parameter viewController: The view controller to be configured.
    static func configure(viewController: AddAttackViewController) {
        let router = AddAttackRouter(viewController: viewController)
        let presenter = AddAttackPresenter(output: viewController, router: router)
        let interactor = AddAttackInteractor(output: presenter)

        viewController.output = interactor
    }
}
