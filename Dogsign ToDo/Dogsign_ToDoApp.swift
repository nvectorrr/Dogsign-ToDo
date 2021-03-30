//
//  Dogsign_ToDoApp.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 30.03.2021.
//

import SwiftUI
import Firebase

@main
struct Dogsign_ToDoApp: App {
    init() {
        FirebaseApp.configure()
        
        let fsMgr = FirebaseManager()
        fsMgr.startFirebase()
    }
    
    var body: some Scene {
        WindowGroup {
            
            WelcomeView()
        }
    }
}
