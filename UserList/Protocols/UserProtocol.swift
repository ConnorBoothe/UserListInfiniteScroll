//
//  UserProtocol.swift
//  UserList
//
//  Created by Connor Boothe on 2/6/22.
//

import Foundation
import RealmSwift
protocol UserProtocol {
    var id: ObjectId { get set }
    var firstName: String { get set }
    var lastName: String { get set }
    var email: String { get set }
    var age: Double { get set }
    var thumbnail: String { get set }
    var image: String { get set }
    var gender: String { get set }
    var country: String { get set }
    
    func followUser(realmManager: RealmManager, user: UserStruct) -> Void
}
