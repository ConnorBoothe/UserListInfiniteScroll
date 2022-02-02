//
//  UserListApp.swift
//  UserList
//
//  Created by Connor Boothe on 10/31/21.
//

import SwiftUI
@main
struct UserListApp: App {
    @StateObject var realmManager:RealmManager = RealmManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(realmManager)
        }
    }
}
