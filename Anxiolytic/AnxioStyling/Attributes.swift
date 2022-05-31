import UIKit

/// Attribute Sets define a visual vocabulary. They need to be sorted
/// by the type of fundamental visual attributes to keep an overview
/// over the amount of elements used in each category, to ensure
/// visual consistency.
/// Typical elements are:
/// - Color definitions
/// - Font styles
/// - Spacings, i.e. margins, paddings
/// - Line widths
///
/// The naming MUST describe their relative meaning within their category,
/// NOT their data content. I.e. PrimaryAccentColor, not RedColor.
/// This makes it easier to change colors later without introducing
/// inconsistencies further down their use.
public struct Attributes {
    /// Struct defining all available colors.
    public struct Colors {
        /// A fairly visible color that indicates a missing style description.
        public static let fallbackColor: UIColor = .green
        public static let truewhite = UIColor.white
        public static let blueGrey = UIColor(161, 199, 221)
        public static let accentBlueGrey = UIColor(143, 168, 191)
    }

    /// Struct defining all available fonts.
    public struct Fonts {
        public static let vmCircularYell50 = UIFont(name: "VMCircularYell-Black", size: 50)
        public static let vmCircularYell24 = UIFont(name: "VMCircularYell-Black", size: 24)
        public static let vmCircularYell16 = UIFont(name: "VMCircularYell-Black", size: 16)
        public static let vmCircularChat24 = UIFont(name: "VMCircularChat-Book", size: 24)
        public static let vmCircularChat12 = UIFont(name: "VMCircularChat-Book", size: 12)
        public static let latoRegular24 = UIFont(name: "Lato-Regular", size: 24)
        public static let latoBold24 = UIFont(name: "Lato-Bold", size: 24)
    }
}

fileprivate extension UIColor {
    convenience init(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat = 1) {
        self.init(
            red: CGFloat(red) / 255,
            green: CGFloat(green) / 255,
            blue: CGFloat(blue) / 255,
            alpha: alpha
        )
    }
}
