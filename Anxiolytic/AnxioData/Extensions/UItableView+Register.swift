import UIKit

extension UITableView {
    /// Helper function for registering reusable table view cells designed in xib files.
    /// - Parameter type: type of the cell (ex.: 'SomeTableViewCell.self')
    func register<T: UITableViewCell>(_ type: T.Type)
        where T: ReuseIdentifiable & NibLoadable {
            self.register(
                type.nib,
                forCellReuseIdentifier: type.reuseIdentifier
            )
    }

    /// Helper function for registering reusable header views designed in xib files.
    /// - Parameter type: type of the view (ex.: 'SomeTableView.self')
    func registerHeader<T: UIView>(_ type: T.Type) where T: ReuseIdentifiable & NibLoadable {
        self.register(
            type.nib,
            forHeaderFooterViewReuseIdentifier: type.reuseIdentifier
        )
    }
}
