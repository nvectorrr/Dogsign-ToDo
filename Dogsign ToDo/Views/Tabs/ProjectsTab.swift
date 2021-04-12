//
//  ProjectsTab.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 30.03.2021.
//

import SwiftUI

struct ProjectsTab : View {
    @ObservedObject var projectsData = ProjectsDataModel()
    @State var addProject = false
    @State var newProjName = ""
    
    var body: some View {
        HStack {
            NavigationView {
                VStack {
                    List (projectsData.projectsData) { project in
                        NavigationLink(destination: CurrentProject(proj_name: project.name)) {
                            Text(project.name)
                        }
                    }
                    .listStyle(SidebarListStyle())
                    Divider()
                    Button(action: createNewProject) {
                        if !addProject {
                            Label("New project", systemImage: "plus")
                        } else {
                            Label("Cancel", systemImage: "minus")
                        }
                    }
                    if (addProject) {
                        VStack {
                            TextField("New project", text:$newProjName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Button(action: postNewProj) {
                                Text("Add")
                            }
                        }
                    }
                }
                .padding(.vertical, 10)
            }
        }
        .onAppear() {
            self.projectsData.fetchData()
        }
    }
    
    func createNewProject() {
        self.addProject.toggle()
    }
    
    func postNewProj() {
        db.collection(currentProjectsPath).addDocument(data: ["name" : newProjName, "createdDate" : currDateToTimestamp()]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        self.newProjName = ""
        self.addProject.toggle()
    }
}

/*
struct ProjectsTab_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsTab()
    }
}
 */
