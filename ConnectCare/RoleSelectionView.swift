import SwiftUI

struct RoleSelectionView: View {
    @AppStorage("userRole") var userRole: String = ""
    @State private var navigateHome = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Background Gradient
                LinearGradient(
                    colors: [Color.primaryColor, Color.secondaryColor],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 30) {
                    Spacer()

                    // Welcome Message
                    VStack(spacing: 10) {
                        Text("Welcome to ConnectCare")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(radius: 5)

                        Text("Select Your Role")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.8))
                    }

                    // Role Selection Image
                    Image("role_selection")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 600, maxHeight: 600)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        .padding(.bottom, 10)

                    // Buttons
                    VStack(spacing: 20) {
                        Button(action: {
                            userRole = "Primary Caregiver"
                            navigateHome = true
                        }) {
                            RoleButtonView(
                                title: "Primary Caregiver",
                                gradientColors: [Color.primaryColor, Color.secondaryColor]
                            )
                        }

                        Button(action: {
                            userRole = "Family Member"
                            navigateHome = true
                        }) {
                            RoleButtonView(
                                title: "Family Member",
                                gradientColors: [Color.accentColor, Color.dangerColor]
                            )
                        }
                    }

                    Spacer()

                    NavigationLink(destination: HomeView(), isActive: $navigateHome) {
                        EmptyView()
                    }
                }
                .padding()
            }
        }
    }
}

struct RoleButtonView: View {
    let title: String
    let gradientColors: [Color]

    var body: some View {
        Text(title)
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    colors: gradientColors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .foregroundColor(.white)
            .cornerRadius(15)
            .shadow(color: gradientColors.last?.opacity(0.4) ?? .clear, radius: 5, x: 0, y: 5)
            .padding(.horizontal)
    }
}
