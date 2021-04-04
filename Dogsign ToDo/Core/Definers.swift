//
//  Definers.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 04.04.2021.
//

func defineUserViaLogin(log: String) -> String {
    for i in 0 ..< usersData.count {
        if usersData[i].login == log {
            return usersData[i].name
        }
    }
    return "Undefined"
}
