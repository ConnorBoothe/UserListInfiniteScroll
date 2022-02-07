//
//  UserPicker.swift
//  UserList
//
//  Created by Connor Boothe on 2/6/22.
//

import SwiftUI

struct UserPicker: View {
    @EnvironmentObject var realmManager:RealmManager;
    @Binding var usersToShow: Int
    var body: some View {
        VStack {
            Picker("What is your favorite color?", selection: $usersToShow) {
                Text("All Users").tag(0)
                Text("Following List").tag(1)
            }
            .onChange(of: usersToShow, perform: { (value) in
                        print(value)
                if(value == 0){
                    realmManager.getUsers()
                }
                else {
                    realmManager.getFollowing()
                }
            })
            .pickerStyle(.segmented)
            
        }
    }
}
