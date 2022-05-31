import UIKit

/**
  All the methods used for routing are kept under this protocol.
 */
protocol DashboardRouterProtocol: class {

    var viewController: DashboardViewController? { get }

    func navigateToSomewhere()
}

/**
  The `DashboardRouter` takes care for the transition and passing
  data between view controllers.
 */
final class DashboardRouter {

    weak var viewController: DashboardViewController?

    // MARK: - Initializers

    /// This will initialize the `DashboardRouter` using
    /// an optional `DashboardViewController`.
    ///
    /// - Parameter viewController: A reference to the used view controller.
    init(viewController: DashboardViewController?) {
        self.viewController = viewController
    }
}

// MARK: - DashboardRouterProtocol

extension DashboardRouter: DashboardRouterProtocol {

    // MARK: - Navigation

    func navigateToSomewhere() {
      // TODO: Navigate to other view controller
    }
}
