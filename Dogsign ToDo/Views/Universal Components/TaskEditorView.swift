//
//  TaskEditorView.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 01.04.2021.
//

import SwiftUI

struct TaskEditorView: View {
    var notifier : EditorNotifier
    var title : String
    var project : String
    var description : String
    var deadline : String
    var assignedUser : String
    var taskRelatedData : String
    var important : Int

    @State var stitle = ""
    @State var sproject = ""
    @State var sdescr = ""
    @State var sdeadline = ""
    @State var sassignedUser = ""
    @State var sassignedUserName = ""
    @State var stackRelatedData = ""
    @State var simportant = -1
    
    var body: some View {
        VStack {
            HStack {
                Text("Edit task")
                Spacer()
                Button(action: closeEditor) {
                    Image(systemName: "xmark")
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal, 15)
            
            TextField("\(title)", text: $stitle)
            TextField("\(description)", text: $sdescr)
            TextField("\(deadline)", text: $sdeadline)
            
            Menu {
                ForEach(0 ..< usersData.count) {i in
                    Button (action: {sassignedUser = usersData[i].login; sassignedUserName = usersData[i].name}) {
                        Text(usersData[i].name)
                    }
                }
            } label: {
                Text("Assigned user: \(sassignedUserName)")
            }
            
            Menu {
                Button(action: {simportant = 3}) {
                    Text("Red")
                }
                Button(action: {simportant = 2}) {
                    Text("Blue")
                }
                Button(action: {simportant = 1}) {
                    Text("Green")
                }
                Button(action: {simportant = 0}) {
                    Text("Gray")
                }
            } label: {
                switch simportant {
                case 0: Text("Priority: Gray")
                case 1: Text("Priority: Green")
                case 2: Text("Priority: Blue")
                case 3: Text("Priority: Red")
                default: Text("Priority: Not selected")
                }
            }
            
            HStack {
                Spacer()
                Button(action: applyChanges) {
                    Text("Apply")
                }
                Spacer()
            }
            Spacer()
        }
        .frame(width: 200)
        .padding(.horizontal, 10)
    }
    
    func buttonAct() {}
    
    func applyChanges() {
        if(title != stitle) {
            db.collection("tasks_feed").document(self.notifier.globalTasksData.globalTasks[self.notifier.taskForEditing].id).updateData(["title": stitle])
        }
        if(description != sdescr) {
            db.collection("tasks_feed").document(self.notifier.globalTasksData.globalTasks[self.notifier.taskForEditing].id).updateData(["descr": sdescr])
        }
        if(deadline != sdeadline) {
            db.collection("tasks_feed").document(self.notifier.globalTasksData.globalTasks[self.notifier.taskForEditing].id).updateData(["deadline": sdeadline])
        }
        if(assignedUser != sassignedUser) {
            db.collection("tasks_feed").document(self.notifier.globalTasksData.globalTasks[self.notifier.taskForEditing].id).updateData(["assigned_user": sassignedUser])
        }
        if(important != simportant) {
            db.collection("tasks_feed").document(self.notifier.globalTasksData.globalTasks[self.notifier.taskForEditing].id).updateData(["important": simportant])
        }
        closeEditor()
    }
    
    func closeEditor() {
        self.notifier.closeEditor()
    }
}

/*
struct TaskEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditorView()
    }
}
*/
