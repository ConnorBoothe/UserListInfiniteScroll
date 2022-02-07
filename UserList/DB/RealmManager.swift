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
    var notificationToken: NotificationToken?
    @Published var users = [User]()

    init(){
        openRealm()
        if let users = localRealm?.objects(User.self){
            self.users = Array(users)
        }
        
        //observe the realm for changes and react
        notificationToken = localRealm!.observe { notification, realm in
            if(notification == .didChange){
                self.getUsers()
            }
        }
    }
    /**
     Opens a local realm object on the main thread
     */
    func openRealm(){
        do {
            let config = Realm.Configuration(schemaVersion: 2)
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
        } catch {
            print("Error opening Realm: \(error)")
        }
    }
    /**
    Add User to realm in a background thread
     Parameters:
        - firstName: String,
        - lastName: String,
        - email: String,
        - age: Double,
        - thumbnail: String,
        - image: String,
        - gender: String,
        - country: String
     */
    func addUser(firstName:String, lastName:String, email:String, age:Double,
                 thumbnail:String, image:String, gender:String, country:String) {
        //works, but list is not updating properly
        DispatchQueue(label: "background").async{
            autoreleasepool {
                let realm = try! Realm()
                do {
                    try realm.write {
                        let user = User(value: ["firstName": firstName, "lastName": lastName, "email": email, "age": age,
                                                "thumbnail": thumbnail, "image": image , "gender": gender, "country": country, "follow": false])
                        realm.add(user)
                        print("added new task: \(user)")
                    }
                }
                catch {
                    print("Error adding Realm: \(error)")
                }
            }
        }
    }
    /**
     Get user objects
        Parameters:
     */
    func getUsers(){
        //fetch users to the main thread for UI use
        if let localRealm = localRealm {
            do {
                let allUsers = localRealm.objects(User.self)
                users = []
                allUsers.forEach { user in
                    users.append(user)
                }
            }
        }
    }
    /**
     Search Users
     - text: Search string,
     */
    func searchUsers(text: String){
        if let localRealm = localRealm {
            do {
                if(text != "") {
                    let allUsers = localRealm.objects(User.self)
                        .filter(NSPredicate(format: "firstName BEGINSWITH %@", text))
                        .sorted(byKeyPath: "firstName")
                    
                     users = []
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
    /**
     Delete users from realm
        - id: ObjectId of user to delete
        - searchText: Search string to pass if text is in the search bar during deletion
        
     */
    func deleteUser(id: ObjectId, searchText:String){
        //works, but flashes empty array then populates
        DispatchQueue(label: "background").async{
            autoreleasepool {
                let realm = try! Realm()
                do {
                    let userToDelete = realm.objects(User.self).filter(NSPredicate(format: "id == %@", id))
                    guard !userToDelete.isEmpty else {return}
                        try realm.write {
                            realm.delete(userToDelete)
                        }
                    } catch {
                        print("error deleting task with \(id)")
                    }
            }
        }
    }
    func getFollowing(){
        //fetch users to the main thread for UI use
        if let localRealm = localRealm {
            do {
                let followingUsers = localRealm.objects(User.self).filter(NSPredicate(format: "follow == %@", NSNumber(value: true)))
                users = []
                followingUsers.forEach { user in
                    users.append(user)
                    print(user)
                }
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
    /**
    Update user object in a background thread
     Parameters:
        - id: ObjectId
        - firstName: String,
        - lastName: String,
        - email: String,
        - age: Double,
        - thumbnail: String,
        - image: String,
        - gender: String,
        - country: String
     */
    func updateUser(id: ObjectId, firstName: String, lastName: String, email: String,
                    country:String, age: Double, gender: String, follow: Bool){
        
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
                            userToUpdate[0].follow = follow
                            print("Updated task with id \(id)")
                        }

                } catch {
                    print("Error updating task \(id) to Realm \(error)")
                }
                }
            }
    }
}
