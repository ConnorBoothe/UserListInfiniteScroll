//
//  GetUsers.swift
//  UserList
//
//  Created by Connor Boothe on 10/31/21.
//

import Foundation

class UserList: ObservableObject {
    @Published var users:Array<User>;
    init() {
            self.users = []
            self.getUsers()
       }
    //get 10 users at a time
    func getUsers(){
        let request = NSMutableURLRequest(url: NSURL(string: "https://randomuser.me/api/?results=10")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        if (error != nil) {
            print(error!)
        } else {
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    let results = convertedJsonIntoDict["results"] as? Array<NSDictionary>
                    for i in results!.indices {
                        let email = results![i]["email"] as! String
                        let name = results![i]["name"] as? NSDictionary
                        let dob = results![i]["dob"] as? NSDictionary
                        let age = dob!["age"] as! Int
                        let picture = results![i]["picture"] as? NSDictionary
                        let firstName = name!["first"] as! String
                        let lastName = name!["last"] as! String
                        let image = picture!["large"] as! String
                        let thumbnail = picture!["thumbnail"] as! String
                        let gender = results![i]["gender"] as! String
                        let location = results![i]["location"] as? NSDictionary
                        let country = location!["country"] as! String
                        //go back to main thread
                        DispatchQueue.main.async {
                            self.users.append(User(firstName: firstName, lastName: lastName, email: email, age: age, thumbnail: URL(string:thumbnail)!, image: URL(string:image)!, gender: gender, country: country))
                        }
                    }
                    }
            }
            catch {
                print(error)
            }
        }
    })
    dataTask.resume()
    }
}
