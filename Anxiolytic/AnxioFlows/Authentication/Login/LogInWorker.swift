import UIKit
import FirebaseAuth

/**
 Data that will be directed towards the `LogInWorker` coming 
 from the `LogInInteractor`.
 */
protocol LogInWorkerInput: AnyObject {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: LogInWorkerOutput! { get set }

    func attemptSignIn(email: String, password: String)
}

/**
 Data that will be directed out of the `LogInWorker` to the
 `LogInInteractor`. This protocol is used to return data
 from the worker.
 */
protocol LogInWorkerOutput: AnyObject {

    func didLoggedInUser()

    func didFailedLogginUser(error: Error)
}

/**
  The `LogInWorker` component will handle all the API/Data requests
  and responses. The Response struct will get the data ready for the
  `LogInInteractor`. It will also handle the success/error response,
  so the `LogInInteractor` knows how to proceed.
 */
class LogInWorker: LogInWorkerInput {

    // swiftlint:disable:next implicitly_unwrapped_optional
    weak var output: LogInWorkerOutput!

    // MARK: - Initializers

    /// This will initialize the `LogInWorker` using
    /// a given `LogInWorkerOutput`.
    ///
    /// - Parameter output: A reference to the used output.
    init(output: LogInWorkerOutput? = nil) {
        if let output = output {
            self.output = output
        }
    }

    func attemptSignIn(email: String, password: String) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { _, error in
            guard let authError = error  else {
                self.output.didLoggedInUser()
                return
            }
            self.output.didFailedLogginUser(error: authError)

        })
    }
}
