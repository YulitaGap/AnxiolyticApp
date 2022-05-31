import UIKit

/**
  Stores all the models related to the `CalendarViewController`.
  The `CalendarViewModel's` class will be related to each component.
  The view model will contain Request, Response and ViewModel structs.
 */

struct Day {
  let date: Date
  let number: String
  let isSelected: Bool
  let isWithinDisplayedMonth: Bool
}

struct MonthMetadata {
  let numberOfDays: Int
  let firstDay: Date
  let firstDayWeekday: Int
}

struct CalendarViewModel {
    var days: [Day]
    var baseDate: Date
    var numberOfWeeksInBaseDate: Int
}
