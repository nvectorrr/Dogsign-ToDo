//
//  TaskListTab.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 30.03.2021.
//

import SwiftUI

struct TaskListTab: View {
    @ObservedObject var globalTasksData = GlobalTasksDataModel()
    
    var body : some View {
        List (globalTasksData.globalTasks) { globalTask in
            TaskView(title: globalTask.title, person: "nil", description: globalTask.description, isChecked: globalTask.isFinished)
        }
        .onAppear() {
            self.globalTasksData.fetchData()
        }
    }
}



struct TaskListTab_Previews: PreviewProvider {
    static var previews: some View {
        TaskListTab()
    }
}
