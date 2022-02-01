//
//  EditUser.swift
//  UserList
//
//  Created by Connor Boothe on 1/31/22.
//

import SwiftUI

struct EditUser: View {
    @EnvironmentObject var realmManager:RealmManager;
    @Environment(\.presentationMode) var presentationMode
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var country: String = ""
    @State var age: Double = 45.00
    @State var gender: String = "Female"
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if(realmManager.currentUser != nil) {
                Text("Editing \(realmManager.currentUser!.firstName)")
                    .font(.title3).bold()
                    .frame(maxWidth:.infinity, alignment: .center)
                    .padding(5)
                    .padding(.bottom, 20)
                UpdateUserField(label: "First Name", value: $firstName)
                UpdateUserField(label: "Last Name", value: $lastName)
                UpdateUserField(label: "Email", value: $email)
                UpdateUserField(label: "Country", value: $country)
                VStack{
                    Text("Gender")
                        
                        .padding(.leading, 10)
                    Picker("Select Gender", selection: $gender){
                        Text("Male").tag(0)
                        Text("Female").tag(1)
                    }
                    .padding(.leading, 10)
                }
                .frame(maxWidth:.infinity, alignment: .leading)
                .padding(.bottom, 0)
                .padding(.top, 10)
                .padding(5)
                .background(Color(.systemGray6))
                VStack{
                    Text("Age")
                        .padding(.leading, 10)
                    Picker("Select Age", selection: $age) {
                        ForEach(1...100, id: \.self) {
                            Text("\($0)").tag($0)
                        }
                    }
                    .padding(.leading, 10)
                }
                .frame(maxWidth:.infinity, alignment: .leading)
                .padding(.bottom, 0)
                .padding(.top, 10)
                .padding(5)
                .background(Color(.systemGray6))
                VStack {
                    Button(action: {
                        print("update")
                        realmManager.updateUser(
                            id: realmManager.currentUser!.id,
                            firstName: firstName,
                            lastName: lastName,
                            email: email,
                            country: country,
                            age: age,
                            gender: gender
                        )
                        presentationMode.wrappedValue.dismiss()
                    }){
                        Text("Update Profile")
                            .padding(10)
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .frame(alignment: .trailing)
                    }
                }
                .frame(maxWidth:.infinity, alignment: .trailing)
                .padding(20)
            }
        }
        .frame(maxWidth:.infinity, alignment: .leading)
        .onAppear{
            if(realmManager.currentUser != nil){
                self.firstName = realmManager.currentUser!.firstName
                self.lastName = realmManager.currentUser!.lastName
                self.email = realmManager.currentUser!.email
                self.country = realmManager.currentUser!.country
                self.age = realmManager.currentUser!.age
                self.gender = realmManager.currentUser!.gender
            }
        }
        Spacer()
    }
}
