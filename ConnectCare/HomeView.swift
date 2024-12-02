import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Background: White
                Color.white
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    // Title
                    Text("Select one of the following options:")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(Color.blue)
                        .padding(.bottom, 20)

                    // Buttons
                    NavigationLink(destination: TaskManagerView()) {
                        TealBlueButton(title: "📝 View Tasks", color: Color.blue)
                    }

                    NavigationLink(destination: ReminderView()) {
                        TealBlueButton(title: "⏰ Set Reminders", color: Color.teal)
                    }

                    NavigationLink(destination: CareNotesView()) {
                        TealBlueButton(title: "🗒️ View Notes", color: Color.blue.opacity(0.7))
                    }
                }
                .padding()
            }
        }
    }
}
