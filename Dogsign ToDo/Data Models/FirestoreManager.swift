//
//  FirestoreManager.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 30.03.2021.
//

import FirebaseCore
import FirebaseFirestore

var db : Firestore!
let tasksPath = "tasks_feed"
let futureTasksPath = "future_tasks_feed"
let currentProjectsPath = "current_projects"
let futureProjectsPath = "future_projects"
let requirementsPath = "requirements"

class FirebaseManager {
    func startFirebase() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        
        db = Firestore.firestore()
    }
}


