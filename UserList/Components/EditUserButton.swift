//
//  EditUserButton.swift
//  UserList
//
//  Created by Connor Boothe on 1/31/22.
//

import SwiftUI

struct EditUserButton: View {
    @Binding var showEditUser:Bool

    var body: some View {
        Button(action: {
            self.showEditUser.toggle()
        })
        {
            Text("Edit")
                .font(.system(size: 15)).bold()
                .padding(5)
                .background(Color.blue)
                .cornerRadius(10)
                .foregroundColor(Color.white)
                
                
        }
    }
}
