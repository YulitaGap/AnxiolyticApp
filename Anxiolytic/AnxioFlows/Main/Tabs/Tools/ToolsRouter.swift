import UIKit

/**
  All the methods used for routing are kept under this protocol.
 */
protocol ToolsRouterProtocol: AnyObject {

    var viewController: ToolsViewController? { get }

    func navigateToSomewhere()
}

/**
  The `ToolsRouter` takes care for the transition and passing
  data between view controllers.
 */
final class ToolsRouter {

    weak var viewController: ToolsViewController?

    // MARK: - Initializers

    /// This will initialize the `ToolsRouter` using
    /// an optional `ToolsViewController`.
    ///
    /// - Parameter viewController: A reference to the used view controller.
    init(viewController: ToolsViewController?) {
        self.viewController = viewController
    }
}

// MARK: - ToolsRouterProtocol

extension ToolsRouter: ToolsRouterProtocol {

    // MARK: - Navigation

    func navigateToSomewhere() {
      // TODO: Navigate to other view controller
    }
}
