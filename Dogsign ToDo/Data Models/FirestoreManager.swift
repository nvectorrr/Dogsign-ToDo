//
//  FirestoreManager.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 30.03.2021.
//

import FirebaseCore
import FirebaseFirestore

var db : Firestore!

class FirebaseManager {
    func startFirebase() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        
        db = Firestore.firestore()
    }
}



