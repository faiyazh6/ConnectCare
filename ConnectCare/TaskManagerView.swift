import SwiftUI

struct TaskManagerView: View {
    @AppStorage("tasks") private var tasksData: String = "[]" // Store tasks as a JSON string
    @State private var tasks: [Task] = []
    @State private var newTask = ""
    @State private var showAlert = false
    @State private var taskToDeleteIndex: Int?

    init() {
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

    var body: some View {
        VStack {
            Text("Task Manager")
                .font(.largeTitle)
                .bold()

            List {
                ForEach(tasks.indices, id: \.self) { index in
                    HStack {
                        Text(tasks[index].title)
                        Spacer()
                        Button(action: {
                            taskToDeleteIndex = index
                            showAlert = true
                        }) {
                            Image(systemName: tasks[index].isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(tasks[index].isCompleted ? .green : .gray)
                        }
                    }
                }
                .onDelete { indexSet in
                    tasks.remove(atOffsets: indexSet)
                    saveTasks()
                }
            }

            HStack {
                TextField("Enter new task", text: $newTask)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {
                    if !newTask.isEmpty {
                        tasks.append(Task(title: newTask, isCompleted: false))
                        saveTasks()
                        newTask = ""
                    }
                }) {
                    Text("Add")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Complete Task"),
                message: Text("Are you sure you want to mark this task as completed? It will be removed."),
                primaryButton: .destructive(Text("Yes")) {
                    if let index = taskToDeleteIndex {
                        tasks.remove(at: index)
                        saveTasks()
                    }
                },
                secondaryButton: .cancel()
            )
        }
        .onAppear {
            if let data = tasksData.data(using: .utf8),
               let decodedTasks = try? JSONDecoder().decode([Task].self, from: data) {
                tasks = decodedTasks
            }
        }
    }
}

struct Task: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool
}
