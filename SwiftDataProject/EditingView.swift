//
//  EditingView.swift
//  SwiftDataProject
//
//  Created by Maks Winters on 16.12.2023.
//

import SwiftUI
import SwiftData

struct EditingView: View {
    
    @State var user: User
    
    var body: some View {
        List {
            TextField("Enter a name", text: $user.name)
            TextField("Enter a city", text: $user.city)
            DatePicker("Enter a date", selection: $user.joinDate, displayedComponents: .date)
        }
        .navigationTitle("Editing view")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let user = User(name: "Some user", city: "Some city", joinDate: .now.addingTimeInterval(86400 * 5))
        
        return EditingView(user: user)
            .modelContainer(container)
    } catch {
        return Text(error.localizedDescription)
    }
}
