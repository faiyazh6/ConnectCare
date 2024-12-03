import SwiftUI

struct ReminderView: View {
    @AppStorage("reminders") private var remindersData: String = "[]" // Persistent storage for reminders
    @State private var reminders: [Reminder] = []
    @State private var newReminderTitle = ""
    @State private var reminderTime = Date()

    init() {
        loadReminders()
    }

    private func loadReminders() {
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

    private func addReminder() {
        let newReminder = Reminder(title: newReminderTitle, time: reminderTime)
        reminders.append(newReminder)
        scheduleNotification(for: newReminder)
        saveReminders()
        newReminderTitle = ""
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
                .fontWeight(.bold)
                .foregroundColor(.primaryColor)
                .padding()

            List {
                ForEach(reminders.indices, id: \.self) { index in
                    ReminderRow(reminder: reminders[index])
                }
                .onDelete { indexSet in
                    reminders.remove(atOffsets: indexSet)
                    saveReminders()
                }
            }
            .listStyle(InsetGroupedListStyle())

            HStack {
                TextField("New Reminder", text: $newReminderTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                DatePicker("", selection: $reminderTime, displayedComponents: .hourAndMinute)
                    .labelsHidden()

                Button(action: addReminder) {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.accentColor)
                }
            }
            .padding()
        }
        .onAppear(perform: loadReminders)
    }
}

struct ReminderRow: View {
    let reminder: Reminder

    var body: some View {
        VStack(alignment: .leading) {
            Text(reminder.title)
                .font(.headline)
            Text("Time: \(reminder.time, style: .time)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 5)
    }
}
