//
//  User.swift
//  UserList
//
//  Created by Connor Boothe on 10/31/21.
//

import Foundation
import RealmSwift
import Alamofire

struct UserStruct: Identifiable, UserProtocol {
    var id: ObjectId
    var firstName: String
    var lastName: String
    var email: String
    var age: Double
    var thumbnail: String
    var image: String
    var gender: String
    var country: String
    var follow: Bool?
    
    func followUser(realmManager: RealmManager, user:UserStruct) {
        if let follow = user.follow {
            realmManager.updateUser(
                id: user.id,
                firstName: user.firstName,
                lastName: user.lastName,
                email: user.email,
                country: user.country,
                age: user.age,
                gender: user.gender,
                follow: !follow
            )
        }
        else {
            print("follow status not set")
        }
       

    }
}
