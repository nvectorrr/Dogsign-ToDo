//
//  FutureProjectsTab.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 12.04.2021.
//

import SwiftUI

struct FutureProjectsTab : View {
    @ObservedObject var projectsData = FutureProjectsDataModel()
    @State var addProject = false
    @State var migratePrj = false
    @State var newProjName = ""
    @State var migrateTo = ""
    @State var projIdForRemove = ""
    
    var body: some View {
        HStack {
            NavigationView {
                VStack {
                    List (projectsData.projectsData) { project in
                        NavigationLink(destination: CurrentFutureProject(proj_name: project.name)) {
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
                    Button(action: appearMigrateSelector) {
                        if !migratePrj {
                            Text("Migrate project")
                        } else {
                            Label("Cancel", systemImage: "minus")
                        }
                    }
                    
                    if (migratePrj) {
                        VStack {
                            Menu {
                                ForEach(0 ..< projData.count) {i in
                                    Button (action: {migrateTo = projData[i].name}) {
                                        Text(projData[i].name)
                                    }
                                }
                            } label: {
                                Text("Project: \(migrateTo)")
                            }
                            Button(action: migrateProject) {
                                Text("Migrate")
                            }
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
        .onDisappear() {
            if projIdForRemove != "" {
                db.collection(futureProjectsPath).document(projIdForRemove).delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                    }
                }
            }
        }
    }
    
    func createNewProject() {
        self.addProject.toggle()
    }
    
    func appearMigrateSelector() {
        self.migratePrj.toggle()
    }
    
    func migrateProject() {
        let projForMigration = migrateTo
        FutureProjectTaskDataModel().fetchAndMigrate(project: projForMigration)
        
        db.collection(currentProjectsPath).addDocument(data: ["name" : projForMigration, "createdDate" : currDateToTimestamp()]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        for i in 0 ..< projData.count {
            if projData[i].name == projForMigration {
                projIdForRemove = projData[i].id
            }
        }
    }
    
    func postNewProj() {
        db.collection(futureProjectsPath).addDocument(data: ["name" : newProjName, "createdDate" : currDateToTimestamp()]) { err in
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
