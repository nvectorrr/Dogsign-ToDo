//
//  CurrentProjectTasksDataModel.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 05.04.2021.
//

import Foundation
import FirebaseFirestore

class CurrentProjectTaskDataModel : ObservableObject {
    @Published var currentProjectTasks = [GlobalTask]()
    
    func fetchData(project: String) {
        db.collection(tasksPath).addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.currentProjectTasks.removeAll()
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
                    
                    if(newTask.project == project) {
                        newTask.localCrDate = newTask.createdDate.dateValue()
                        self.currentProjectTasks.append(newTask)
                    }
                }
                self.sortBy()
            }
        }
    }
    
    func sortBy() {
        currentProjectTasks = currentProjectTasks.sorted(by: {$0.localCrDate.compare($1.localCrDate) == .orderedDescending})
    }
}
