import UIKit

/**
  Data that will be directed out of the `MeditationsPresenter` to the
  `MeditationsViewController`. This protocol stores the presentation
  logic methods.
 */
protocol MeditationsPresenterOutput: class {

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: MeditationsViewModel)
}

/**
  Formats the response into a `MeditationsViewModel` and pass the result back to
  the `MeditationsViewController`. The `MeditationsPresenter` will be in charge
  of the presentation logic. This component decides how the data will be
  presented to the user. Also, when there is a need for transition, it will 
  communicate with the `MeditationsRouter`.
 */
final class MeditationsPresenter {

    private(set) unowned var output: MeditationsPresenterOutput
    private(set) var router: MeditationsRouterProtocol

    // MARK: - Initializers

    /// This will initialize the `MeditationsPresenter` using
    /// a given `MeditationsPresenterOutput` and `MeditationsRouter`.
    ///
    /// - Parameter output: A reference to the used output.
    /// - Parameter rozter: A reference to the used router.
    init(output: MeditationsPresenterOutput, router: MeditationsRouterProtocol) {
        self.output = output
        self.router = router
    }
}

// MARK: - MeditationsInteractorOutput

extension MeditationsPresenter: MeditationsInteractorOutput {

    // MARK: - Presentation logic

    func presentUpdateAfterLoading() {

        // TODO: Format the response from the Interactor
        // and pass the result back to the View Controller

        // TODO: Trigger navigation if needed 

        let viewModel = MeditationsViewModel()
        update(with: viewModel)
    }

    func update(with viewModel: MeditationsViewModel) {
        output.update(with: viewModel)
    }
}
