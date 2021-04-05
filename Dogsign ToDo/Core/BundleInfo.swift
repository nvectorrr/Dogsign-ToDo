//
//  BundleInfo.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 05.04.2021.
//

import Foundation

class Bundle {
    var bundleId = 0
    var minimumBundleId : Int!
    
    init() {
        self.checkBundle()
    }
    
    func checkBundle() {
        db.collection(requirementsPath).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.minimumBundleId = document["minimum_bundle_id"] as! Int
                }
            }
            if !(self.minimumBundleId < self.bundleId || self.minimumBundleId == self.bundleId) {
                exit(-2)
            }
        }
    }
}
