//
//  UserProfile.swift
//  UserList
//
//  Created by Connor Boothe on 10/31/21.
//

import SwiftUI
import URLImage
import RealmSwift
struct UserProfile: View {
    @EnvironmentObject var realmManager:RealmManager;
    @State var showEditUser = false;
    var user: UserStruct
    var body: some View {
        VStack {
            URLImage(url: URL(string: user.image)!) { image in
                image
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(1, contentMode: .fit)
            }
            Text(user.firstName + " " + user.lastName)
                .bold()
            Text("\(Int(user.age)) years old")
            Text("User Details")
                .font(.system(size: 22))
                .bold()
                .padding(.top, 10)
                .padding(.bottom, 10)

            VStack{
                HStack{
                    Image(systemName: "envelope.fill")
                    Text(user.email)
                }.frame(minWidth:0, maxWidth: 300, alignment: .leading)
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                HStack{
                    Image(systemName: "mappin.and.ellipse")
                    Text(user.country)
                }.frame(minWidth:0, maxWidth: 300, alignment: .leading)
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                HStack{
                    Image(systemName: "person.fill")
                    Text(user.gender)

                }.frame(minWidth:0, maxWidth: 300, alignment: .leading)
                    .padding(.top, 5)
                    .padding(.bottom, 5)
            }.frame(alignment: .center)
            Spacer()
            
        }
        .navigationBarItems(trailing: EditUserButton(showEditUser: self.$showEditUser))
        .sheet(isPresented: $showEditUser){
            EditUser(id: user.id, firstName1: user.firstName, lastName1: user.lastName, email1: user.email, country1: user.country, age1: user.age, gender1: user.gender)
                .background(Color(.systemGray6))
                .ignoresSafeArea()
        }
        Spacer()
        VStack{
            FollowButton(user: user)
        }
        .padding()
    }
}
