//
//  CurrentProject.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 05.04.2021.
//

import SwiftUI

struct CurrentProject : View, ActionNotifier {
    let type = "current"
    @ObservedObject var projectTasks = CurrentProjectTaskDataModel()
    @State var newTask = ""
    @State var editingMode = false
    @State var taskForEditing = -1
    
    var proj_name : String
    
    var body : some View {
        if editingMode {
            
        } else {
            DropdownTaskCreator(notifier: self)
            List (projectTasks.currentProjectTasks) { globalTask in
                if (globalTask.project == proj_name) {
                    TaskView(id: globalTask.id, title: globalTask.title, project: globalTask.project, description: globalTask.description, deadline: globalTask.deadline, assignedUser: globalTask.assignedUser, taskRelatedData: globalTask.taskRelatedData, important: globalTask.important, localCrDate: globalTask.localCrDate, notifier: self, hideEditingMode: true, isChecked: intToBool(num: globalTask.isFinished))
                }
            }
            .onAppear {
                self.projectTasks.fetchData(project: proj_name)
            }
        }
    }
    
    func recievedNotificationFromCell(cellId: String) {}
    func recievedEditingNotificationFromCell(cellId: String) {}
    func reloadData() {}
}

/*
struct CurrentProject_Previews: PreviewProvider {
    static var previews: some View {
        CurrentProject()
    }
}
*/
