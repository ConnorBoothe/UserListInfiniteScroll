//
//  User.swift
//  UserList
//
//  Created by Connor Boothe on 10/31/21.
//

import Foundation

struct User: Identifiable {
    let id = UUID()
    let firstName: String
    let lastName: String
    let email: String
    let age:Int
    let thumbnail: URL
    let image: URL
    let gender: String
    let country: String
}
