import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appViewModel: AppViewModel

    var body: some View {
        VStack {
            Text("Profile")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primaryColor)
                .padding()

            Text("Role: \(appViewModel.userRole)")
                .font(.title2)
                .padding()

            Button("Change Role") {
                appViewModel.userRole = ""
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.dangerColor)
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(radius: 5)
            .padding(.horizontal)

            Spacer()
        }
        .padding()
    }
}
