//
//  Color+Extension.swift
//  SwiftData+PreviewModifiers
//
//  Created by ipeerless on 30/12/2024.
//

import SwiftUI

extension Color {
    /// Initialize a Color from a hex string.
    init?(hex: String) {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased().trimmingPrefix("#")
        guard let rgbValue = UInt64(hexString, radix: 16) else { return nil }
        let red, green, blue, alpha: Double

        switch hexString.count {
        case 6: // #RRGGBB
            red = Double((rgbValue >> 16) & 0xFF) / 255
            green = Double((rgbValue >> 8) & 0xFF) / 255
            blue = Double(rgbValue & 0xFF) / 255
            alpha = 1.0
        case 8: // #AARRGGBB
            red = Double((rgbValue >> 16) & 0xFF) / 255
            green = Double((rgbValue >> 8) & 0xFF) / 255
            blue = Double(rgbValue & 0xFF) / 255
            alpha = Double((rgbValue >> 24) & 0xFF) / 255
        default:
            return nil
        }

        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }

    /// Convert the Color to a hex string.
    func toHexString(includeAlpha: Bool = false) -> String? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 1.0
        guard UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return nil }
        
        return includeAlpha
            ? String(format: "#%02X%02X%02X%02X", Int(alpha * 255), Int(red * 255), Int(green * 255), Int(blue * 255))
            : String(format: "#%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255))
    }

    /// Check if the color is light based on its luminance.
    func isLight() -> Bool {
        let uiColor = UIColor(self)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        return (0.2126 * red + 0.7152 * green + 0.0722 * blue) > 0.5
    }

    /// Suggest an adapted text color for contrast.
    func adaptedTextColor() -> Color {
        isLight() ? .black : .white
    }
}
