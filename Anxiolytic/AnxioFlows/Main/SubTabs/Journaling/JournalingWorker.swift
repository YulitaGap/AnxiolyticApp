import UIKit

/**
 Data that will be directed towards the `JournalingWorker` coming 
 from the `JournalingInteractor`.
 */
protocol JournalingWorkerInput: class {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: JournalingWorkerOutput! { get set }

    func doSomeWork()
}

/**
 Data that will be directed out of the `JournalingWorker` to the
 `JournalingInteractor`. This protocol is used to return data
 from the worker.
 */
protocol JournalingWorkerOutput: class {
    
    func didSomeWork()
}

/**
  The `JournalingWorker` component will handle all the API/Data requests
  and responses. The Response struct will get the data ready for the
  `JournalingInteractor`. It will also handle the success/error response,
  so the `JournalingInteractor` knows how to proceed.
 */
class JournalingWorker: JournalingWorkerInput {

    // swiftlint:disable:next implicitly_unwrapped_optional
    weak var output: JournalingWorkerOutput!

    // MARK: - Initializers

    /// This will initialize the `JournalingWorker` using
    /// a given `JournalingWorkerOutput`.
    ///
    /// - Parameter output: A reference to the used output.
    init(output: JournalingWorkerOutput? = nil) {
        if let output = output {
            self.output = output
        }
    }

    func doSomeWork() {
        output.didSomeWork()
    }
}
