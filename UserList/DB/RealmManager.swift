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
    @Published var users = [User]()
    @Published var currentUser:User?
    init(){
        openRealm()
        
        if let users = localRealm?.objects(User.self){
            self.users = Array(users)
        }
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
        //works, but list is not updating properly
        DispatchQueue(label: "background").async{
            autoreleasepool {
                let realm = try! Realm()
                do {
                    try realm.write {
                        let user = User(value: ["firstName": firstName, "lastName": lastName, "email": email, "age": age,
                                                     "thumbnail": thumbnail, "image": image , "gender": gender, "country": country])
                        realm.add(user)
                        DispatchQueue.main.async {
                            self.getUsers()
                        }
                        
                        print("added new task: \(user)")
                    }
                }
                catch {
                    print("Error adding Realm: \(error)")
                }
            }
        }
        //only run if localRealm is set
//        if let localRealm = localRealm {
//            do {
//                try localRealm.write {
//                    let user = User(value: ["firstName": firstName, "lastName": lastName, "email": email, "age": age,
//                                                 "thumbnail": thumbnail, "image": image , "gender": gender, "country": country])
//                    localRealm.add(user)
//                    getUsers()
//                    print("added new task: \(user)")
//                }
//            }
//            catch {
//                print("Error adding Realm: \(error)")
//            }
//        }
    }
    func getUsers(){
        print("getting all users")
        if let localRealm = localRealm {
            do {
                let allUsers = localRealm.objects(User.self)
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
                    let allUsers = localRealm.objects(User.self)
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
    func deleteUser(id: ObjectId, searchText:String){
        //works, but flashes empty array then populates
        DispatchQueue(label: "background").async{
            autoreleasepool {
                let realm = try! Realm()
                do {
                    let userToDelete = realm.objects(User.self).filter(NSPredicate(format: "id == %@", id))
                    guard !userToDelete.isEmpty else {return}
                        try realm.write {
                            DispatchQueue.main.async {
                                self.users = []
                            }
                            print("delete user")
                            realm.delete(userToDelete)
//                            DispatchQueue.main.async {
////                                self.getUsers()
//                                //repopulate list with filtered users
////                                if(searchText != "") {
////                                    self.searchUsers(text: searchText)
////                                }
////                                else {
////                                    //get all users if text == ""
////                                    self.getUsers()
////                                }
//                            }
                            
                        }
                    } catch {
                        print("error deleting task with \(id)")
                    }
            }
        }
//        if let localRealm = localRealm {
//            do {
//                let userToDelete = localRealm.objects(User.self).filter(NSPredicate(format: "id == %@", id))
//                guard !userToDelete.isEmpty else {return}
//                    try localRealm.write {
//                        users = []
//                        localRealm.delete(userToDelete)
//                        //repopulate list with filtered users
//                        if(searchText != "") {
//                            searchUsers(text: searchText)
//                        }
//                        else {
//                            //get all users if text == ""
//                            getUsers()
//                        }
//                    }
//                } catch {
//                    print("error deleting task with \(id)")
//                }
//            }
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
    func updateUser(id: ObjectId, firstName: String, lastName: String, email: String,
                    country:String, age: Double, gender:String){
            DispatchQueue(label: "background").async{
                autoreleasepool {
                    print("update in bg thread")
                //need to recreate realm object each time thread changes
                do {
                    // Get realm and table instances for this thread
                    let realm = try! Realm()
                    let userToUpdate = realm.objects(User.self).filter(NSPredicate(format: "id == %@", id))
                    print(userToUpdate)
                    guard !userToUpdate.isEmpty else {return}
                        try realm.write {
                            userToUpdate[0].firstName = firstName
                            userToUpdate[0].lastName = lastName
                            userToUpdate[0].email = email
                            userToUpdate[0].country = country
                            userToUpdate[0].age = age
                            userToUpdate[0].gender = gender
                            print("Updatedtask with id \(id)")
                            //retrieve users in main thread
                            DispatchQueue.main.async {
                                print("back to main thread")
                                self.getUsers()
                            }
                            
                        }

                } catch {
                    print("Error updating task \(id) to Realm \(error)")
                }
                }
            }
    }
    func setCurrentUser(user: User){
        self.currentUser = user
    }
}
