//
//  TaskListTab.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 30.03.2021.
//

import SwiftUI

protocol ActionNotifier {
    func recievedNotificationFromCell(cellId: String)
    func reloadData()
}

struct TaskListTab: View, ActionNotifier {
    @ObservedObject var globalTasksData = GlobalTasksDataModel()
    @State var newTask = ""
    
    var body : some View {
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
    
    func forceRefreshButtonAction() {
        
    }
}



struct TaskListTab_Previews: PreviewProvider {
    static var previews: some View {
        TaskListTab()
    }
}
