import UIKit

class CalendarView {
    private lazy var headerView = CalendarPickerHeaderView { [weak self] in
      guard let self = self else { return }

      self.dismiss(animated: true)
    }

    private lazy var footerView = CalendarPickerFooterView(
      didTapLastMonthCompletionHandler: { [weak self] in
      guard let self = self else { return }

      self.baseDate = self.calendar.date(
        byAdding: .month,
        value: -1,
        to: self.baseDate
        ) ?? self.baseDate
      },
      didTapNextMonthCompletionHandler: { [weak self] in
        guard let self = self else { return }

        self.baseDate = self.calendar.date(
          byAdding: .month,
          value: 1,
          to: self.baseDate
          ) ?? self.baseDate
      }
    )

    // MARK: Calendar Data Values

    private let selectedDate: Date
    private var baseDate: Date {
      didSet {
        days = generateDaysInMonth(for: baseDate)
        collectionView.reloadData()
        headerView.baseDate = baseDate
      }
    }

    private lazy var days = generateDaysInMonth(for: baseDate)

    private var numberOfWeeksInBaseDate: Int {
      calendar.range(of: .weekOfMonth, in: .month, for: baseDate)?.count ?? 0
    }

    private let selectedDateChanged: ((Date) -> Void)
    private let calendar = Calendar(identifier: .gregorian)

    private lazy var dateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "d"
      return dateFormatter
    }()
}

// MARK: - Day Generation
private extension CalendarView {
  func monthMetadata(for baseDate: Date) throws -> MonthMetadata {
    guard
      let numberOfDaysInMonth = calendar.range(
        of: .day,
        in: .month,
        for: baseDate
      )?.count,
      let firstDayOfMonth = calendar.date(
        from: calendar.dateComponents([.year, .month], from: baseDate)
      )
      else {
        // 3
        throw CalendarDataError.metadataGeneration
    }

    let firstDayWeekday = calendar.component(.weekday, from: firstDayOfMonth)

    return MonthMetadata(
        numberOfDays: numberOfDaysInMonth,
        firstDay: firstDayOfMonth,
        firstDayWeekday: firstDayWeekday
      )
  }

  // 1
  func generateDaysInMonth(for baseDate: Date) -> [Day] {
    // 2
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

    return days
  }

  func generateDay(
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
      isSelected: calendar.isDate(date, inSameDayAs: selectedDate),
      isWithinDisplayedMonth: isWithinDisplayedMonth
    )
  }

  // 1
  func generateStartOfNextMonth(
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

  enum CalendarDataError: Error {
    case metadataGeneration
  }
}

// MARK: - UICollectionViewDataSource
extension CalendarPickerViewController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    days.count
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let day = days[indexPath.row]

    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: CalendarDateCollectionViewCell.reuseIdentifier,
      for: indexPath
    ) as! CalendarDateCollectionViewCell
    // swiftlint:disable:previous force_cast

    cell.day = day
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CalendarPickerViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    let day = days[indexPath.row]
    selectedDateChanged(day.date)
    dismiss(animated: true, completion: nil)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let width = Int(collectionView.frame.width / 7)
    let height = Int(collectionView.frame.height) / numberOfWeeksInBaseDate
    return CGSize(width: width, height: height)
  }
}
