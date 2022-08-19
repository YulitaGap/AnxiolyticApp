import UIKit

/**
  All the methods used for routing are kept under this protocol.
 */
protocol ProvideReasonRouterProtocol: class {

    var viewController: ProvideReasonViewController? { get }

    func navigateToSomewhere()
}

/**
  The `ProvideReasonRouter` takes care for the transition and passing
  data between view controllers.
 */
final class ProvideReasonRouter {

    weak var viewController: ProvideReasonViewController?

    // MARK: - Initializers

    /// This will initialize the `ProvideReasonRouter` using
    /// an optional `ProvideReasonViewController`.
    ///
    /// - Parameter viewController: A reference to the used view controller.
    init(viewController: ProvideReasonViewController?) {
        self.viewController = viewController
    }
}

// MARK: - ProvideReasonRouterProtocol

extension ProvideReasonRouter: ProvideReasonRouterProtocol {

    // MARK: - Navigation

    func navigateToSomewhere() {
      // TODO: Navigate to other view controller
    }
}
