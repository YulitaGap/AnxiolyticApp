import UIKit

/**
  All the methods used for routing are kept under this protocol.
 */
protocol DashboardRouterProtocol: AnyObject {

    var viewController: DashboardViewController? { get }

    func navigateToCreateAttack()
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

    func navigateToCreateAttack() {
        let storyboard = UIStoryboard(name: "AddAttack", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AddAttack")
        viewController?.navigationController?.navigationBar.barStyle = UIBarStyle.black
        viewController?.navigationController?.navigationBar.tintColor = UIColor.white
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
}
