import UIKit

/**
 Data that will be directed towards the `MeditationsWorker` coming 
 from the `MeditationsInteractor`.
 */
protocol MeditationsWorkerInput: class {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: MeditationsWorkerOutput! { get set }

    func doSomeWork()
}

/**
 Data that will be directed out of the `MeditationsWorker` to the
 `MeditationsInteractor`. This protocol is used to return data
 from the worker.
 */
protocol MeditationsWorkerOutput: class {
    
    func didSomeWork()
}

/**
  The `MeditationsWorker` component will handle all the API/Data requests
  and responses. The Response struct will get the data ready for the
  `MeditationsInteractor`. It will also handle the success/error response,
  so the `MeditationsInteractor` knows how to proceed.
 */
class MeditationsWorker: MeditationsWorkerInput {

    // swiftlint:disable:next implicitly_unwrapped_optional
    weak var output: MeditationsWorkerOutput!

    // MARK: - Initializers

    /// This will initialize the `MeditationsWorker` using
    /// a given `MeditationsWorkerOutput`.
    ///
    /// - Parameter output: A reference to the used output.
    init(output: MeditationsWorkerOutput? = nil) {
        if let output = output {
            self.output = output
        }
    }

    func doSomeWork() {
        output.didSomeWork()
    }
}
