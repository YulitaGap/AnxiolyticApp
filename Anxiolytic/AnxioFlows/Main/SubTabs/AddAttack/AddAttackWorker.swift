import UIKit

/**
 Data that will be directed towards the `AddAttackWorker` coming 
 from the `AddAttackInteractor`.
 */
protocol AddAttackWorkerInput: class {

    // swiftlint:disable:next implicitly_unwrapped_optional
    var output: AddAttackWorkerOutput! { get set }

    func doSomeWork()
}

/**
 Data that will be directed out of the `AddAttackWorker` to the
 `AddAttackInteractor`. This protocol is used to return data
 from the worker.
 */
protocol AddAttackWorkerOutput: class {

    func didSomeWork()
}

/**
  The `AddAttackWorker` component will handle all the API/Data requests
  and responses. The Response struct will get the data ready for the
  `AddAttackInteractor`. It will also handle the success/error response,
  so the `AddAttackInteractor` knows how to proceed.
 */
class AddAttackWorker: AddAttackWorkerInput {

    // swiftlint:disable:next implicitly_unwrapped_optional
    weak var output: AddAttackWorkerOutput!

    // MARK: - Initializers

    /// This will initialize the `AddAttackWorker` using
    /// a given `AddAttackWorkerOutput`.
    ///
    /// - Parameter output: A reference to the used output.
    init(output: AddAttackWorkerOutput? = nil) {
        if let output = output {
            self.output = output
        }
    }

    func doSomeWork() {
        output.didSomeWork()
    }
}
