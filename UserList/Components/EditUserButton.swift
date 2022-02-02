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
            Image(systemName: "gear")
                .font(.system(size: 15))
                .padding(5)
                .foregroundColor(Color.black)
        }
    }
}
