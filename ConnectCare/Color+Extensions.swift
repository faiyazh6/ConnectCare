import SwiftUI

extension Color {
    static let primaryColor = Color(hex: "#1E88E5")
    static let secondaryColor = Color(hex: "#43A047")
    static let accentColor = Color(hex: "#FB8C00")
    static let backgroundColor = Color(hex: "#F5F5F5")
    static let dangerColor = Color(hex: "#E53935")

    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
