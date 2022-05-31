import UIKit

/// A UIView extension to load views from nibs.
extension UIView {

    /// Unarchives the contents of a nib file.
    ///
    /// - Returns: The top-level objects in the nib file.
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(
            String(describing: T.self),
            owner: nil,
            options: nil
        // swiftlint:disable:next force_cast force_unwrapping
        )!.first as! T
    }
}
