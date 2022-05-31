import UIKit

extension UIFont {
// MARK: - Custom fonts

    class var vmCircularYell50: UIFont {
      return Attributes.Fonts.vmCircularYell50 ?? .systemFont(ofSize: 50)
    }

    class var vmCircularYell24: UIFont {
        return Attributes.Fonts.vmCircularYell24 ?? .systemFont(ofSize: 24)
    }

    class var vmCircularYell16: UIFont {
        return Attributes.Fonts.vmCircularYell16 ?? .systemFont(ofSize: 16)
    }

    class var vmCircularChat24: UIFont {
        return Attributes.Fonts.vmCircularChat24 ?? .systemFont(ofSize: 24)
    }

    class var vmCircularChat12: UIFont {
        return Attributes.Fonts.vmCircularChat12 ?? .systemFont(ofSize: 12)
    }

    class var latoRegular24: UIFont {
        return Attributes.Fonts.latoRegular24 ?? .systemFont(ofSize: 24)
    }

    class var latoBold24: UIFont {
        return Attributes.Fonts.latoBold24 ?? .systemFont(ofSize: 24)
    }
}
