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
    @Published var isAuth = 0
    
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
        
        let dir = FileManager.default.homeDirectoryForCurrentUser
        let filepath = dir.appendingPathComponent(".dogsignData")
        print(filepath)
        do {
            let savedDataContainer = try String(contentsOf: filepath, encoding: .utf8)
            if isUserExists(localData: parseLocalData(dataString: savedDataContainer)) {
                return true
            }
        } catch {
            isAuth = 2
            print("catch")
        }
        return false
    }
    
    func parseLocalData(dataString: String) -> [String] {
        var parsedData = [String]()
        parsedData = dataString.components(separatedBy: ";")
       
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
                    self.isAuth = 1
                }
            }
        }
    }
    
    func isUserExists(localData: [String]) -> Bool {
        for i in 0 ..< usersList.count {
            if(usersList[i].login == localData[0] && usersList[i].password == localData[1]) {
                return true
            }
        }
        return false
    }
    
    func loginAction(login: String, pass: String) -> Bool {
        for i in 0 ..< usersList.count {
            if(usersList[i].login == login && usersList[i].password == pass) {
                isAuth = 1
                let str = login + ";" + pass + ";"
                saveLogonDataLocally(str: str)
                return true
            }
        }
        return false
    }
    
    func saveLogonDataLocally(str: String) {
        let dir = FileManager.default.homeDirectoryForCurrentUser
        let filepath = dir.appendingPathComponent(".dogsignData")
        
        if (FileManager.default.createFile(atPath: filepath.path, contents: nil, attributes: nil)) {
            do {
                try str.write(to: filepath, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print("catch")
            }
        } else {
            print("File not created.")
        }
    }
}
