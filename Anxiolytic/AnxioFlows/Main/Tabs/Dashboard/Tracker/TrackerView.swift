import UIKit

class TrackerView: UIView {

    @IBOutlet private weak var contentStackview: UIStackView!
    @IBOutlet private weak var addButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configure()
    }

    func configure() {

    }

}
