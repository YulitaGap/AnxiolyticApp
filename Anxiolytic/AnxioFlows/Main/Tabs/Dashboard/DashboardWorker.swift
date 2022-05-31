import UIKit

/**
 Data that will be directed towards the `DashboardWorker` coming 
 from the `DashboardInteractor`.
 */
protocol DashboardWorkerInput: AnyObject {

    var output: DashboardWorkerOutput! { get set }

    func generateCalendarData(for baseDate: Date)
}

/**
 Data that will be directed out of the `DashboardWorker` to the
 `DashboardInteractor`. This protocol is used to return data
 from the worker.
 */
protocol DashboardWorkerOutput: AnyObject {

    func didGenerateCaldendarData(days: [Day])
}

/**
  The `DashboardWorker` component will handle all the API/Data requests
  and responses. The Response struct will get the data ready for the
  `DashboardInteractor`. It will also handle the success/error response,
  so the `DashboardInteractor` knows how to proceed.
 */
class DashboardWorker: DashboardWorkerInput {
    weak var output: DashboardWorkerOutput!

    private let calendar = Calendar(identifier: .gregorian)

    enum CalendarDataError: Error {
      case metadataGeneration
    }

    private lazy var dateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "d"
      return dateFormatter
    }()

    // MARK: - Initializers

    /// This will initialize the `DashboardWorker` using
    /// a given `DashboardWorkerOutput`.
    ///
    /// - Parameter output: A reference to the used output.
    init(output: DashboardWorkerOutput? = nil) {
        if let output = output {
            self.output = output
        }
    }

    func generateCalendarData(for baseDate: Date) {
      guard let metadata = try? monthMetadata(for: baseDate) else {
        preconditionFailure("An error occurred when generating the metadata for \(baseDate)")
      }

      let numberOfDaysInMonth = metadata.numberOfDays
      let offsetInInitialRow = metadata.firstDayWeekday
      let firstDayOfMonth = metadata.firstDay

      // 3
      var days: [Day] = (1..<(numberOfDaysInMonth + offsetInInitialRow))
        .map { day in
          let isWithinDisplayedMonth = day >= offsetInInitialRow
          let dayOffset =
            isWithinDisplayedMonth ?
            day - offsetInInitialRow :
            -(offsetInInitialRow - day)

          return generateDay(
            offsetBy: dayOffset,
            for: firstDayOfMonth,
            isWithinDisplayedMonth: isWithinDisplayedMonth
          )
        }

        days += generateStartOfNextMonth(using: firstDayOfMonth)
        output.didGenerateCaldendarData(days: days)
    }

    private func monthMetadata(for baseDate: Date) throws -> MonthMetadata {
        guard
            let numberOfDaysInMonth = calendar.range(
              of: .day,
              in: .month,
              for: baseDate
            )?.count,
            let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: baseDate))
        else {
          throw CalendarDataError.metadataGeneration
        }

      let firstDayWeekday = calendar.component(.weekday, from: firstDayOfMonth)

      return MonthMetadata(
        numberOfDays: numberOfDaysInMonth,
        firstDay: firstDayOfMonth,
        firstDayWeekday: firstDayWeekday
      )
    }

    private func generateDay(
      offsetBy dayOffset: Int,
      for baseDate: Date,
      isWithinDisplayedMonth: Bool
    ) -> Day {
      let date = calendar.date(
        byAdding: .day,
        value: dayOffset,
        to: baseDate
      )
        ?? baseDate

      return Day(
        date: date,
        number: dateFormatter.string(from: date),
        isSelected: calendar.isDate(date, inSameDayAs: baseDate),
        isWithinDisplayedMonth: isWithinDisplayedMonth
      )
    }

    private   func generateStartOfNextMonth(
        using firstDayOfDisplayedMonth: Date
        ) -> [Day] {
        // 2
        guard
          let lastDayInMonth = calendar.date(
            byAdding: DateComponents(month: 1, day: -1),
            to: firstDayOfDisplayedMonth
          )
          else {
            return []
        }

        // 3
        let additionalDays = 7 - calendar.component(.weekday, from: lastDayInMonth)
        guard additionalDays > 0 else {
          return []
        }

        // 4
        let days: [Day] = (1...additionalDays)
          .map {
            generateDay(
            offsetBy: $0,
            for: lastDayInMonth,
            isWithinDisplayedMonth: false
            )
          }

        return days
      }

}
