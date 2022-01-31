//
//  UserSchema.swift
//  UserList
//
//  Created by Connor Boothe on 1/29/22.
//

import Foundation
import RealmSwift

class User: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var firstName: String = ""
    @Persisted var lastName: String = ""
    @Persisted var email: String = ""
    @Persisted var age:Double = 0.00
    @Persisted var thumbnail: String = ""
    @Persisted var image: String = ""
    @Persisted var gender: String = ""
    @Persisted var country: String = ""
}
