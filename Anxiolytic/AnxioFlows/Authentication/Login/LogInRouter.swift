import UIKit

/**
  All the methods used for routing are kept under this protocol.
 */
protocol LogInRouterProtocol: AnyObject {

    var viewController: LogInViewController? { get }

    func navigateToDashboard()

    func navigateToRegisterScreen()
}

/**
  The `LogInRouter` takes care for the transition and passing
  data between view controllers.
 */
final class LogInRouter {

    weak var viewController: LogInViewController?

    // MARK: - Initializers

    /// This will initialize the `LogInRouter` using
    /// an optional `LogInViewController`.
    ///
    /// - Parameter viewController: A reference to the used view controller.
    init(viewController: LogInViewController?) {
        self.viewController = viewController
    }
}

// MARK: - LogInRouterProtocol

extension LogInRouter: LogInRouterProtocol {

    // MARK: - Navigation

    func navigateToDashboard() {
        weak var pvc = viewController?.presentingViewController
        viewController?.dismiss(animated: true, completion: {
            let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")
            controller.modalPresentationStyle = .fullScreen
            pvc?.present(controller, animated: true, completion: nil)
        })
    }

    func navigateToRegisterScreen() {weak var pvc = viewController?.presentingViewController
        viewController?.dismiss(animated: true, completion: {
            let storyboard = UIStoryboard(name: "Register", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "RegisterViewController")
            pvc?.present(controller, animated: true, completion: nil)
        })
    }
}
