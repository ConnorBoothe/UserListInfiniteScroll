//
//  UserListResponse.swift
//  UserList
//
//  Created by Connor Boothe on 1/27/22.
//
import Foundation

struct UserListResponse: Codable {
    let results: [Results]
}
struct Results: Codable {
    let name: Name
    let email: String
    let dob: DOB
    let picture: Picture
    let gender: String
    let location: Location
    
}
struct Name: Codable {
    let first: String
    let last: String
    
}
struct DOB: Codable {
    let age: Double
}
struct Picture: Codable {
    let thumbnail: String
    let large: String
}
struct Location: Codable {
    let country: String
}
