import UIKit

/**
  Data that will be directed out of the `JournalingPresenter` to the
  `JournalingViewController`. This protocol stores the presentation
  logic methods.
 */
protocol JournalingPresenterOutput: class {

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: JournalingViewModel)
}

/**
  Formats the response into a `JournalingViewModel` and pass the result back to
  the `JournalingViewController`. The `JournalingPresenter` will be in charge
  of the presentation logic. This component decides how the data will be
  presented to the user. Also, when there is a need for transition, it will 
  communicate with the `JournalingRouter`.
 */
final class JournalingPresenter {

    private(set) unowned var output: JournalingPresenterOutput
    private(set) var router: JournalingRouterProtocol

    // MARK: - Initializers

    /// This will initialize the `JournalingPresenter` using
    /// a given `JournalingPresenterOutput` and `JournalingRouter`.
    ///
    /// - Parameter output: A reference to the used output.
    /// - Parameter rozter: A reference to the used router.
    init(output: JournalingPresenterOutput, router: JournalingRouterProtocol) {
        self.output = output
        self.router = router
    }
}

// MARK: - JournalingInteractorOutput

extension JournalingPresenter: JournalingInteractorOutput {

    // MARK: - Presentation logic

    func presentUpdateAfterLoading() {

        // TODO: Format the response from the Interactor
        // and pass the result back to the View Controller

        // TODO: Trigger navigation if needed 

        let viewModel = JournalingViewModel()
        update(with: viewModel)
    }

    func update(with viewModel: JournalingViewModel) {
        output.update(with: viewModel)
    }
}
