import UIKit

/**
  All the methods used for routing are kept under this protocol.
 */
protocol MeditationsRouterProtocol: class {

    var viewController: MeditationsViewController? { get }

    func navigateToSomewhere()
}

/**
  The `MeditationsRouter` takes care for the transition and passing
  data between view controllers.
 */
final class MeditationsRouter {

    weak var viewController: MeditationsViewController?

    // MARK: - Initializers

    /// This will initialize the `MeditationsRouter` using
    /// an optional `MeditationsViewController`.
    ///
    /// - Parameter viewController: A reference to the used view controller.
    init(viewController: MeditationsViewController?) {
        self.viewController = viewController
    }
}

// MARK: - MeditationsRouterProtocol

extension MeditationsRouter: MeditationsRouterProtocol {

    // MARK: - Navigation

    func navigateToSomewhere() {
      // TODO: Navigate to other view controller
    }
}
