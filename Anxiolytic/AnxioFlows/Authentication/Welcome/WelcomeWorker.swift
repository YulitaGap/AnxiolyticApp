import UIKit
import FirebaseAuth
/**
 Data that will be directed towards the `WelcomeWorker` coming 
 from the `WelcomeInteractor`.
 */
protocol WelcomeWorkerInput: AnyObject {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: WelcomeWorkerOutput! { get set }

    func checkIfLogged()

}

/**
 Data that will be directed out of the `WelcomeWorker` to the
 `WelcomeInteractor`. This protocol is used to return data
 from the worker.
 */
protocol WelcomeWorkerOutput: AnyObject {

    func foundLoggedUser(user: User)

    func noLoggedUserFound()
}

/**
  The `WelcomeWorker` component will handle all the API/Data requests
  and responses. The Response struct will get the data ready for the
  `WelcomeInteractor`. It will also handle the success/error response,
  so the `WelcomeInteractor` knows how to proceed.
 */
class WelcomeWorker: WelcomeWorkerInput {

    // swiftlint:disable:next implicitly_unwrapped_optional
    weak var output: WelcomeWorkerOutput!

    // MARK: - Initializers

    /// This will initialize the `WelcomeWorker` using
    /// a given `WelcomeWorkerOutput`.
    ///
    /// - Parameter output: A reference to the used output.
    init(output: WelcomeWorkerOutput? = nil) {
        if let output = output {
            self.output = output
        }
    }

    func checkIfLogged() {
        FirebaseAuth.Auth.auth().addStateDidChangeListener { [self] _, user in
            guard let user = user else {
                // No user is signed in.
                self.output.noLoggedUserFound()
                return
            }
            self.output.foundLoggedUser(user: user)
        }
    }
}
