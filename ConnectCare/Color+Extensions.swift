import SwiftUI

extension Color {
    static let primaryColor = Color("PrimaryColor") // Matches the color set name in Assets
    static let secondaryColor = Color("SecondaryColor")
    static let accentColor = Color("AccentColor")
    static let backgroundColor = Color("BackgroundColor")
    static let dangerColor = Color("DangerColor")

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
