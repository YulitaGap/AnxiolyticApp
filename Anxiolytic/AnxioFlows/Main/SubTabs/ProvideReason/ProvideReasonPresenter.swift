import UIKit

/**
  Data that will be directed out of the `ProvideReasonPresenter` to the
  `ProvideReasonViewController`. This protocol stores the presentation
  logic methods.
 */
protocol ProvideReasonPresenterOutput: class {

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: ProvideReasonViewModel)
}

/**
  Formats the response into a `ProvideReasonViewModel` and pass the result back to
  the `ProvideReasonViewController`. The `ProvideReasonPresenter` will be in charge
  of the presentation logic. This component decides how the data will be
  presented to the user. Also, when there is a need for transition, it will 
  communicate with the `ProvideReasonRouter`.
 */
final class ProvideReasonPresenter {

    private(set) unowned var output: ProvideReasonPresenterOutput
    private(set) var router: ProvideReasonRouterProtocol

    // MARK: - Initializers

    /// This will initialize the `ProvideReasonPresenter` using
    /// a given `ProvideReasonPresenterOutput` and `ProvideReasonRouter`.
    ///
    /// - Parameter output: A reference to the used output.
    /// - Parameter rozter: A reference to the used router.
    init(output: ProvideReasonPresenterOutput, router: ProvideReasonRouterProtocol) {
        self.output = output
        self.router = router
    }
}

// MARK: - ProvideReasonInteractorOutput

extension ProvideReasonPresenter: ProvideReasonInteractorOutput {

    // MARK: - Presentation logic

    func presentUpdateAfterLoading() {

        // TODO: Format the response from the Interactor
        // and pass the result back to the View Controller

        // TODO: Trigger navigation if needed 

        let viewModel = ProvideReasonViewModel()
        update(with: viewModel)
    }

    func update(with viewModel: ProvideReasonViewModel) {
        output.update(with: viewModel)
    }
}
