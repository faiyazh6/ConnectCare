import SwiftUI

struct ReminderView: View {
    @AppStorage("reminders") private var remindersData: String = "[]" // Persistent storage for reminders
    @AppStorage("userRole") var userRole: String = "" // Current user's role
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
        let newReminder = Reminder(title: newReminderTitle, time: reminderTime, role: userRole)
        reminders.append(newReminder)
        saveReminders()
        newReminderTitle = ""
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
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            if reminders[index].role == userRole { // Allow swipe-to-delete only for reminders created by the user
                                Button(role: .destructive) {
                                    reminders.remove(at: index)
                                    saveReminders()
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
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
            Text("Created by: \(reminder.role)")
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 5)
    }
}
