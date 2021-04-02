//
//  UserSettings.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 31.03.2021.
//

import Foundation

var globalUser = "super"
var userManager = UserDataModel()

protocol AuthProtocol {
    func passAuth()
}

struct UserData {
    var login = ""
    var name = ""
    var password = ""
    var accessLevel = -1
}

class UserDataModel : ObservableObject {
    @Published var isAuth = false
    
    var currentUser = UserData()
    var usersList = [UserData]()
    var notifier : AuthProtocol!
    
    init() {
        self.fetchUsers()
    }
    
    func login() {}
    func logout() {}
    
    func uniPrinter() {
        print(usersList)
    }
    
    func validateUser() -> Bool {
        
        uniPrinter()
        
        let dir = FileManager.default.homeDirectoryForCurrentUser
        let filepath = dir.appendingPathComponent(".dogsignData")
        print(filepath)
        do {
            let savedDataContainer = try String(contentsOf: filepath, encoding: .utf8)
            if isUserExists(localData: parseLocalData(dataString: savedDataContainer)) {
                return true
            }
        } catch {
            print("catch")
        }
        return false
    }
    
    func parseLocalData(dataString: String) -> [String] {
        var parsedData = [String]()
        parsedData = dataString.components(separatedBy: ";")
        print("from file: \(parsedData[0]), \(parsedData[1])")
       
        return parsedData
    }
    
    func fetchUsers() {
        db.collection("users").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    var newUser = UserData()
                    newUser.login = document["login"] as! String
                    newUser.name = document["name"] as! String
                    newUser.password = document["password"] as! String
                    newUser.accessLevel = document["access_level"] as! Int
                    self.usersList.append(newUser)
                }
                if self.validateUser() {
                    self.isAuth = true
                }
            }
        }
    }
    
    func isUserExists(localData: [String]) -> Bool {
        for i in 0 ..< usersList.count {
            if(usersList[i].login == localData[0] && usersList[i].password == localData[1]) {
                
                print("match!")
                
                return true
            }
        }
        return false
    }
}
