import UIKit

class CheckBox: UIButton {

    let checkedImage = UIImage(named: "iconConfirmComplete.png")
    let uncheckedImage = UIImage(named: "iconCheckDisabled.png")

    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }

    override func awakeFromNib() {
        self.isChecked = false
    }

    func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }

    func disableCheckBox() {
        isChecked = false
    }

    func enableCheckBox() {
        isChecked = true
    }
}
