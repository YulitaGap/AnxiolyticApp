import UIKit

/**
  All the methods used for routing are kept under this protocol.
 */
protocol AddAttackRouterProtocol: class {

    var viewController: AddAttackViewController? { get }

    func navigateToSomewhere()
}

/**
  The `AddAttackRouter` takes care for the transition and passing
  data between view controllers.
 */
final class AddAttackRouter {

    weak var viewController: AddAttackViewController?

    // MARK: - Initializers

    /// This will initialize the `AddAttackRouter` using
    /// an optional `AddAttackViewController`.
    ///
    /// - Parameter viewController: A reference to the used view controller.
    init(viewController: AddAttackViewController?) {
        self.viewController = viewController
    }
}

// MARK: - AddAttackRouterProtocol

extension AddAttackRouter: AddAttackRouterProtocol {

    // MARK: - Navigation

    func navigateToSomewhere() {
      // TODO: Navigate to other view controller
    }
}
