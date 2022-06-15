import UIKit

protocol NibLoadable: AnyObject {
    static var nib: UINib { get }
}

extension NibLoadable {
    static var nib: UINib {
        UINib(
            nibName: String(describing: self),
            bundle: Bundle(for: self)
        )
    }
}
