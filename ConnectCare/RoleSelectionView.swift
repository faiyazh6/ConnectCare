import SwiftUI

struct RoleSelectionView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var navigateHome = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()

                Text("Welcome to ConnectCare")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primaryColor)

                Text("Select Your Role")
                    .font(.title3)
                    .foregroundColor(.secondaryColor)

                RoleButton(role: "Primary Caregiver", color: .primaryColor) {
                    appViewModel.userRole = "Primary Caregiver"
                    navigateHome = true
                }

                RoleButton(role: "Family Member", color: .secondaryColor) {
                    appViewModel.userRole = "Family Member"
                    navigateHome = true
                }

                Spacer()

                NavigationLink("", destination: HomeView().environmentObject(appViewModel), isActive: $navigateHome)
            }
            .padding()
            .background(Color.backgroundColor.edgesIgnoringSafeArea(.all))
        }
    }
}

struct RoleButton: View {
    var role: String
    var color: Color
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(role)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(color.gradient)
                .foregroundColor(.white)
                .cornerRadius(15)
                .shadow(radius: 5)
        }
        .padding(.horizontal, 40)
    }
}
