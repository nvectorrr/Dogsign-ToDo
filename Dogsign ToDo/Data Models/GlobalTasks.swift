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
    var project = "Не добавлен"
    var description = "Отсутствует"
    var deadline = "Не назначен"
    var createdDate : Timestamp!
    var isFinished = 0
    var assignedUser = "Не назначен"
    var taskRelatedData = "Отсутствует"
    var important = 0
    var localCrDate = Date()
}

class GlobalTasksDataModel : ObservableObject {
    @Published var globalTasks = [GlobalTask]()
    @Published var currentUserTasks = [GlobalTask]()
    @Published var finishedCurrentUserTasks = [GlobalTask]()
    
    func fetchData() {
        db.collection(tasksPath).addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.globalTasks.removeAll()
                self.currentUserTasks.removeAll()
                self.finishedCurrentUserTasks.removeAll()
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
                    
                    if(newTask.isFinished != 1 && currentUser.login == newTask.assignedUser) {
                        self.currentUserTasks.append(newTask)
                    } else if (newTask.isFinished == 1 && currentUser.login == newTask.assignedUser) {
                        self.finishedCurrentUserTasks.append(newTask)
                    } else {
                        self.globalTasks.append(newTask)
                    }
                }
                self.sortBy()
            }
        }
    }
    
    func sortBy() {
        globalTasks = globalTasks.sorted(by: {$0.localCrDate.compare($1.localCrDate) == .orderedDescending})
        currentUserTasks = currentUserTasks.sorted(by: {$0.localCrDate.compare($1.localCrDate) == .orderedDescending})
        finishedCurrentUserTasks = finishedCurrentUserTasks.sorted(by: {$0.localCrDate.compare($1.localCrDate) == .orderedDescending})
    }
}
