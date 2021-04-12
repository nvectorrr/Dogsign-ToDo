//
//  ContentPlanDataModel.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 12.04.2021.
//

import Foundation
import FirebaseFirestore

struct ContentPlanData : Identifiable {
    var id = ""
    var title = ""
    var description = "Отсутствует"
    var relatedData = "Отсутствует"
    var week = -1
    var createdDate : Timestamp!
    var localCrDate : Date!
    var isFinished = 0
}

class ContentPlanDataModel : ObservableObject {
    @Published var contentPlan = [ContentPlanData]()
    @Published var week_1 = [ContentPlanData]()
    @Published var week_2 = [ContentPlanData]()
    @Published var week_3 = [ContentPlanData]()
    @Published var week_4 = [ContentPlanData]()
    
    init() {
        self.fetchData()
    }
    
    func fetchData() {
        db.collection(contentPlanPath).addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.contentPlan.removeAll()
                self.week_1.removeAll()
                self.week_2.removeAll()
                self.week_3.removeAll()
                self.week_4.removeAll()
                for document in querySnapshot!.documents {
                    var newTask = ContentPlanData()
                    newTask.id = document.documentID
                    newTask.title = document["title"] as! String
                    newTask.description = document["descr"] as! String
                    newTask.createdDate = document["createdDate"] as! Timestamp
                    newTask.relatedData = document["relatedData"] as! String
                    newTask.week = document["week"] as! Int
                    newTask.isFinished = document["isFinished"] as! Int
                    newTask.localCrDate = newTask.createdDate.dateValue()
                    
                    switch newTask.week {
                    case 1:
                        self.week_1.append(newTask)
                    case 2:
                        self.week_2.append(newTask)
                    case 3:
                        self.week_3.append(newTask)
                    case 4:
                        self.week_4.append(newTask)
                    default:
                        self.contentPlan.append(newTask)
                    }
                }
                self.sortBy()
            }
        }
    }
    
    func sortBy() {
        contentPlan = contentPlan.sorted(by: {$0.localCrDate.compare($1.localCrDate) == .orderedDescending})
        week_1 = week_1.sorted(by: {$0.localCrDate.compare($1.localCrDate) == .orderedDescending})
        week_2 = week_2.sorted(by: {$0.localCrDate.compare($1.localCrDate) == .orderedDescending})
        week_3 = week_3.sorted(by: {$0.localCrDate.compare($1.localCrDate) == .orderedDescending})
        week_4 = week_4.sorted(by: {$0.localCrDate.compare($1.localCrDate) == .orderedDescending})
    }
}
