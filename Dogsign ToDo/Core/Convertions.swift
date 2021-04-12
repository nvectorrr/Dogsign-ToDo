//
//  Convertions.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 31.03.2021.
//

import Foundation
import FirebaseFirestore

func currDateToTimestamp() -> Timestamp {
    var currTimestamp = FirebaseFirestore.Timestamp.init(date: Date())
    return currTimestamp
}

func intToBool(num : Int) -> Bool {
    if num == 0 {
        return false
    } else {
        return true
    }
}

func boolToInt(value: Bool) -> Int {
    if value == false {
        return 0
    } else {
        return 1
    }
}
