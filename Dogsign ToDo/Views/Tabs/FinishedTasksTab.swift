//
//  FinishedTasksTab.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 05.04.2021.
//

import SwiftUI

struct FinishedTasksTab: View, ActionNotifier {
    let type = "none"
    @ObservedObject var globalTasksData = GlobalTasksDataModel()
    
    var body: some View {
        List (globalTasksData.finishedCurrentUserTasks) { globalTask in
            TaskView(id: globalTask.id, title: globalTask.title, project: globalTask.project, description: globalTask.description, deadline: globalTask.deadline, assignedUser: globalTask.assignedUser, taskRelatedData: globalTask.taskRelatedData, important: globalTask.important, localCrDate: globalTask.localCrDate, notifier: self, hideEditingMode: true, isChecked: intToBool(num: globalTask.isFinished))
        }
        .onAppear() {
            self.globalTasksData.fetchData()
        }
    }
    
    func recievedNotificationFromCell(cellId: String) {
        db.collection(tasksPath).document(cellId).updateData(["isFinished": 0])
        reloadData()
    }
    
    func recievedEditingNotificationFromCell(cellId: String) {}
    func reloadData() {}
}

struct FinishedTasksTab_Previews: PreviewProvider {
    static var previews: some View {
        FinishedTasksTab()
    }
}
