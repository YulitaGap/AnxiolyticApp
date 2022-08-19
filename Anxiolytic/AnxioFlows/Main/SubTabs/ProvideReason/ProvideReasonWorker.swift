import UIKit

/**
 Data that will be directed towards the `ProvideReasonWorker` coming 
 from the `ProvideReasonInteractor`.
 */
protocol ProvideReasonWorkerInput: class {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: ProvideReasonWorkerOutput! { get set }

    func doSomeWork()
}

/**
 Data that will be directed out of the `ProvideReasonWorker` to the
 `ProvideReasonInteractor`. This protocol is used to return data
 from the worker.
 */
protocol ProvideReasonWorkerOutput: class {
    
    func didSomeWork()
}

/**
  The `ProvideReasonWorker` component will handle all the API/Data requests
  and responses. The Response struct will get the data ready for the
  `ProvideReasonInteractor`. It will also handle the success/error response,
  so the `ProvideReasonInteractor` knows how to proceed.
 */
class ProvideReasonWorker: ProvideReasonWorkerInput {

    // swiftlint:disable:next implicitly_unwrapped_optional
    weak var output: ProvideReasonWorkerOutput!

    // MARK: - Initializers

    /// This will initialize the `ProvideReasonWorker` using
    /// a given `ProvideReasonWorkerOutput`.
    ///
    /// - Parameter output: A reference to the used output.
    init(output: ProvideReasonWorkerOutput? = nil) {
        if let output = output {
            self.output = output
        }
    }

    func doSomeWork() {
        output.didSomeWork()
    }
}
