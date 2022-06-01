import UIKit

/**
  Data that will be directed out of the `AddAttackPresenter` to the
  `AddAttackViewController`. This protocol stores the presentation
  logic methods.
 */
protocol AddAttackPresenterOutput: class {

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: AddAttackViewModel)
}

/**
  Formats the response into a `AddAttackViewModel` and pass the result back to
  the `AddAttackViewController`. The `AddAttackPresenter` will be in charge
  of the presentation logic. This component decides how the data will be
  presented to the user. Also, when there is a need for transition, it will 
  communicate with the `AddAttackRouter`.
 */
final class AddAttackPresenter {

    private(set) unowned var output: AddAttackPresenterOutput
    private(set) var router: AddAttackRouterProtocol

    // MARK: - Initializers

    /// This will initialize the `AddAttackPresenter` using
    /// a given `AddAttackPresenterOutput` and `AddAttackRouter`.
    ///
    /// - Parameter output: A reference to the used output.
    /// - Parameter rozter: A reference to the used router.
    init(output: AddAttackPresenterOutput, router: AddAttackRouterProtocol) {
        self.output = output
        self.router = router
    }
}

// MARK: - AddAttackInteractorOutput

extension AddAttackPresenter: AddAttackInteractorOutput {

    // MARK: - Presentation logic

    func presentUpdateAfterLoading() {

        // TODO: Format the response from the Interactor
        // and pass the result back to the View Controller

        // TODO: Trigger navigation if needed 

        let viewModel = AddAttackViewModel()
        update(with: viewModel)
    }

    func update(with viewModel: AddAttackViewModel) {
        output.update(with: viewModel)
    }
}
