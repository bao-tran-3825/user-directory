//
//  DetailView.swift
//  MileStone4
//
//  Created by Gojo Satoru on 26/8/25.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    let user: User
    
    var body: some View {
        List {
            // User ID
            HStack {
                Image(systemName: "number.circle.fill")
                    .foregroundColor(.blue)
                VStack(alignment: .leading, spacing: 2) {
                    Text("User ID")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
//                    Text(String(user.id))
                        .font(.body)
                }
                Spacer()
            }
            .padding(.vertical, 4)
            
            // Active Status
            HStack {
                Image(systemName: user.isActive ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor(user.isActive ? .green : .red)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Status")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    Text(user.isActive ? "Active" : "Inactive")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(user.isActive ? .green : .red)
                }
                Spacer()
            }
            .padding(.vertical, 4)
            
            // Age
            HStack {
                Image(systemName: "calendar.circle.fill")
                    .foregroundColor(.orange)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Age")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    Text("\(user.age) years old")
                        .font(.body)
                }
                Spacer()
            }
            .padding(.vertical, 4)
            
            // Company
            HStack {
                Image(systemName: "building.2.fill")
                    .foregroundColor(.purple)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Company")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    Text(user.company)
                        .font(.body)
                }
                Spacer()
            }
            .padding(.vertical, 4)
            
            // Email
            HStack {
                Image(systemName: "envelope.fill")
                    .foregroundColor(.blue)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Email")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    Text(user.email)
                        .font(.body)
                        .foregroundColor(.blue)
                }
                Spacer()
            }
            .padding(.vertical, 4)
            
            // Address
            HStack {
                Image(systemName: "location.fill")
                    .foregroundColor(.red)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Address")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    Text(user.address)
                        .font(.body)
                }
                Spacer()
            }
            .padding(.vertical, 4)
            
            // About
            HStack(alignment: .top) {
                Image(systemName: "doc.text.fill")
                    .foregroundColor(.green)
                VStack(alignment: .leading, spacing: 2) {
                    Text("About")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    Text(user.about)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
            }
            .padding(.vertical, 4)
            
            // Registration Date
            HStack {
                Image(systemName: "calendar.badge.plus")
                    .foregroundColor(.indigo)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Registration Date")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    Text(user.registered.formatted(date: .abbreviated, time: .omitted))
                        .font(.body)
                }
                Spacer()
            }
            .padding(.vertical, 4)
            
            // Tags Section
            if !user.tags.isEmpty {
                HStack(alignment: .top) {
                    Image(systemName: "tag.fill")
                        .foregroundColor(.pink)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Tags")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                        
                        LazyVGrid(columns: [
                            GridItem(.adaptive(minimum: 80))
                        ], spacing: 6) {
                            ForEach(user.tags, id: \.self) { tag in
                                Text(tag.capitalized)
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.blue.opacity(0.1))
                                    .foregroundColor(.blue)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    Spacer()
                }
                .padding(.vertical, 4)
            }
            
            // Friends Section
            if !user.friends.isEmpty {
                HStack(alignment: .top) {
                    Image(systemName: "person.2.fill")
                        .foregroundColor(.cyan)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Friends (\(user.friends.count))")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(user.friends) { friend in
                                HStack {
                                    Image(systemName: "person.circle.fill")
                                        .foregroundColor(.blue)
                                        .font(.caption)
                                    Text(friend.name)
                                        .font(.body)
                                    Spacer()
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
    }
    
    func deleteBook() {
        dismiss()
    }
}

#Preview {
    NavigationStack {
        Text("DetailView Preview")
            .navigationTitle("User Detail")
    }
}
