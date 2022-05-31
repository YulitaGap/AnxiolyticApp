import UIKit

/**
  All the methods used for routing are kept under this protocol.
 */
protocol RegisterRouterProtocol: AnyObject {

    var viewController: RegisterViewController? { get }

    func navigateToDashboard()
}

/**
  The `RegisterRouter` takes care for the transition and passing
  data between view controllers.
 */
final class RegisterRouter {

    weak var viewController: RegisterViewController?

    // MARK: - Initializers

    /// This will initialize the `RegisterRouter` using
    /// an optional `RegisterViewController`.
    ///
    /// - Parameter viewController: A reference to the used view controller.
    init(viewController: RegisterViewController?) {
        self.viewController = viewController
    }
}

// MARK: - RegisterRouterProtocol

extension RegisterRouter: RegisterRouterProtocol {

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
}
