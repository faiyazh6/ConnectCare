import SwiftUI

struct ProfileView: View {
    @State private var patientName: String = "Lincoln Nyarambi"
    @State private var patientAge: String = "65"
    @State private var patientBio: String = "Lincoln is a retired trader who enjoys gardening, farming, and spending time with his grandchildren. He focuses on managing his health through regular physical activity, a balanced diet, and consistent medical follow-ups."
    @State private var medicalConditions: [String] = ["Type 2 Diabetes", "Hypertension", "Osteoarthritis"]
    @State private var medications: [String] = ["Metformin (500mg twice daily)", "Lisinopril (10mg once daily)", "Acetaminophen (as needed for joint pain)"]
    @State private var allergies: [String] = ["Penicillin", "Latex"]
    @State private var primaryCarePhysician: String = "Dr. Emily Carter, MD\nContact: (555) 123-4567"
    @State private var emergencyContact: String = "John Johnson (Son)\nPhone: (555) 987-6543"

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Profile Image
                Image("patient_picture")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.primaryColor, lineWidth: 4))
                    .shadow(radius: 10)

                // Patient Name and Age
                Text(patientName)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.primaryColor)

                Text("Age: \(patientAge)")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(.secondaryColor)

                // Bio
                Text("Bio:")
                    .font(.headline)
                    .foregroundColor(.primaryColor)
                Text(patientBio)
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // Medical Information
                Group {
                    SectionHeader(title: "Medical Conditions")
                    ForEach(medicalConditions, id: \.self) { condition in
                        Text("• \(condition)")
                            .font(.body)
                            .foregroundColor(.gray)
                            .padding(.vertical, 2)
                    }

                    SectionHeader(title: "Medications")
                    ForEach(medications, id: \.self) { medication in
                        Text("• \(medication)")
                            .font(.body)
                            .foregroundColor(.gray)
                            .padding(.vertical, 2)
                    }

                    SectionHeader(title: "Allergies")
                    ForEach(allergies, id: \.self) { allergy in
                        Text("• \(allergy)")
                            .font(.body)
                            .foregroundColor(.gray)
                            .padding(.vertical, 2)
                    }

                    SectionHeader(title: "Primary Care Physician")
                    Text(primaryCarePhysician)
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 2)

                    SectionHeader(title: "Emergency Contact")
                    Text(emergencyContact)
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 2)
                }
            }
            .padding()
            .background(Color.backgroundColor.ignoresSafeArea())
            .navigationTitle("Patient Profile")
        }
    }
}

struct SectionHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.primaryColor)
            .padding(.top, 10)
    }
}
