import UIKit

/**
  All the methods used for routing are kept under this protocol.
 */
protocol WelcomeRouterProtocol: AnyObject {

    var viewController: WelcomeViewController? { get }

    func navigateToLogIn()

    func navigateToRegister()
}

/**
  The `WelcomeRouter` takes care for the transition and passing
  data between view controllers.
 */
final class WelcomeRouter {

    weak var viewController: WelcomeViewController?

    // MARK: - Initializers

    /// This will initialize the `WelcomeRouter` using
    /// an optional `WelcomeViewController`.
    ///
    /// - Parameter viewController: A reference to the used view controller.
    init(viewController: WelcomeViewController?) {
        self.viewController = viewController
    }
}

// MARK: - WelcomeRouterProtocol

extension WelcomeRouter: WelcomeRouterProtocol {
    // MARK: - Navigation

    func navigateToLogIn() {

        let storyboard = UIStoryboard(name: "LogIn", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LogInViewController")
        viewController?.present(controller, animated: true, completion: nil)
    }

    func navigateToRegister() {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "RegisterViewController")
        viewController?.present(controller, animated: true, completion: nil)
    }
}
