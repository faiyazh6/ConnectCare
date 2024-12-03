import SwiftUI

struct HomeView: View {
    @AppStorage("userRole") var userRole: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient Background
                LinearGradient(
                    colors: [Color.primaryColor, Color.accentColor],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 10) {
                    // Top Row: Hi Text and Profile Button
                    HStack {
                        Text("Hi, \(userRole)")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.leading)

                        Spacer()

                        // Profile Button (Small and Top Right)
                        NavigationLink(destination: ProfileView()) {
                            Image(systemName: "person.crop.circle")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .background(Circle().fill(Color.primaryColor.opacity(0.3)))
                                .shadow(radius: 2)
                        }
                        .padding(.trailing)
                    }

                    Spacer()

                    // 2x2 Button Grid
                    VStack(spacing: 15) {
                        HStack(spacing: 15) {
                            NavigationLink(destination: TaskManagerView()) {
                                FeatureCardView(
                                    icon: "list.bullet",
                                    title: "Tasks",
                                    gradientColors: [Color.primaryColor, Color.secondaryColor]
                                )
                            }

                            NavigationLink(destination: ReminderView()) {
                                FeatureCardView(
                                    icon: "clock.fill",
                                    title: "Reminders",
                                    gradientColors: [Color.secondaryColor, Color.accentColor]
                                )
                            }
                        }

                        HStack(spacing: 15) {
                            NavigationLink(destination: CareNotesView()) {
                                FeatureCardView(
                                    icon: "note.text",
                                    title: "Notes",
                                    gradientColors: [Color.accentColor, Color.dangerColor]
                                )
                            }

                            NavigationLink(destination: CalendarView()) {
                                FeatureCardView(
                                    icon: "calendar",
                                    title: "Calendar",
                                    gradientColors: [Color.secondaryColor, Color.primaryColor]
                                )
                            }
                        }
                    }
                    .frame(maxHeight: UIScreen.main.bounds.height * 0.5) // Take half the screen

                    Spacer()

                    // Image at the Bottom
                    Image("home_background")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: UIScreen.main.bounds.height * 0.3)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 1.2))
                        .padding(.horizontal)
                }
                .padding(.horizontal)
            }
        }
    }
}

struct FeatureCardView: View {
    let icon: String
    let title: String
    let gradientColors: [Color]

    var body: some View {
        VStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.title)
                .frame(width: 40, height: 40)
                .background(Circle().fill(Color.white.opacity(0.2)))
                .shadow(radius: 5)

            Text(title)
                .foregroundColor(.white)
                .font(.caption)
        }
        .frame(width: 120, height: 120) // Small Button Size
        .background(
            LinearGradient(
                colors: gradientColors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(15)
        .shadow(color: gradientColors.last?.opacity(0.5) ?? .clear, radius: 8, x: 0, y: 5)
    }
}
