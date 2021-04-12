//
//  URLs.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 12.04.2021.
//

import Foundation

func urlProtocol(link: String) -> URL {
    if link.hasPrefix("https://") {
        return URL(string: link)!
    } else if link.hasPrefix("http://") {
        return URL(string: link)!
    } else {
        return URL(string: ("https://" + link))!
    }
}
