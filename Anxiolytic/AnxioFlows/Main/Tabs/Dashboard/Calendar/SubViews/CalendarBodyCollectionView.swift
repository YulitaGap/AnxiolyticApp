import UIKit

class CalendarBodyCollectionView: UICollectionView {

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        super.init(frame: .zero, collectionViewLayout: layout)

        self.isScrollEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false

        self.layoutIfNeeded()
        self.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
