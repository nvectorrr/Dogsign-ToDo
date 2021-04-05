//
//  TaskListTab.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 30.03.2021.
//

import SwiftUI

protocol ActionNotifier {
    func recievedNotificationFromCell(cellId: String)
    func recievedEditingNotificationFromCell(cellId: String)
    func reloadData()
}

protocol EditorNotifier {
    func closeEditor()
    var globalTasksData : GlobalTasksDataModel { get set }
    var taskForEditing : Int { get }
}

struct TaskListTab: View, ActionNotifier, EditorNotifier {
    @ObservedObject var globalTasksData = GlobalTasksDataModel()
    @ObservedObject var projectsData = ProjectsDataModel()
    @State var newTask = ""
    @State var editingMode = false
    @State var taskForEditing = -1
    
    var body : some View {
        if editingMode {
            VStack {
                HStack {
                    Text("User: \(currentUser.name)")
                        .font(.system(size: 14))
                    Spacer()
                    Button(action: reloadData) {
                        Label("", systemImage: "arrow.clockwise")
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 25)
                DropdownTaskCreator(notifier: self)
                HStack {
                    List (globalTasksData.currentUserTasks) { globalTask in
                        TaskView(id: globalTask.id, title: globalTask.title, project: globalTask.project, description: globalTask.description, deadline: globalTask.deadline, assignedUser: globalTask.assignedUser, taskRelatedData: globalTask.taskRelatedData, important: globalTask.important, localCrDate: globalTask.localCrDate, notifier: self, hideEditingMode: false, isChecked: intToBool(num: globalTask.isFinished))
                    }
                    TaskEditorView(notifier: self, title: globalTasksData.currentUserTasks[taskForEditing].title, project: globalTasksData.currentUserTasks[taskForEditing].project, description: globalTasksData.currentUserTasks[taskForEditing].description, deadline: globalTasksData.currentUserTasks[taskForEditing].deadline, assignedUser: globalTasksData.currentUserTasks[taskForEditing].assignedUser, assignedProject: globalTasksData.currentUserTasks[taskForEditing].project, taskRelatedData: globalTasksData.currentUserTasks[taskForEditing].taskRelatedData, important: globalTasksData.currentUserTasks[taskForEditing].important, stitle: globalTasksData.currentUserTasks[taskForEditing].title, sproject: globalTasksData.currentUserTasks[taskForEditing].project, sdescr: globalTasksData.currentUserTasks[taskForEditing].description, sdeadline: globalTasksData.currentUserTasks[taskForEditing].deadline, sassignedUser: globalTasksData.currentUserTasks[taskForEditing].assignedUser, sassignedUserName: defineUserNameViaLogin(log: globalTasksData.currentUserTasks[taskForEditing].assignedUser), sassignedProject: globalTasksData.currentUserTasks[taskForEditing].project, stackRelatedData: globalTasksData.currentUserTasks[taskForEditing].taskRelatedData, simportant: globalTasksData.currentUserTasks[taskForEditing].important)
                }
            }
        } else {
            VStack {
                HStack {
                    Text("User: \(currentUser.name)")
                        .font(.system(size: 14))
                    Spacer()
                    Button(action: reloadData) {
                        Label("", systemImage: "arrow.clockwise")
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 25)
                DropdownTaskCreator(notifier: self)
                List (globalTasksData.currentUserTasks) { globalTask in
                    TaskView(id: globalTask.id, title: globalTask.title, project: globalTask.project, description: globalTask.description, deadline: globalTask.deadline, assignedUser: globalTask.assignedUser, taskRelatedData: globalTask.taskRelatedData, important: globalTask.important, localCrDate: globalTask.localCrDate, notifier: self, hideEditingMode: false, isChecked: intToBool(num: globalTask.isFinished))
                }
                .onAppear() {
                    self.globalTasksData.fetchData()
                }
            }
        }
    }
    
    func recievedNotificationFromCell(cellId: String) {
        db.collection(tasksPath).document(cellId).updateData(["isFinished": 1])
        reloadData()
    }
    
    func reloadData() {
        self.globalTasksData.fetchData()
    }
    
    func recievedEditingNotificationFromCell(cellId: String) {
        var index = 0
        while(index < globalTasksData.currentUserTasks.count) {
            if(globalTasksData.currentUserTasks[index].id == cellId) {
                taskForEditing = index
                break
            } else {
                index += 1
            }
        }
        self.editingMode.toggle()
    }
    
    func closeEditor() {
        taskForEditing = -1
        self.editingMode.toggle()
    }
    
    func defineUserNameViaLogin(log: String) -> String {
        for i in 0 ..< usersData.count {
            if(log == usersData[i].login) {
                return usersData[i].name
            }
        }
        return "Undefined"
    }
}



struct TaskListTab_Previews: PreviewProvider {
    static var previews: some View {
        TaskListTab()
    }
}
