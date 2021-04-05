//
//  ProjectsTab.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 30.03.2021.
//

import SwiftUI

struct ProjectsTab : View {
    @ObservedObject var projectsData = ProjectsDataModel()
    
    var body: some View {
        HStack {
            NavigationView {
                List (projectsData.projectsData) { project in
                    NavigationLink(destination: CurrentProject(proj_name: project.name)) {
                        Text(project.name)
                    }
                }
                .listStyle(SidebarListStyle())
            }
        }
        .onAppear() {
            self.projectsData.fetchData()
        }
    }
    
    func createNewProject() {}
}

/*
struct ProjectsTab_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsTab()
    }
}
 */
