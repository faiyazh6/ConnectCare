import SwiftUI

struct TaskManagerView: View {
    @AppStorage("tasks") private var tasksData: String = "[]" // Persistent storage for tasks
    @AppStorage("userRole") var userRole: String = "" // Current user's role
    @State private var tasks: [Task] = []
    @State private var newTaskTitle = ""
    @State private var dueDate = Date()
    @State private var isAddingTask = false
    @State private var isEditing = false // State to toggle edit mode
    @State private var editMode: EditMode = .inactive // State for EditMode

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
        let newTask = Task(title: newTaskTitle, isCompleted: false, dueDate: dueDate, role: userRole)
        tasks.append(newTask)
        saveTasks()
        newTaskTitle = ""
        isAddingTask = false
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundColor
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("Task Manager")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryColor)
                        .padding()

                    // Task List with drag-and-drop support
                    List {
                        ForEach(tasks.indices, id: \.self) { index in
                            TaskCard(task: $tasks[index], userRole: userRole) // Pass userRole here
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                if tasks[index].role == userRole { // Allow deletion only for the creator
                                    tasks.remove(at: index)
                                }
                            }
                            saveTasks()
                        }
                        .onMove { source, destination in
                            if source.allSatisfy({ tasks[$0].role == userRole }) { // Allow reorder only for tasks created by the user
                                tasks.move(fromOffsets: source, toOffset: destination)
                                saveTasks()
                            }
                        }
                        .moveDisabled(userRole == "Family Member") // Disable move for family members
                    }
                    .listStyle(InsetGroupedListStyle())
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(isEditing ? "Done" : "Edit") {
                                withAnimation {
                                    isEditing.toggle()
                                    editMode = isEditing ? .active : .inactive // Sync EditMode state
                                }
                            }
                        }
                    }
                    .environment(\.editMode, $editMode) // Bind EditMode environment variable

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
            .navigationBarTitle("Task Manager", displayMode: .inline)
        }
    }
}

struct TaskCard: View {
    @Binding var task: Task
    var userRole: String // Accept userRole as a parameter

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
                Text("Created by: \(task.role)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Spacer()
            if task.role == userRole {
                Button(action: {
                    task.isCompleted.toggle()
                }) {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(task.isCompleted ? .green : .gray)
                }
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
