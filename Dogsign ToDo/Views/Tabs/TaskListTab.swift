//
//  TaskListTab.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 30.03.2021.
//

import SwiftUI

struct TaskListTab: View {
    @ObservedObject var globalTasksData = GlobalTasksDataModel()
    
    @State var newTask = ""
    
    var body : some View {
        VStack {
            DropdownTaskCreator(title: "Label", option1: "Red", option2: "Yellow", option3: "Green")
            
            List (globalTasksData.globalTasks) { globalTask in
                TaskView(title: globalTask.title, person: "nil", description: globalTask.description, isChecked: globalTask.isFinished)
            }
            .onAppear() {
                self.globalTasksData.fetchData()
            }
        }
    }
    
    func addNewGlobalTask() {
        print("field input: " + newTask)
    }
}



struct TaskListTab_Previews: PreviewProvider {
    static var previews: some View {
        TaskListTab()
    }
}
