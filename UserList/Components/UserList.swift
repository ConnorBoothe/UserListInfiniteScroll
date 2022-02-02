//
//  UserList.swift
//  UserList
//
//  Created by Connor Boothe on 1/30/22.
//

import SwiftUI
import RealmSwift
import Alamofire

struct UserList: View {
    var searchText:String
    @EnvironmentObject var realmManager:RealmManager;
    @State var dataRendered:Bool = false;
    var getUsers = GetUsers()
    var body: some View {
        List {
            if #available(iOS 15.0, *) {
                //supplying id:\.self here causes app to crash
                //users conforms to protocol ObjectKeyIdentifiable, so no need to include id
                ForEach(realmManager.users) {
                    user in
                    if !user.isInvalidated {
                        UserItem(user: user)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive){
                                    realmManager.deleteUser(id: user.id, searchText: searchText)
                                }
                                label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                }
                .listRowSeparator(.hidden)
            } else {
                // Fallback on earlier versions
                ForEach(realmManager.users, id:\.self) {
                    user in
                    if !user.isInvalidated {
                        UserItem(user: user)
                    }
                }
            }
        Rectangle()
            .background(Color.white)
            .foregroundColor(Color.white)
            .onAppear {
                if(self.dataRendered && self.searchText == ""){
                    getUsers.getUsersWithAlamofire(realmManager: realmManager)
                }
            }
        }
        .onAppear{
            print("on appear")
//            realmManager.setCurrentUser(user: nil)
            UITableViewCell.appearance().backgroundColor = UIColor.clear
            if(self.searchText == ""){
                realmManager.getUsers()
            }
            self.dataRendered = true
            if(realmManager.users.count == 0) {
                getUsers.getUsersWithAlamofire(realmManager: realmManager)
            }
        }
    }
}
