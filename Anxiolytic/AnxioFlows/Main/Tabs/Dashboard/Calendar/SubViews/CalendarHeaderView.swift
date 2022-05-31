import UIKit

class CalendarHeaderView: UIView {

    lazy var monthYearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = Attributes.Colors.truewhite
        label.text = "Month and year"
        label.accessibilityTraits = .header
        label.isAccessibilityElement = true
        return label
    }()

    lazy var weekDaysStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()

    lazy var separatorView: UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = UIColor.label.withAlphaComponent(0.2)
      return view
    }()

    private lazy var dateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.calendar = Calendar(identifier: .gregorian)
      dateFormatter.locale = Locale.autoupdatingCurrent
      dateFormatter.setLocalizedDateFormatFromTemplate("MMMM y")
      return dateFormatter
    }()

    var baseDate = Date() {
      didSet {
          monthYearLabel.text = dateFormatter.string(from: baseDate)
      }
    }

    init() {
        super.init(frame: CGRect.zero)

        setUpView()
        addSubview(monthYearLabel)
        addSubview(weekDaysStackView)
        addSubview(separatorView)
        setUpStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
      super.layoutSubviews()

      NSLayoutConstraint.activate([
        monthYearLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
        monthYearLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
        monthYearLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),

        weekDaysStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
        weekDaysStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        weekDaysStackView.bottomAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: -5),

        separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
        separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
        separatorView.heightAnchor.constraint(equalToConstant: 1)
      ])
    }

    private func setUpView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Attributes.Colors.blueGrey

        layer.maskedCorners = [
        .layerMinXMinYCorner,
        .layerMaxXMinYCorner
        ]

        layer.cornerCurve = .continuous
        layer.cornerRadius = 15
    }

    private func setUpStackView() {
        for dayNumber in 1...7 {
            let dayLabel = UILabel()
            dayLabel.font = .systemFont(ofSize: 12, weight: .bold)
            dayLabel.textColor = Attributes.Colors.truewhite
            dayLabel.textAlignment = .center
            dayLabel.text = getWeekDayFirstLetter(for: dayNumber)

            dayLabel.isAccessibilityElement = false
            weekDaysStackView.addArrangedSubview(dayLabel)
        }
    }

    private func getWeekDayFirstLetter(for dayNumber: Int) -> String {
      switch dayNumber {
      case 1:
        return "S"
      case 2:
        return "M"
      case 3:
        return "T"
      case 4:
        return "W"
      case 5:
        return "T"
      case 6:
        return "F"
      case 7:
        return "S"
      default:
        return ""
      }
    }
}
