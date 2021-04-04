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
                    List (globalTasksData.globalTasks) { globalTask in
                        TaskView(id: globalTask.id, title: globalTask.title, project: globalTask.project, description: globalTask.description, deadline: globalTask.deadline, assignedUser: globalTask.assignedUser, taskRelatedData: globalTask.taskRelatedData, important: globalTask.important, localCrDate: globalTask.localCrDate, notifier: self, isChecked: intToBool(num: globalTask.isFinished))
                    }
                    TaskEditorView(notifier: self, title: globalTasksData.globalTasks[taskForEditing].title, project: globalTasksData.globalTasks[taskForEditing].project, description: globalTasksData.globalTasks[taskForEditing].description, deadline: globalTasksData.globalTasks[taskForEditing].deadline, assignedUser: globalTasksData.globalTasks[taskForEditing].assignedUser, taskRelatedData: globalTasksData.globalTasks[taskForEditing].taskRelatedData, important: globalTasksData.globalTasks[taskForEditing].important, stitle: globalTasksData.globalTasks[taskForEditing].title, sproject: globalTasksData.globalTasks[taskForEditing].project, sdescr: globalTasksData.globalTasks[taskForEditing].description, sdeadline: globalTasksData.globalTasks[taskForEditing].deadline, sassignedUser: globalTasksData.globalTasks[taskForEditing].assignedUser, sassignedUserName: defineUserNameViaLogin(log: globalTasksData.globalTasks[taskForEditing].assignedUser), stackRelatedData: globalTasksData.globalTasks[taskForEditing].taskRelatedData, simportant: globalTasksData.globalTasks[taskForEditing].important)
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
                List (globalTasksData.globalTasks) { globalTask in
                    TaskView(id: globalTask.id, title: globalTask.title, project: globalTask.project, description: globalTask.description, deadline: globalTask.deadline, assignedUser: globalTask.assignedUser, taskRelatedData: globalTask.taskRelatedData, important: globalTask.important, localCrDate: globalTask.localCrDate, notifier: self, isChecked: intToBool(num: globalTask.isFinished))
                }
                .onAppear() {
                    self.globalTasksData.fetchData()
                }
            }
        }
    }
    
    func intToBool(num : Int) -> Bool {
        if num == 0 {
            return false
        } else {
            return true
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
        while(index < globalTasksData.globalTasks.count) {
            if(globalTasksData.globalTasks[index].id == cellId) {
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
