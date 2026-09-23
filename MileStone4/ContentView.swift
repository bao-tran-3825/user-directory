//
//  ContentView.swift
//  MileStone4
//
//  Created by Gojo Satoru on 25/8/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \User.name) private var users: [User]
    @State private var showingDetail = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(users) { user in
                        NavigationLink(value: user) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.name)
                                    .font(.headline)
                                Text(user.email)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text(user.address)
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                            .padding(.vertical, 2)
                        }
                    }
                }
                
                Button("Add", systemImage: "plus") {
                    showingDetail = true
                }
            }
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                DetailView(user: user)
            }
            .task {
                await loadData()
            }
            .sheet(isPresented: $showingDetail) {
                AddView()
            }
        }
    }
    
    func loadData() async {
        guard users.isEmpty else { return }

        do {
            let url = URL(string: "https://hws.dev/friendface.json")!
            let (data, _) = try await URLSession.shared.data(from: url)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let downloadedUsers = try decoder.decode([User].self, from: data)
            let insertContext = ModelContext(modelContext.container)

            for user in downloadedUsers {
                insertContext.insert(user)
            }

            try insertContext.save()
        } catch {
            print("Download failed")
        }
    }
}

#Preview {
    ContentView()
}
