//
//  ProjectsTab.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 30.03.2021.
//

import SwiftUI

var testProjects = ["Proj1", "Proj2", "Proj3"]
var testTaskForProjList = ["task 1", "task 2", "task 3", "task  4", "task 4"]

struct ProjectsTab : View {
    var body: some View {
        HStack {
            NavigationView {
                List(testProjects, id: \.self) { proj in
                    NavigationLink(destination: CurrentProject(proj_name: proj)) {
                        Text(proj)
                    }
                }
                .listStyle(SidebarListStyle())
            }
        }
    }
    
    func createNewProject() {
        
    }
}

struct CurrentProject : View, ActionNotifier {
    
    func reloadData() {}
    func recievedNotificationFromCell(cellId: String) {}
    
    var proj_name : String
    
    var body : some View {
        List {
            Section(header: Text(proj_name).font(.system(size: 36))) {
                ForEach(0 ..< testTaskForProjList.count) {
                    TaskView(id: "otjebisb", title: testTaskForProjList[$0], description: "descr", notifier: self, isChecked: false)
                }
            }
        }
    }
}

struct ProjectsTab_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsTab()
    }
}
