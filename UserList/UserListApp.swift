//
//  UserListApp.swift
//  UserList
//
//  Created by Connor Boothe on 10/31/21.
//

import SwiftUI

@main
struct UserListApp: App {
    @StateObject var users = UserList();
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(users)
        }
    }
}
