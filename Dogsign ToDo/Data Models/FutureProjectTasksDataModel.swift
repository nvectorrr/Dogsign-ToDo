//
//  FutureProjectTasksDataModel.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 12.04.2021.
//

import Foundation
import FirebaseFirestore

class FutureProjectTaskDataModel : ObservableObject {
    @Published var currentProjectTasks = [GlobalTask]()
    @Published var tasksForMigration = [GlobalTask]()
    
    func fetchData(project: String) {
        db.collection(futureTasksPath).addSnapshotListener { (querySnapshot, err) in
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
    
    func fetchAndMigrate(project: String) {
        db.collection(futureTasksPath).addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.tasksForMigration.removeAll()
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
                        self.tasksForMigration.append(newTask)
                    }
                }
                self.pushMigratedTasks()
            }
        }
    }
    
    func pushMigratedTasks() {
        sortBeforePush()
        
        for i in 0 ..< tasksForMigration.count {
            db.collection(tasksPath).addDocument(data: ["title" : tasksForMigration[i].title, "descr" : tasksForMigration[i].description, "deadline" : tasksForMigration[i].deadline, "isFinished" : 0, "createdDate" : currDateToTimestamp(), "assigned_user" : tasksForMigration[i].assignedUser, "taskRelatedData" : "none", "assigned_project" : tasksForMigration[i].project, "important" : tasksForMigration[i].important]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
    }

    func sortBy() {
        currentProjectTasks = currentProjectTasks.sorted(by: {$0.localCrDate.compare($1.localCrDate) == .orderedDescending})
    }
    
    func sortBeforePush() {
        tasksForMigration = tasksForMigration.sorted(by: {$0.localCrDate.compare($1.localCrDate) == .orderedDescending})
    }
}
