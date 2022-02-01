//
//  UpdateUserField.swift
//  UserList
//
//  Created by Connor Boothe on 1/31/22.
//

import SwiftUI

struct UpdateUserField: View {
    var label:String
    @Binding var value:String
    var body: some View {
        VStack{
            Text(label)
                .frame(maxWidth:.infinity, alignment: .leading)
                .padding(.leading, 10)
            TextField(value, text: $value)
                .padding(.leading, 10)
        }
        .padding(.bottom, 0)
        .padding(.top, 10)
        .padding(5)
        .background(Color(.systemGray6))
        
       
        Rectangle()
            .padding(.bottom, 0)
            .frame(height: 0.5, alignment: .bottom)
            .foregroundColor(Color.gray)
    }
}
