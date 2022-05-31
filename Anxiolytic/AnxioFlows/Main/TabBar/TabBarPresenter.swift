import UIKit

/**
  Data that will be directed out of the `TabBarPresenter` to the
  `TabBarViewController`. This protocol stores the presentation
  logic methods.
 */
protocol TabBarPresenterOutput: AnyObject {

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: TabBarViewModel)
}

/**
  Formats the response into a `TabBarViewModel` and pass the result back to
  the `TabBarViewController`. The `TabBarPresenter` will be in charge
  of the presentation logic. This component decides how the data will be
  presented to the user. Also, when there is a need for transition, it will 
  communicate with the `TabBarRouter`.
 */
final class TabBarPresenter {

    private(set) unowned var output: TabBarPresenterOutput
    private(set) var router: TabBarRouterProtocol

    // MARK: - Initializers

    /// This will initialize the `TabBarPresenter` using
    /// a given `TabBarPresenterOutput` and `TabBarRouter`.
    ///
    /// - Parameter output: A reference to the used output.
    /// - Parameter rozter: A reference to the used router.
    init(output: TabBarPresenterOutput, router: TabBarRouterProtocol) {
        self.output = output
        self.router = router
    }
}

// MARK: - TabBarInteractorOutput

extension TabBarPresenter: TabBarInteractorOutput {

    // MARK: - Presentation logic

    func presentUpdateAfterLoading() {

        // TODO: Format the response from the Interactor
        // and pass the result back to the View Controller

        // TODO: Trigger navigation if needed 

        let viewModel = TabBarViewModel()
        update(with: viewModel)
    }

    func update(with viewModel: TabBarViewModel) {
        output.update(with: viewModel)
    }
}
