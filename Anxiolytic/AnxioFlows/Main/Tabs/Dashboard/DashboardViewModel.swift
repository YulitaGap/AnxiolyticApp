import UIKit

/**
  Stores all the models related to the `DashboardViewController`.
  The `DashboardViewModel's` class will be related to each component.
  The view model will contain Request, Response and ViewModel structs.
 */
struct DashboardViewModel {

    let calendar = Calendar(identifier: .gregorian)

    var backgroundColour: UIColor = Attributes.Colors.truewhite

    var days: [Day] = []

    var baseDate = Date()

    var numberOfWeeksInBaseDate: Int { calendar.range(of: .weekOfMonth, in: .month, for: baseDate)?.count ?? 0
    }
}
