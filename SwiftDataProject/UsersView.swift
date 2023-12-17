//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Maks Winters on 17.12.2023.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    @Query var users: [User]
    
    var body: some View {
        ForEach(users) { user in
            NavigationLink(value: user) {
                VStack(alignment: .leading) {
                    Text(user.name)
                    Text(user.formattedDate)
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                        .padding(.vertical, 1)
                }
            }
        }
    }
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate > minimumJoinDate
        }, sort: sortOrder)
    }
}

#Preview {
    UsersView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
