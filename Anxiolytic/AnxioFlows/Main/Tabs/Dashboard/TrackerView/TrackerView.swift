import UIKit
protocol TrackerViewDelegate: AnyObject {
    func proceedToAttackTracking()
}

class TrackerView: UIView {
    @IBOutlet private weak var contentView: UIView!

    @IBOutlet private weak var descriptionView: UIView!

    @IBOutlet private weak var addButton: UIButton!

    // MARK: - Delegate

    weak var delegate: TrackerViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configure()
    }

    func configure() {
        Bundle.main.loadNibNamed("TrackerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        descriptionView.layer.cornerRadius = 10
        descriptionView.backgroundColor = Attributes.Colors.blueGrey
        addButton.layer.cornerRadius = descriptionView.frame.size.height / 2
    }

    @IBAction func didTapAddButton(_ sender: Any) {
        delegate?.proceedToAttackTracking()
    }

}
