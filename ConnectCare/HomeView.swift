import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appViewModel: AppViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()

                Text("Welcome, \(appViewModel.userRole)")
                    .font(.largeTitle)
                    .foregroundColor(.primaryColor)

                // Navigation Options
                NavigationLink(destination: TaskManagerView()) {
                    FeatureButton(icon: "list.bullet", title: "Manage Tasks", color: .primaryColor)
                }

                NavigationLink(destination: ReminderView()) {
                    FeatureButton(icon: "clock.fill", title: "Set Reminders", color: .accentColor)
                }

                NavigationLink(destination: CareNotesView()) {
                    FeatureButton(icon: "note.text", title: "View Notes", color: .secondaryColor)
                }

                // Add the CalendarView Navigation Link
                NavigationLink(destination: CalendarView()) {
                    FeatureButton(icon: "calendar", title: "View Calendar", color: .primaryColor)
                }

                Spacer()
            }
            .padding()
            .background(Color.backgroundColor.edgesIgnoringSafeArea(.all))
        }
    }
}

struct FeatureButton: View {
    var icon: String
    var title: String
    var color: Color

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.title2)

            Text(title)
                .foregroundColor(.white)
                .font(.headline)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(color.gradient)
        .cornerRadius(12)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}
