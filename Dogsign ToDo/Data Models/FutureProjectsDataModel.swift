//
//  FutureProjectsDataModel.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 12.04.2021.
//

import Foundation
import FirebaseFirestore

var futureProjData = [ProjectData]()

class FutureProjectsDataModel : ObservableObject {
   @Published var projectsData = [ProjectData]()
    
    init() {
        self.fetchData()
    }
    
    func fetchData() {
        db.collection(futureProjectsPath).addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.projectsData.removeAll()
                projData.removeAll()
                for document in querySnapshot!.documents {
                    var newProj = ProjectData()
                    newProj.id = document.documentID
                    newProj.name = document["name"] as! String
                    newProj.createdDate = document["createdDate"] as! Timestamp
                    newProj.localCrDate = newProj.createdDate.dateValue()
                    self.projectsData.append(newProj)
                    projData.append(newProj)
                }
            }
            self.sortByDate()
        }
    }
    
    func sortByDate() {
        projectsData = projectsData.sorted(by: {$0.localCrDate.compare($1.localCrDate) == .orderedDescending})
    }
}
