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
                    Text("User: \(globalUser)")
                        .font(.system(size: 14))
                    Spacer()
                    Button(action: reloadData) {
                        Label("", systemImage: "arrow.clockwise")
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 25)
                DropdownTaskCreator(notifier: self, title: "Label", option1: "Red", option2: "Yellow", option3: "Green")
                HStack {
                    List (globalTasksData.globalTasks) { globalTask in
                        TaskView(id: globalTask.id, title: globalTask.title, description: globalTask.description, notifier: self, isChecked: intToBool(num: globalTask.isFinished))
                    }
                    TaskEditorView(notifier: self, title: globalTasksData.globalTasks[taskForEditing].title, descr: globalTasksData.globalTasks[taskForEditing].description, deadline: globalTasksData.globalTasks[taskForEditing].deadline, stitle: globalTasksData.globalTasks[taskForEditing].title, sdescr: globalTasksData.globalTasks[taskForEditing].description, sdeadline: globalTasksData.globalTasks[taskForEditing].deadline)
                }
            }
        } else {
            VStack {
                HStack {
                    Text("User: \(globalUser)")
                        .font(.system(size: 14))
                    Spacer()
                    Button(action: reloadData) {
                        Label("", systemImage: "arrow.clockwise")
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 25)
                DropdownTaskCreator(notifier: self, title: "Label", option1: "Red", option2: "Yellow", option3: "Green")
                List (globalTasksData.globalTasks) { globalTask in
                    TaskView(id: globalTask.id, title: globalTask.title, description: globalTask.description, notifier: self, isChecked: intToBool(num: globalTask.isFinished))
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
        db.collection("tasks_feed").document(cellId).updateData(["isFinished": 1])
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
}



struct TaskListTab_Previews: PreviewProvider {
    static var previews: some View {
        TaskListTab()
    }
}
