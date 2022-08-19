import UIKit

/**
  All the methods used for routing are kept under this protocol.
 */
protocol JournalingRouterProtocol: class {

    var viewController: JournalingViewController? { get }

    func navigateToSomewhere()
}

/**
  The `JournalingRouter` takes care for the transition and passing
  data between view controllers.
 */
final class JournalingRouter {

    weak var viewController: JournalingViewController?

    // MARK: - Initializers

    /// This will initialize the `JournalingRouter` using
    /// an optional `JournalingViewController`.
    ///
    /// - Parameter viewController: A reference to the used view controller.
    init(viewController: JournalingViewController?) {
        self.viewController = viewController
    }
}

// MARK: - JournalingRouterProtocol

extension JournalingRouter: JournalingRouterProtocol {

    // MARK: - Navigation

    func navigateToSomewhere() {
      // TODO: Navigate to other view controller
    }
}
