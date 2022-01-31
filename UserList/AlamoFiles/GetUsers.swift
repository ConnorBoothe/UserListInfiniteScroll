//
//  GetUsers.swift
//  UserList
//
//  Created by Connor Boothe on 10/31/21.
//

import Foundation
import Alamofire
import RealmSwift

class GetUsers {
    func getUsersWithAlamofire(realmManager: RealmManager) {
        AF.request( "https://randomuser.me/api/?results=10", method: .get)
            .responseDecodable(of: UserListResponse.self){
                response in
                if(response.value != nil) {
                    for result in response.value!.results {
                        realmManager.addUser(firstName: result.name.first, lastName: result.name.last, email: result.email, age: result.dob.age, thumbnail: result.picture.thumbnail, image: result.picture.large, gender: result.gender, country: result.location.country)
                    }
                }
            }
    }
}
