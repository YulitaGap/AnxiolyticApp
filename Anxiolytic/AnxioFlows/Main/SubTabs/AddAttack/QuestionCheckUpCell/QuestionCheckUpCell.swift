import UIKit

class QuestionCheckUpCell: UITableViewCell, NibLoadable, ReuseIdentifiable {

    @IBOutlet private weak var questionCheckBoxView: UIView!

    @IBOutlet private weak var questionCheckbox: CheckBox!

    @IBOutlet private weak var questionLabel: UILabel!

    var isChecked: Bool {
        return questionCheckbox.isChecked
    }

    func configure(question: String) {
        self.backgroundColor = .white
        questionLabel.text = question
        questionCheckBoxView.layer.cornerRadius = 10
        questionCheckBoxView.backgroundColor = .white
    }

    @IBAction private func didAnswered(_ sender: Any) {
        questionCheckbox.buttonClicked(sender: sender as! UIButton)
    }

    func rowTapped() {
        questionCheckbox.enableCheckBox()
    }
}
