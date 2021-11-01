//
//  UserItem.swift
//  UserList
//
//  Created by Connor Boothe on 10/31/21.
//

import SwiftUI
import URLImage
struct UserItem: View {
    @State var user:User;
    var body: some View {
            HStack{
                
                NavigationLink(destination: UserProfile(user: self.$user)){
                    URLImage(url: self.user.thumbnail) { image in
                        image
                            .resizable()
                            .frame(width: 50, height: 50)
                            .aspectRatio(1, contentMode: .fit)

                    }
                    Text(self.user.firstName + "  " + self.user.lastName)
                }
            }
    }
}

//struct UserItem_Previews: PreviewProvider {
//    static var previews: some View {
//        UserItem()
//    }
//}
