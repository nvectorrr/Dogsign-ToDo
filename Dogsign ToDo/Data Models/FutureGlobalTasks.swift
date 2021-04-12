//
//  FutureGlobalTasks.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 12.04.2021.
//

import Combine
import FirebaseFirestore
import Foundation

class FutureGlobalTasksDataModel : ObservableObject {
    @Published var globalTasks = [GlobalTask]()
    
    func fetchData() {
        db.collection(tasksPath).addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.globalTasks.removeAll()
                for document in querySnapshot!.documents {
                    var newTask = GlobalTask()
                    newTask.id = document.documentID
                    newTask.title = document["title"] as! String
                    newTask.project = document["assigned_project"] as! String
                    newTask.description = document["descr"] as! String
                    newTask.deadline = document["deadline"] as! String
                    newTask.createdDate = document["createdDate"] as! Timestamp
                    newTask.assignedUser = document["assigned_user"] as! String
                    newTask.taskRelatedData = document["taskRelatedData"] as! String
                    newTask.isFinished = document["isFinished"] as! Int
                    newTask.important = document["important"] as! Int
                    newTask.localCrDate = newTask.createdDate.dateValue()
                    
                    self.globalTasks.append(newTask)
                }
                self.sortBy()
            }
        }
    }
    
    func sortBy() {
        globalTasks = globalTasks.sorted(by: {$0.localCrDate.compare($1.localCrDate) == .orderedDescending})
    }
}
