import UIKit

extension UITableView {
    /// Helper function for retreiving an already allocated table view cells.
    /// - Parameter indexPath: indexPath of the cell
    /// - Parameter type: type of the cell (ex.: 'SomeTableViewCell.self')
    func dequeueReusableCell<T: UITableViewCell>(
        for indexPath: IndexPath,
        type: T.Type = T.self
    ) -> T where T: ReuseIdentifiable {

        let reusableCell = self.dequeueReusableCell(
            withIdentifier: type.reuseIdentifier,
            for: indexPath
        )
        guard let tableViewCell = reusableCell as? T else {
            fatalError("Failed to dequeue cell with id \(type.reuseIdentifier) matching type \(type.self)")
        }
        return tableViewCell
    }
}
