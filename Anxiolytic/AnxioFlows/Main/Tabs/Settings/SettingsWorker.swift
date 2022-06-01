import UIKit
import FirebaseAuth
/**
 Data that will be directed towards the `SettingsWorker` coming 
 from the `SettingsInteractor`.
 */
protocol SettingsWorkerInput: AnyObject {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: SettingsWorkerOutput! { get set }

    func logOutUser()

}

/**
 Data that will be directed out of the `SettingsWorker` to the
 `SettingsInteractor`. This protocol is used to return data
 from the worker.
 */
protocol SettingsWorkerOutput: AnyObject {
    func didFailedLogOut(error: Error)

    func didLoggedOut()
}

/**
  The `SettingsWorker` component will handle all the API/Data requests
  and responses. The Response struct will get the data ready for the
  `SettingsInteractor`. It will also handle the success/error response,
  so the `SettingsInteractor` knows how to proceed.
 */
class SettingsWorker: SettingsWorkerInput {

    // swiftlint:disable:next implicitly_unwrapped_optional
    weak var output: SettingsWorkerOutput!

    // MARK: - Initializers

    /// This will initialize the `SettingsWorker` using
    /// a given `SettingsWorkerOutput`.
    ///
    /// - Parameter output: A reference to the used output.
    init(output: SettingsWorkerOutput? = nil) {
        if let output = output {
            self.output = output
        }
    }

    func logOutUser() {
        do {
           try Auth.auth().signOut()
            output.didLoggedOut()
         } catch let logoutError {
             output.didFailedLogOut(error: logoutError)
         }
    }

}
