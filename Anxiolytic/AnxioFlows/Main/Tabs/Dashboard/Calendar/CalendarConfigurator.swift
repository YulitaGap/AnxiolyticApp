import UIKit

/**
  Helper service that configures a `CalendarViewController` with the
  necessary CleanArchitecture reference classes.
 */
final class CalendarConfigurator {

    /// Configures a given `CalendarViewController` with
    /// the necessary reference.
    ///
    /// - Parameter viewController: The view controller to be configured.
    static func configure(viewController: CalendarViewController) {
        let router = CalendarRouter(viewController: viewController)
        let presenter = CalendarPresenter(output: viewController, router: router)
        let interactor = CalendarInteractor(output: presenter)

        viewController.output = interactor
    }
}
