//
//  UserProfile.swift
//  UserList
//
//  Created by Connor Boothe on 10/31/21.
//

import SwiftUI
import URLImage
struct UserProfile: View {
    @Binding var user:User;
    var body: some View {
        VStack {
            URLImage(url: self.user.image) { image in
                image
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(1, contentMode: .fit)
            }
            Text(self.user.firstName + "  " + self.user.lastName)
                .bold()
            Text("\(self.user.age) years old")
            Text("User Details")
                .font(.system(size: 22))
                .bold()
                .padding(.top, 10)
                .padding(.bottom, 10)
            
            VStack{
                HStack{
                    Image(systemName: "envelope.fill")
                    Text(self.user.email)
                }.frame(minWidth:0, maxWidth: 300, alignment: .leading)
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                HStack{
                    Image(systemName: "mappin.and.ellipse")
                    Text(self.user.country)
                }.frame(minWidth:0, maxWidth: 300, alignment: .leading)
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                HStack{
                    Image(systemName: "person.fill")
                    Text(self.user.gender)
                    
                }.frame(minWidth:0, maxWidth: 300, alignment: .leading)
                    .padding(.top, 5)
                    .padding(.bottom, 5)
            }.frame(alignment: .center)
            Spacer()
            
        }
        Spacer()
    }
}

//struct UserProfile_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfile()
//    }
//}
