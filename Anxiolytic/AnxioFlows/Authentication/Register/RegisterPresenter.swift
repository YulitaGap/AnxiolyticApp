import UIKit

/**
  Data that will be directed out of the `RegisterPresenter` to the
  `RegisterViewController`. This protocol stores the presentation
  logic methods.
 */
protocol RegisterPresenterOutput: AnyObject {

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: RegisterViewModel)
}

/**
  Formats the response into a `RegisterViewModel` and pass the result back to
  the `RegisterViewController`. The `RegisterPresenter` will be in charge
  of the presentation logic. This component decides how the data will be
  presented to the user. Also, when there is a need for transition, it will 
  communicate with the `RegisterRouter`.
 */
final class RegisterPresenter {

    private(set) unowned var output: RegisterPresenterOutput
    private(set) var router: RegisterRouterProtocol

    // MARK: - Initializers

    /// This will initialize the `RegisterPresenter` using
    /// a given `RegisterPresenterOutput` and `RegisterRouter`.
    ///
    /// - Parameter output: A reference to the used output.
    /// - Parameter rozter: A reference to the used router.
    init(output: RegisterPresenterOutput, router: RegisterRouterProtocol) {
        self.output = output
        self.router = router
    }
}

// MARK: - RegisterInteractorOutput

extension RegisterPresenter: RegisterInteractorOutput {
    // MARK: - Presentation logic

    func presentUpdateAfterLoading() {
        let viewModel = RegisterViewModel()
        update(with: viewModel)
    }

    func presentDashboard() {
        router.navigateToDashboard()
    }

    func update(with viewModel: RegisterViewModel) {
        output.update(with: viewModel)
    }
}
