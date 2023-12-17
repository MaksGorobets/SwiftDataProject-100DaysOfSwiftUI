//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Maks Winters on 16.12.2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showingUpcomingOnly = false
    @State private var sortingOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate)
    ]
    @State var path = [User]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section {
                    ScrollView(.horizontal) {
                        HStack {
                            Button(showingUpcomingOnly ? "Show all" : "Show upcoming") {
                                withAnimation {
                                    showingUpcomingOnly.toggle()
                                }
                            }
                            .buttonStyle(.bordered)
                            ZStack {
                                RoundedRectangle(cornerRadius: 7)
                                    .foregroundStyle(.gray.opacity(0.2))
                                    .frame(height: 35)
                                Picker("Sorting by", selection: $sortingOrder) {
                                        Text("Name")
                                            .tag([
                                                SortDescriptor(\User.name),
                                                SortDescriptor(\User.joinDate)
                                            ])
                                        Text("Join Date")
                                            .tag([
                                                SortDescriptor(\User.joinDate),
                                                SortDescriptor(\User.name)
                                            ])
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                UsersView(minimumJoinDate: showingUpcomingOnly ? .now : .distantPast, sortOrder: sortingOrder)
            }
            .navigationDestination(for: User.self) { user in
                EditingView(user: user)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Delete all", systemImage: "trash") {
                        try? modelContext.delete(model: User.self)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add user", systemImage: "plus") {
                        let newUser = User(name: "", city: "", joinDate: .now)
                        modelContext.insert(newUser)
                        path = [newUser]
                    }
                }
            }
            .navigationTitle("SwiftDataProject")
        }
    }
}

#Preview {
    ContentView()
}
