import SwiftUI

struct RoleSelectionView: View {
    @AppStorage("userRole") var userRole: String = ""
    @State private var navigateHome = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Background: White
                Color.white
                    .ignoresSafeArea()

                VStack(spacing: 30) {
                    // Title
                    Text("Welcome to ConnectCare")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(Color.blue)
                        .padding(.bottom, 20)

                    // Subtitle
                    Text("Select Your Role")
                        .font(.system(size: 22, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.teal)

                    // Primary Caregiver Button
                    Button(action: {
                        userRole = "Primary Caregiver"
                        navigateHome = true
                    }) {
                        TealBlueButton(title: "Primary Caregiver", color: Color.blue)
                    }

                    // Family Member Button
                    Button(action: {
                        userRole = "Family Member"
                        navigateHome = true
                    }) {
                        TealBlueButton(title: "Family Member", color: Color.teal)
                    }

                    NavigationLink(destination: HomeView(), isActive: $navigateHome) {
                        EmptyView()
                    }
                }
                .padding()
            }
        }
    }
}

// Button Component with Gradient
struct TealBlueButton: View {
    var title: String
    var color: Color

    var body: some View {
        Text(title)
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    colors: [color.opacity(0.8), color],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .foregroundColor(.white)
            .cornerRadius(15)
            .shadow(color: color.opacity(0.4), radius: 5, x: 0, y: 5)
            .padding(.horizontal, 40)
    }
}
