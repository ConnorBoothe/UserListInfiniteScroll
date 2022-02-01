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
    @State var searchText:String = ""
    var body: some View {
        NavigationView {
            VStack{
                VStack{
                    SearchBar(searchText: $searchText)
                }
                .padding(10)
                
                UserList(searchText: searchText)
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
