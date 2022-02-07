//
//  FollowButton.swift
//  UserList
//
//  Created by Connor Boothe on 2/6/22.
//

import SwiftUI

struct FollowButton: View {
    @EnvironmentObject var realmManager:RealmManager;
    var user:UserStruct
    var body: some View {
        Button(action:{
            print(user)
            user.followUser(realmManager: realmManager, user: user)
        }){
            if let follow = user.follow {
                if(follow) {
                    Text("Following")
                        .bold()
                        .frame(maxWidth: .infinity, maxHeight: 30, alignment: .center)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
                else {
                    Text("Follow")
                        .bold()
                        .frame(maxWidth: .infinity, maxHeight: 30, alignment: .center)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
            }
            else {
                Text("Follow")
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: 30, alignment: .center)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            }
            
        }
    }
}
