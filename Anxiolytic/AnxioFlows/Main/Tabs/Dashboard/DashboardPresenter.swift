import UIKit

/**
  Data that will be directed out of the `DashboardPresenter` to the
  `DashboardViewController`. This protocol stores the presentation
  logic methods.
 */
protocol DashboardPresenterOutput: AnyObject {

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: DashboardViewModel)
}

/**
  Formats the response into a `DashboardViewModel` and pass the result back to
  the `DashboardViewController`. The `DashboardPresenter` will be in charge
  of the presentation logic. This component decides how the data will be
  presented to the user. Also, when there is a need for transition, it will 
  communicate with the `DashboardRouter`.
 */
final class DashboardPresenter {

    private(set) unowned var output: DashboardPresenterOutput
    private(set) var router: DashboardRouterProtocol
    private var viewModel = DashboardViewModel()

    // MARK: - Initializers

    /// This will initialize the `DashboardPresenter` using
    /// a given `DashboardPresenterOutput` and `DashboardRouter`.
    ///
    /// - Parameter output: A reference to the used output.
    /// - Parameter rozter: A reference to the used router.
    init(output: DashboardPresenterOutput, router: DashboardRouterProtocol) {
        self.output = output
        self.router = router
    }
}

// MARK: - DashboardInteractorOutput

extension DashboardPresenter: DashboardInteractorOutput {

    // MARK: - Presentation logic

    func presentUpdateAfterLoading() {
        let viewModel = DashboardViewModel()
        update(with: viewModel)
    }

    func update(with viewModel: DashboardViewModel) {
        output.update(with: viewModel)
    }

    func provideBaseDate() -> Date {
        return viewModel.baseDate
    }
}
