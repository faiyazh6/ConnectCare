import SwiftUI

struct CalendarView: View {
    @AppStorage("tasks") private var tasksData: String = "[]" // Persistent storage for tasks
    @State private var tasks: [Task] = []
    @State private var selectedDate = Date()
    @State private var calendarDates: [Date?] = [] // Optional to support blank slots

    init() {
        loadTasks()
        setupCalendarDates(for: Date())
    }

    private func loadTasks() {
        if let data = tasksData.data(using: .utf8),
           let decodedTasks = try? JSONDecoder().decode([Task].self, from: data) {
            tasks = decodedTasks
        }
    }

    private func setupCalendarDates(for month: Date) {
        let calendar = Calendar.current
        guard let monthRange = calendar.range(of: .day, in: .month, for: month) else { return }

        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month))!
        let weekdayOffset = calendar.component(.weekday, from: firstDayOfMonth) - calendar.firstWeekday

        // Add blank slots for leading days and fill with actual dates
        calendarDates = Array(repeating: nil, count: weekdayOffset) // Leading blanks
        calendarDates += monthRange.compactMap { day -> Date? in
            calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth)
        }
    }

    private func tasksForDate(_ date: Date) -> [Task] {
        tasks.filter {
            Calendar.current.isDate($0.dueDate, inSameDayAs: date)
        }
    }

    var body: some View {
        VStack {
            Text("Calendar")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primaryColor)
                .padding()

            CalendarHeaderView(selectedDate: $selectedDate, onMonthChange: setupCalendarDates)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(calendarDates.indices, id: \.self) { index in
                    if let date = calendarDates[index] { // Safely unwrap date
                        CalendarDayView(date: date, isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate)) {
                            selectedDate = date
                        }
                    } else {
                        Spacer() // Blank slots
                    }
                }
            }
            .padding()

            Divider()
                .padding(.vertical)

            TaskListView(tasks: tasksForDate(selectedDate))
        }
        .onAppear(perform: loadTasks)
        .background(Color.backgroundColor.ignoresSafeArea())
    }
}

struct CalendarHeaderView: View {
    @Binding var selectedDate: Date
    var onMonthChange: (Date) -> Void

    static let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()

    var body: some View {
        let calendar = Calendar.current

        HStack {
            Button(action: {
                selectedDate = calendar.date(byAdding: .month, value: -1, to: selectedDate) ?? selectedDate
                onMonthChange(selectedDate)
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.primaryColor)
            }

            Spacer()

            Text(Self.monthFormatter.string(from: selectedDate))
                .font(.title2)
                .foregroundColor(.primaryColor)

            Spacer()

            Button(action: {
                selectedDate = calendar.date(byAdding: .month, value: 1, to: selectedDate) ?? selectedDate
                onMonthChange(selectedDate)
            }) {
                Image(systemName: "chevron.right")
                    .foregroundColor(.primaryColor)
            }
        }
        .padding(.horizontal)
    }
}

struct CalendarDayView: View {
    let date: Date
    let isSelected: Bool
    var action: () -> Void

    static let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()

    var body: some View {
        Button(action: action) {
            Text(Self.dayFormatter.string(from: date))
                .font(.headline)
                .foregroundColor(isSelected ? .white : .black)
                .frame(width: 40, height: 40)
                .background(isSelected ? Color.primaryColor : Color.clear)
                .cornerRadius(20)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct TaskListView: View {
    let tasks: [Task]

    var body: some View {
        VStack(alignment: .leading) {
            if tasks.isEmpty {
                Text("No tasks for this date")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                ForEach(tasks) { task in
                    HStack {
                        Text(task.title)
                            .font(.headline)
                        Spacer()
                        Text(task.dueDate, style: .time)
                            .font(.subheadline)
                            .foregroundColor(.secondaryColor)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                }
            }
        }
    }
}

