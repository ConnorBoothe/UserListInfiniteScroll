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
    var id: ObjectId
    var image: String
    var firstName:String
    var lastName: String
    var email: String
    var country: String
    var age: Double
    var gender: String
    var body: some View {
        VStack {
            URLImage(url: URL(string: image)!) { image in
                image
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(1, contentMode: .fit)
            }
            Text(firstName + " " + lastName)
                .bold()
            Text("\(Int(age)) years old")
            Text("User Details")
                .font(.system(size: 22))
                .bold()
                .padding(.top, 10)
                .padding(.bottom, 10)

            VStack{
                HStack{
                    Image(systemName: "envelope.fill")
                    Text(email)
                }.frame(minWidth:0, maxWidth: 300, alignment: .leading)
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                HStack{
                    Image(systemName: "mappin.and.ellipse")
                    Text(country)
                }.frame(minWidth:0, maxWidth: 300, alignment: .leading)
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                HStack{
                    Image(systemName: "person.fill")
                    Text(gender)

                }.frame(minWidth:0, maxWidth: 300, alignment: .leading)
                    .padding(.top, 5)
                    .padding(.bottom, 5)
            }.frame(alignment: .center)
            Spacer()
            
        }
        .navigationBarItems(trailing: EditUserButton(showEditUser: self.$showEditUser))
//        .onAppear{
//            realmManager.setCurrentUser(user: user)
//        }
        .sheet(isPresented: $showEditUser){
            EditUser(id: id, firstName1: firstName, lastName1: lastName, email1: email, country1: country, age1: age, gender1: gender)
                .ignoresSafeArea()
                .background(Color(.systemGray6))
        }
        
        
        Spacer()
    }
}
