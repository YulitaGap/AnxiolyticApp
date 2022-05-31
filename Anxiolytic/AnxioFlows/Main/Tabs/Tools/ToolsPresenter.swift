import UIKit

/**
  Data that will be directed out of the `ToolsPresenter` to the
  `ToolsViewController`. This protocol stores the presentation
  logic methods.
 */
protocol ToolsPresenterOutput: AnyObject {

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: ToolsViewModel)
}

/**
  Formats the response into a `ToolsViewModel` and pass the result back to
  the `ToolsViewController`. The `ToolsPresenter` will be in charge
  of the presentation logic. This component decides how the data will be
  presented to the user. Also, when there is a need for transition, it will 
  communicate with the `ToolsRouter`.
 */
final class ToolsPresenter {

    private(set) unowned var output: ToolsPresenterOutput
    private(set) var router: ToolsRouterProtocol

    // MARK: - Initializers

    /// This will initialize the `ToolsPresenter` using
    /// a given `ToolsPresenterOutput` and `ToolsRouter`.
    ///
    /// - Parameter output: A reference to the used output.
    /// - Parameter rozter: A reference to the used router.
    init(output: ToolsPresenterOutput, router: ToolsRouterProtocol) {
        self.output = output
        self.router = router
    }
}

// MARK: - ToolsInteractorOutput

extension ToolsPresenter: ToolsInteractorOutput {

    // MARK: - Presentation logic

    func presentUpdateAfterLoading() {
        let viewModel = ToolsViewModel()
        update(with: viewModel)
    }

    func update(with viewModel: ToolsViewModel) {
        output.update(with: viewModel)
    }
}
