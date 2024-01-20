import UIKit

public extension UIColor {

    static func dynamicColor(dark: UIColor, light: UIColor) -> UIColor {
        let dynamicColor = UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .light:
                return light
            default:
                return dark
            }
        }

        return dynamicColor
    }
}
