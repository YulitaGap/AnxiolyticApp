import UIKit

/**
  Data that will be directed out of the `SettingsPresenter` to the
  `SettingsViewController`. This protocol stores the presentation
  logic methods.
 */
protocol SettingsPresenterOutput: AnyObject {

    /// Triggers an update with the new view model.
    ///
    /// - parameter viewModel: View model which will be applied. 
    func update(with viewModel: SettingsViewModel)
}

/**
  Formats the response into a `SettingsViewModel` and pass the result back to
  the `SettingsViewController`. The `SettingsPresenter` will be in charge
  of the presentation logic. This component decides how the data will be
  presented to the user. Also, when there is a need for transition, it will 
  communicate with the `SettingsRouter`.
 */
final class SettingsPresenter {

    private(set) unowned var output: SettingsPresenterOutput
    private(set) var router: SettingsRouterProtocol

    // MARK: - Initializers

    /// This will initialize the `SettingsPresenter` using
    /// a given `SettingsPresenterOutput` and `SettingsRouter`.
    ///
    /// - Parameter output: A reference to the used output.
    /// - Parameter rozter: A reference to the used router.
    init(output: SettingsPresenterOutput, router: SettingsRouterProtocol) {
        self.output = output
        self.router = router
    }
}

// MARK: - SettingsInteractorOutput

extension SettingsPresenter: SettingsInteractorOutput {

    // MARK: - Presentation logic

    func presentUpdateAfterLoading() {let viewModel = SettingsViewModel()
        update(with: viewModel)
    }

    func update(with viewModel: SettingsViewModel) {
        output.update(with: viewModel)
    }
}
