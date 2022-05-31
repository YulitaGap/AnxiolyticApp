import UIKit

/**
  All the methods used for routing are kept under this protocol.
 */
protocol SettingsRouterProtocol: AnyObject {

    var viewController: SettingsViewController? { get }

    func navigateToSomewhere()
}

/**
  The `SettingsRouter` takes care for the transition and passing
  data between view controllers.
 */
final class SettingsRouter {

    weak var viewController: SettingsViewController?

    // MARK: - Initializers

    /// This will initialize the `SettingsRouter` using
    /// an optional `SettingsViewController`.
    ///
    /// - Parameter viewController: A reference to the used view controller.
    init(viewController: SettingsViewController?) {
        self.viewController = viewController
    }
}

// MARK: - SettingsRouterProtocol

extension SettingsRouter: SettingsRouterProtocol {

    // MARK: - Navigation

    func navigateToSomewhere() {
      // TODO: Navigate to other view controller
    }
}
