import UIKit

extension UIFont {
    static func manrope(_ size: CGFloat, _ weight: FontWeight) -> UIFont {
        if let font = UIFont(name: weight.rawValue, size: size) {
            return font
        } else {
            return UIFont.systemFont(ofSize: size)
        }
    }
}
