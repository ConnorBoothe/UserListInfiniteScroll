//
//  ContentView.swift
//  UserList
//
//  Created by Connor Boothe on 10/31/21.
//

import SwiftUI
struct ContentView: View {
    @EnvironmentObject var userList:UserList;
    @State var dataRendered:Bool = false;
    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(self.userList.users) {
                        UserItem(user: $0)
                    }
                    //prevent onAppear event from firing on initial render
                    if(self.dataRendered){
                        Rectangle()
                            .background(Color.white)
                            .foregroundColor(Color.white)
                        .onAppear {
                           self.userList.getUsers()
                        }
                    } 
                }
                .onAppear{
                    self.dataRendered = true;
                }
            }
            .navigationTitle(String("User List"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}
