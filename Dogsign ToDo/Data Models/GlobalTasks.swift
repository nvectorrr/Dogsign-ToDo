//
//  GlobalTasks.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 30.03.2021.
//

import Combine
import FirebaseFirestore
import Foundation

struct GlobalTask : Identifiable {
    var id = ""
    var title = "Не названа"
    var description = "Отсутствует"
    var deadline = "Не назначен"
    var createdDate : Timestamp!
    var isFinished = 0
}

class GlobalTasksDataModel : ObservableObject {
    @Published var globalTasks = [GlobalTask]()
    
    func fetchData() {
        db.collection("global_tasks").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.globalTasks.removeAll()
                for document in querySnapshot!.documents {
                    var newTask = GlobalTask()
                    newTask.id = document.documentID
                    newTask.title = document["title"] as! String
                    newTask.description = document["descr"] as! String
                    newTask.deadline = document["deadline"] as! String
                    newTask.createdDate = document["createdDate"] as! Timestamp
                    newTask.isFinished = document["isFinished"] as! Int
                    self.globalTasks.append(newTask)
                }
            }
        }
    }
    
    /*
    func updateView() {
        self.objectWillChange.send()
    }
     */
}
