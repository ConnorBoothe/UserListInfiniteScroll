//
//  RealmManager.swift
//  UserList
//
//  Created by Connor Boothe on 1/29/22.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    @Published private(set) var users: [UserRealm] = []
    init(){
        openRealm()
    }
    func openRealm(){
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
        } catch {
            print("Error opening Realm: \(error)")
        }
    }
    func addUser(firstName:String, lastName:String, email:String, age:Double,
                 thumbnail:String, image:String, gender:String, country:String) {
        //only run if localRealm is set
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let user = UserRealm(value: ["firstName": firstName, "lastName": lastName, "email": email, "age": age,
                                                 "thumbnail": thumbnail, "image": image , "gender": gender, "country": country])
                    localRealm.add(user)
                    getUsers()
                    print("added new task: \(user)")
                }
            }
            catch {
                print("Error adding Realm: \(error)")
            }
        }
    }
    func getUsers(){
        print("getting all users")
        if let localRealm = localRealm {
            do {
                let allUsers = localRealm.objects(UserRealm.self)
//                    .sorted(byKeyPath: "firstName")
                users = []
                allUsers.forEach { user in
                    users.append(user)
                }
            }
        }
    }
    func searchUsers(text: String){
        print("getting search users")
        print("text")
        print(text)
        if let localRealm = localRealm {
            do {
                if(text != "") {
                    let allUsers = localRealm.objects(UserRealm.self)
                        .filter(NSPredicate(format: "firstName BEGINSWITH %@", text))
                        .sorted(byKeyPath: "firstName")
                    
                     users = []
                     print("all users")
                     print(allUsers)
                     allUsers.forEach { user in
                         print(user.firstName)
                         users.append(user)
                     }
                }
                else {
                    getUsers()
                }
            }
        }
    }
    func deleteUser(id: ObjectId){
        if let localRealm = localRealm {
            do {
                let userToDelete = localRealm.objects(UserRealm.self).filter(NSPredicate(format: "id == %@", id))
                guard !userToDelete.isEmpty else {return}
                    try localRealm.write {
                        users = []
                        localRealm.delete(userToDelete)
                        print("Deleted task with id \(id)")
                        print(localRealm.objects(UserRealm.self).isInvalidated) //returning false, so object is still valid
                        //time between delete and below function call is causing error
                        getUsers()

                    }
                } catch {
                    print("error deleting task with \(id)")
                }
            }
        }
    func deleteAll(){
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    localRealm.deleteAll()
                }
            } catch {
                print("error deleting task with \(error)")
            }
        }
    }
}
