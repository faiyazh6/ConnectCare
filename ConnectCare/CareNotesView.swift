import SwiftUI

struct CareNotesView: View {
    @AppStorage("notes") private var notesData: String = "[]" // Persistent storage
    @State private var notes: [String] = []
    @State private var newNote = ""

    init() {
        if let data = notesData.data(using: .utf8),
           let decodedNotes = try? JSONDecoder().decode([String].self, from: data) {
            notes = decodedNotes
        }
    }

    private func saveNotes() {
        if let encodedData = try? JSONEncoder().encode(notes),
           let jsonString = String(data: encodedData, encoding: .utf8) {
            notesData = jsonString
        }
    }

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack {
                Text("Care Notes")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .padding()

                List {
                    ForEach(notes, id: \.self) { note in
                        Text(note)
                            .padding(.vertical, 8)
                    }
                    .onDelete { indexSet in
                        notes.remove(atOffsets: indexSet)
                        saveNotes()
                    }
                }
                .listStyle(InsetGroupedListStyle())

                HStack {
                    TextField("Write a note", text: $newNote)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button(action: {
                        if !newNote.isEmpty {
                            notes.append(newNote)
                            saveNotes()
                            newNote = ""
                        }
                    }) {
                        ProfessionalButton(title: "Save", color: .purple)
                            .frame(width: 120)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
