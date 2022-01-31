//
//  ContentView.swift
//  UserList
//
//  Created by Connor Boothe on 10/31/21.
//

import SwiftUI
import RealmSwift
import Alamofire
struct ContentView: View {
    @StateObject var realmManager = RealmManager();
    @State var searchText:String = ""
    var body: some View {
        NavigationView {
            VStack{
                VStack{
                    SearchBar(searchText: $searchText)
                        .environmentObject(realmManager)
                }
                .padding(10)
                UserList(searchText: searchText)
                    .environmentObject(realmManager)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 25))
                        .foregroundColor(Color(.systemGray))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}
