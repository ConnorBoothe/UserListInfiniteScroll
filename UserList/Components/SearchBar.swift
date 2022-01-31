//
//  SearchBar.swift
//  UserList
//
//  Created by Connor Boothe on 1/30/22.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText:String;
    @EnvironmentObject var realmManager:RealmManager;

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Seach people", text: $searchText)
                .onChange(of: searchText){
                    newValue in
                    realmManager.searchUsers(text: searchText)
                }
                .background(Color(.systemGray6))
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(20)
    }
}
