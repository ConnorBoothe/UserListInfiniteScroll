//
//  GetUsers.swift
//  UserList
//
//  Created by Connor Boothe on 10/31/21.
//

import Foundation
import Alamofire
class UserList: ObservableObject {
    @Published var users:Array<User>;
    init() {
            self.users = []
//            self.getUsers()
            self.getUsersWithAlamofire()
       }
    //get 10 users at a time
//    func getUsers(){
//        let request = NSMutableURLRequest(url: NSURL(string: "https://randomuser.me/api/?results=10")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//        if (error != nil) {
//            print(error!)
//        } else {
//            do {
//                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
//                    let results = convertedJsonIntoDict["results"] as? Array<NSDictionary>
//
//                    for i in results!.indices {
//                        let email = results![i]["email"] as! String
//                        let name = results![i]["name"] as? NSDictionary
//                        let dob = results![i]["dob"] as? NSDictionary
//                        print(dob)
//
//                        let age = dob!["age"] as! Int
//                        let picture = results![i]["picture"] as? NSDictionary
//                        let firstName = name!["first"] as! String
//                        let lastName = name!["last"] as! String
//                        let image = picture!["large"] as! String
//                        let thumbnail = picture!["thumbnail"] as! String
//                        let gender = results![i]["gender"] as! String
//                        let location = results![i]["location"] as? NSDictionary
//                        print(location)
//                        let country = location!["country"] as! String
//                        //go back to main thread
//                        DispatchQueue.main.async {
//                            self.users.append(User(firstName: firstName, lastName: lastName, email: email, age: age, thumbnail: URL(string:thumbnail)!, image: URL(string:image)!, gender: gender, country: country))
//                        }
//                    }
//                    }
//            }
//            catch {
//                print(error)
//            }
//        }
//    })
//    dataTask.resume()
//    }
    func getUsersWithAlamofire(){
        struct UserListResponse: Codable {
            let results: [Results]
            let info: Info
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
        struct Info: Codable {
            let seed: String
            let results: Int
            let page: Int
            let version: String
        }
        AF.request( "https://randomuser.me/api/?results=10", method: .get)
            .responseDecodable(of: UserListResponse.self){
                response in
                print("response")
                print(response)
                if(response.value != nil) {
//                    print(response.value?.results)

                    for result in response.value!.results {
                        print(result.email)
                        self.users.append(User(firstName: result.name.first, lastName: result.name.last, email: result.email, age: result.dob.age, thumbnail: URL(string:result.picture.thumbnail)!, image: URL(string:result.picture.large)!, gender: result.gender, country: result.location.country))
                    }
                }

//                debugPrint(response.request?.results)

            }
        struct HTTPBinResponse: Decodable { let url: String }

//        AF.request("https://randomuser.me/api/?results=10").response { response in
//            print("response")
//            debugPrint(response)
//        }
       
    }
}
