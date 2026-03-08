import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

/// Semantic color tokens for the Life Tracker app series.
public extension Color {
    #if canImport(UIKit)
    /// Screen / sheet background
    static var ltSurface: Color { Color(uiColor: .systemBackground) }
    /// Primary text and icons on surface
    static var ltOnSurface: Color { Color(uiColor: .label) }
    /// Secondary text and icons
    static var ltOnSurfaceSecondary: Color { Color(uiColor: .secondaryLabel) }
    /// Separator lines
    static var ltSeparator: Color { Color(uiColor: .separator) }
    #else
    static var ltSurface: Color { Color(.windowBackground) }
    static var ltOnSurface: Color { Color(.labelColor) }
    static var ltOnSurfaceSecondary: Color { Color(.secondaryLabelColor) }
    static var ltSeparator: Color { Color(.separatorColor) }
    #endif

    /// Hex color initializer
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
