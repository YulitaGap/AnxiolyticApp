import UIKit

protocol CalendarViewOutput: AnyObject { }

class CalendarView: UIView {
    weak var delegate: CalendarViewOutput?

    private lazy var headerView = CalendarHeaderView()
    private lazy var footerView = CalendarFooterView()
    private lazy var collectionView = CalendarBodyCollectionView()

    private var days = [Day]()
    private var numberOfWeeksInBaseDate = 5

    init() {
        super.init(frame: .init())

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Attributes.Colors.blueGrey

        setUpView()

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(
          CalendarDateCollectionViewCell.self,
          forCellWithReuseIdentifier: CalendarDateCollectionViewCell.reuseIdentifier
        )

        self.collectionView.setNeedsLayout()
    }

    func reloadData(forDate: Date) {
        self.collectionView.reloadData()
        headerView.baseDate = forDate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpView() {
        setUpHeader()
        setUpCollection()
        setUpFooter()

        layer.maskedCorners = [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner
        ]

        layer.cornerCurve = .continuous
        layer.cornerRadius = 15
    }

    private func setUpHeader() {
        self.addSubview(headerView)

        let constraints = [
            headerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 85)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func setUpFooter() {
        self.addSubview(footerView)
        let constraints = [
            footerView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            footerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 60)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func setUpCollection() {
        self.addSubview(collectionView)

        let constraints = [
          collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
          collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
          collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
          collectionView.topAnchor.constraint(equalTo: self.topAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func update(with viewModel: CalendarViewModel) {
        days = viewModel.days
        self.collectionView.reloadData()
        headerView.baseDate = viewModel.baseDate
        self.collectionView.setNeedsLayout()
    }
}

// MARK: - UICollectionViewDataSource
extension CalendarView: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
      days.count
  }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
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

    cell.day = day
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CalendarView: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
//      let day = days[indexPath.row]
//    selectedDateChanged(day.date)
//    dismiss(animated: true, completion: nil)
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
