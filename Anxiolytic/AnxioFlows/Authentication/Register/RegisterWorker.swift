import UIKit
import FirebaseAuth

/**
 Data that will be directed towards the `RegisterWorker` coming 
 from the `RegisterInteractor`.
 */
protocol RegisterWorkerInput: AnyObject {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: RegisterWorkerOutput! { get set }

    func attemptRegister(email: String, password: String)
}

/**
 Data that will be directed out of the `RegisterWorker` to the
 `RegisterInteractor`. This protocol is used to return data
 from the worker.
 */
protocol RegisterWorkerOutput: AnyObject {

    func didFailedRegisterUser()
    func didRegisterUser()
}

/**
  The `RegisterWorker` component will handle all the API/Data requests
  and responses. The Response struct will get the data ready for the
  `RegisterInteractor`. It will also handle the success/error response,
  so the `RegisterInteractor` knows how to proceed.
 */
class RegisterWorker: RegisterWorkerInput {

    // swiftlint:disable:next implicitly_unwrapped_optional
    weak var output: RegisterWorkerOutput!

    // MARK: - Initializers

    /// This will initialize the `RegisterWorker` using
    /// a given `RegisterWorkerOutput`.
    ///
    /// - Parameter output: A reference to the used output.
    init(output: RegisterWorkerOutput? = nil) {
        if let output = output {
            self.output = output
        }
    }

    func attemptRegister(email: String, password: String) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { _, error in guard error == nil else {
                self.output.didFailedRegisterUser()
                return
            }
            self.output.didRegisterUser()
        })
    }
}
