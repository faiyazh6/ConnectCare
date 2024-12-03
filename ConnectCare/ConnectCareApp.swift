import SwiftUI

@main
struct ConnectCareApp: App {
    var body: some Scene {
        WindowGroup {
            RoleSelectionView()
                .environmentObject(AppViewModel())
        }
    }
}
