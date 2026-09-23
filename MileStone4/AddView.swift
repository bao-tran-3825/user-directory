//
//  AddView.swift
//  MileStone4
//
//  Created by Gojo Satoru on 29/8/25.
//

import SwiftUI
import SwiftData

struct AddView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var age = 18
    @State private var company = ""
    @State private var email = ""
    @State private var address = ""
    @State private var about = ""
    @State private var isActive = true
    @State private var tagsInput = ""

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Spacer()
                        ZStack {
                            Circle()
                                .fill(Color.blue.gradient)
                                .frame(width: 72, height: 72)
                            Text(name.prefix(1).uppercased())
                                .font(.largeTitle.bold())
                                .foregroundStyle(.white)
                        }
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                }

                Section("Personal") {
                    HStack {
                        Label("Name", systemImage: "person.fill")
                            .foregroundStyle(.secondary)
                            .frame(width: 110, alignment: .leading)
                        TextField("Full name", text: $name)
                    }
                    Stepper("Age: \(age)", value: $age, in: 1...120)
                    Toggle(isOn: $isActive) {
                        Label("Active", systemImage: "checkmark.circle")
                            .foregroundStyle(isActive ? .green : .secondary)
                    }
                    .tint(.green)
                }

                Section("Contact") {
                    HStack {
                        Label("Email", systemImage: "envelope.fill")
                            .foregroundStyle(.secondary)
                            .frame(width: 110, alignment: .leading)
                        TextField("email@example.com", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                    }
                    HStack {
                        Label("Work", systemImage: "building.2.fill")
                            .foregroundStyle(.secondary)
                            .frame(width: 110, alignment: .leading)
                        TextField("Company name", text: $company)
                    }
                    HStack {
                        Label("Address", systemImage: "location.fill")
                            .foregroundStyle(.secondary)
                            .frame(width: 110, alignment: .leading)
                        TextField("Street address", text: $address)
                    }
                }

                Section("About") {
                    TextField("Write something about this person...", text: $about, axis: .vertical)
                        .lineLimit(4...)
                }

                Section {
                    HStack {
                        Label("Tags", systemImage: "tag.fill")
                            .foregroundStyle(.secondary)
                            .frame(width: 110, alignment: .leading)
                        TextField("swift, ios, design", text: $tagsInput)
                            .textInputAutocapitalization(.never)
                    }
                } footer: {
                    Text("Separate multiple tags with commas")
                }

            }
            .navigationTitle("New User")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                        .fontWeight(.semibold)
                        .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }

    private func save() {
        let tags = tagsInput
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }

        let user = User(
            id: UUID(),
            isActive: isActive,
            name: name.trimmingCharacters(in: .whitespaces),
            age: age,
            company: company.trimmingCharacters(in: .whitespaces),
            email: email.trimmingCharacters(in: .whitespaces),
            address: address.trimmingCharacters(in: .whitespaces),
            about: about.trimmingCharacters(in: .whitespaces),
            registered: .now,
            tags: tags,
            friends: []
        )

        modelContext.insert(user)
        dismiss()
    }
}

#Preview {
    AddView()
        .modelContainer(for: User.self, inMemory: true)
}
