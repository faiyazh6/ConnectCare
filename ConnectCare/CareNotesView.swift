import SwiftUI

struct CareNotesView: View {
    @AppStorage("notes") private var notesData: String = "[]" // Persistent storage for notes
    @AppStorage("userRole") private var userRole: String = "" // Current user's role
    @State private var notes: [Note] = []
    @State private var newNoteContent = ""

    init() {
        loadNotes()
    }

    private func loadNotes() {
        if let data = notesData.data(using: .utf8),
           let decodedNotes = try? JSONDecoder().decode([Note].self, from: data) {
            notes = decodedNotes
        }
    }

    private func saveNotes() {
        if let encodedData = try? JSONEncoder().encode(notes),
           let jsonString = String(data: encodedData, encoding: .utf8) {
            notesData = jsonString
        }
    }

    private func addNote() {
        let newNote = Note(content: newNoteContent, createdDate: Date())
        notes.append(newNote)
        saveNotes()
        newNoteContent = ""
    }

    var body: some View {
        VStack {
            Text("Care Notes")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primaryColor)
                .padding()

            if userRole == "Family Member" {
                Text("You can view care notes but are not allowed to add or delete them.")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            List {
                ForEach(notes.indices, id: \.self) { index in
                    VStack(alignment: .leading) {
                        Text(notes[index].content)
                            .font(.body)
                        Text("Created: \(notes[index].createdDate, formatter: dateFormatter)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .onDelete { indexSet in
                    // Prevent deletion if the user is a family member
                    if userRole != "Family Member" {
                        notes.remove(atOffsets: indexSet)
                        saveNotes()
                    }
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    if userRole != "Family Member" { // Disable swipe actions for family members
                        Button(role: .destructive) {
                            // Placeholder for swipe action (delete)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .disabled(userRole == "Family Member") // Fully disable the List interaction for family members

            if userRole != "Family Member" { // Only show input fields for non-family members
                HStack {
                    TextField("New Note", text: $newNoteContent)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    Button(action: addNote) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.accentColor)
                    }
                }
                .padding()
            }
        }
        .onAppear(perform: loadNotes)
    }
}
