//
//  UserItem.swift
//  UserList
//
//  Created by Connor Boothe on 10/31/21.
//

import SwiftUI
import URLImage

struct UserItem: View {
    var user: User;
    var body: some View {
            HStack{
                NavigationLink(destination: UserProfile(id: user.id, image: user.image, firstName: user.firstName, lastName: user.lastName, email: user.email, country: user.country, age: user.age, gender: user.gender)){
                    if(URL(string: user.thumbnail) != nil){
                        URLImage(url: URL(string: user.thumbnail)!) { image in
                            image
                                .resizable()
                                .frame(width: 50, height: 50)
                                .aspectRatio(1, contentMode: .fit)
                                .cornerRadius(50)
                        }
                    }
                    Text(user.firstName + "  " + user.lastName)
                }
            }
    }
}
