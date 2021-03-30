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
