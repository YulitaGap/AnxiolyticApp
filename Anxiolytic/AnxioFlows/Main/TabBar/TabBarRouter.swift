import UIKit

/**
  All the methods used for routing are kept under this protocol.
 */
protocol TabBarRouterProtocol: AnyObject {

    var viewController: TabBarViewController? { get }

    func navigateToSomewhere()
}

/**
  The `TabBarRouter` takes care for the transition and passing
  data between view controllers.
 */
final class TabBarRouter {

    weak var viewController: TabBarViewController?

    // MARK: - Initializers

    /// This will initialize the `TabBarRouter` using
    /// an optional `TabBarViewController`.
    ///
    /// - Parameter viewController: A reference to the used view controller.
    init(viewController: TabBarViewController?) {
        self.viewController = viewController
    }
}

// MARK: - TabBarRouterProtocol

extension TabBarRouter: TabBarRouterProtocol {

    // MARK: - Navigation

    func navigateToSomewhere() {
      // TODO: Navigate to other view controller
    }
}
