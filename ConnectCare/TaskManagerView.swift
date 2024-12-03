import SwiftUI

struct TaskManagerView: View {
    @AppStorage("tasks") private var tasksData: String = "[]" // Persistent storage for tasks
    @State private var tasks: [Task] = []
    @State private var newTaskTitle = ""
    @State private var dueDate = Date()
    @State private var isAddingTask = false

    init() {
        loadTasks()
    }

    private func loadTasks() {
        if let data = tasksData.data(using: .utf8),
           let decodedTasks = try? JSONDecoder().decode([Task].self, from: data) {
            tasks = decodedTasks
        }
    }

    private func saveTasks() {
        if let encodedData = try? JSONEncoder().encode(tasks),
           let jsonString = String(data: encodedData, encoding: .utf8) {
            tasksData = jsonString
        }
    }

    private func addTask() {
        let newTask = Task(title: newTaskTitle, isCompleted: false, dueDate: dueDate)
        tasks.append(newTask)
        saveTasks()
        newTaskTitle = ""
        isAddingTask = false
    }

    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Task Manager")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primaryColor)
                    .padding()

                ScrollView {
                    LazyVStack(spacing: 15) {
                        ForEach(tasks.indices, id: \.self) { index in
                            TaskCard(task: $tasks[index])
                        }
                        .onDelete { indexSet in
                            tasks.remove(atOffsets: indexSet)
                            saveTasks()
                        }
                    }
                }

                Button(action: {
                    isAddingTask = true
                }) {
                    Text("Add New Task")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor.gradient)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                }
            }

            if isAddingTask {
                TaskInputModal(
                    isAddingTask: $isAddingTask,
                    newTaskTitle: $newTaskTitle,
                    dueDate: $dueDate,
                    addTask: addTask
                )
            }
        }
        .onAppear(perform: loadTasks)
    }
}

struct TaskCard: View {
    @Binding var task: Task

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                    .foregroundColor(task.isCompleted ? .gray : .black)
                    .strikethrough(task.isCompleted)
                Text("Due: \(task.dueDate, formatter: dateFormatter)")
                    .font(.subheadline)
                    .foregroundColor(.secondaryColor)
            }
            Spacer()
            Button(action: {
                task.isCompleted.toggle()
            }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

struct TaskInputModal: View {
    @Binding var isAddingTask: Bool
    @Binding var newTaskTitle: String
    @Binding var dueDate: Date
    var addTask: () -> Void

    var body: some View {
        VStack(spacing: 15) {
            Text("Add New Task")
                .font(.headline)
                .padding()

            TextField("Task Title", text: $newTaskTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                .padding()

            HStack {
                Button("Cancel") {
                    isAddingTask = false
                }
                .foregroundColor(.red)

                Spacer()

                Button("Save") {
                    addTask()
                }
                .foregroundColor(.primaryColor)
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
        .padding(.horizontal)
    }
}
