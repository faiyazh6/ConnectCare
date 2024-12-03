import SwiftUI

struct CareNotesView: View {
    @AppStorage("notes") private var notesData: String = "[]" // Persistent storage for notes
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
                    notes.remove(atOffsets: indexSet)
                    saveNotes()
                }
            }
            .listStyle(InsetGroupedListStyle())

            HStack {
                TextField("New Note", text: $newNoteContent)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: addNote) {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.accentColor)
                }
            }
            .padding()
        }
        .onAppear(perform: loadNotes)
    }
}
