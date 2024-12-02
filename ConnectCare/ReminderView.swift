import SwiftUI
import UserNotifications

struct ReminderView: View {
    @AppStorage("reminders") private var remindersData: String = "[]" // Store reminders as a JSON string
    @State private var reminders: [Reminder] = []
    @State private var newReminder = ""
    @State private var newTime = Date()

    init() {
        if let data = remindersData.data(using: .utf8),
           let decodedReminders = try? JSONDecoder().decode([Reminder].self, from: data) {
            reminders = decodedReminders
        }
    }

    private func saveReminders() {
        if let encodedData = try? JSONEncoder().encode(reminders),
           let jsonString = String(data: encodedData, encoding: .utf8) {
            remindersData = jsonString
        }
    }

    private func scheduleNotification(for reminder: Reminder) {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = reminder.title
        content.sound = .default

        let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: reminder.time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(identifier: reminder.id.uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }

    var body: some View {
        VStack {
            Text("Reminders")
                .font(.largeTitle)
                .bold()

            List {
                ForEach(reminders.indices, id: \.self) { index in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(reminders[index].title)
                            Text(reminders[index].time, style: .time)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                }
                .onDelete { indexSet in
                    reminders.remove(atOffsets: indexSet)
                    saveReminders()
                }
            }

            HStack {
                TextField("Enter reminder", text: $newReminder)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                DatePicker("", selection: $newTime, displayedComponents: .hourAndMinute)
                    .labelsHidden()

                Button(action: {
                    if !newReminder.isEmpty {
                        let newReminderEntry = Reminder(title: newReminder, time: newTime)
                        reminders.append(newReminderEntry)
                        scheduleNotification(for: newReminderEntry)
                        saveReminders()
                        newReminder = ""
                    }
                }) {
                    Text("Add")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .onAppear {
            // Reload reminders when returning to the view
            if let data = remindersData.data(using: .utf8),
               let decodedReminders = try? JSONDecoder().decode([Reminder].self, from: data) {
                reminders = decodedReminders
            }
        }
    }
}

struct Reminder: Identifiable, Codable {
    var id = UUID()
    var title: String
    var time: Date
}
