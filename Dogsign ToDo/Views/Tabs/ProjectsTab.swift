//
//  ProjectsTab.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 30.03.2021.
//

import SwiftUI

var testProjects = ["Proj1", "Proj2", "Proj3"]

struct ProjectsTab : View {
    var body: some View {
        NavigationView {
            List(testProjects, id: \.self) { proj in
                NavigationLink(destination: CurrentProject()) {
                    Text(proj)
                }
            }
        }
    }
}

struct CurrentProject : View {
    var body : some View {
        Text("curr proj")
    }
}

struct ProjectsTab_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsTab()
    }
}
