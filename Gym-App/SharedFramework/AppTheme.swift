import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let hexWithoutSymbol = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        var rgb: UInt64 = 0
        Scanner(string: hexWithoutSymbol).scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xff) / 255.0
        let green = Double((rgb >> 8) & 0xff) / 255.0
        let blue = Double(rgb & 0xff) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}
import SwiftUI

public protocol ColorPalette {
    var primary: Color { get } // Renamed from primaryVariant
    var secondary: Color { get }
    var background: Color { get }
    var backgroundShadow: Color { get }
    var surface: Color { get }
    var error: Color { get }
    var onBackground: Color { get } // For text on background
    var primaryText: Color { get } // Primary text color
    var secondaryText: Color { get } // Secondary text color
    // Add more color properties as needed
}

public struct DarkColorPalette: ColorPalette {
    public let primary = Color(hex: "#BB86FC") // Lighter Purple for better visibility
    public let secondary = Color(hex: "#03DAC6") // Teal
    public let background = Color(hex: "#121212") // Dark Background
    public let backgroundShadow = Color(hex: "#FFFFFF")
    public let surface = Color(hex: "#1E1E1E") // Surface Color
    public let error = Color(hex: "#B00020") // Red for errors
    public let onBackground = Color(hex: "#FFFFFF") // White text on dark background
    public let primaryText = Color(hex: "#FFFFFF") // White primary text
    public let secondaryText = Color(hex: "#A4A6A8") // Light gray secondary text
    // Add more color properties for the dark theme
}

public struct LightColorPalette: ColorPalette {
    public let primary = Color(hex: "#6200EE") // Purple
    public let secondary = Color(hex: "#03DAC6") // Teal
    public let background = Color(hex: "#FFFFFF") // White
    public let backgroundShadow = Color(hex: "#000000") // Dark Background
    public let surface = Color(hex: "#F2F2F2") // Light Gray
    public let error = Color(hex: "#B00020") // Red for errors
    public let onBackground = Color(hex: "#000000") // Black text on light background
    public let primaryText = Color(hex: "#000000") // Black primary text
    public let secondaryText = Color(hex: "#6B6E70") // Dark gray secondary text
    // Add more color properties for the light theme
}

public enum AppTheme {
    public static let isDarkTheme = true // Set based on user preference
    
    public static var activeColorPalette: ColorPalette {
        return isDarkTheme ? DarkColorPalette() : LightColorPalette()
    }
}

