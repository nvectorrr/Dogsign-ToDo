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
    var descr : String
    var deadline : String

    @State var stitle = ""
    @State var sdescr = ""
    @State var sdeadline = ""
    
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
            TextField("\(descr)", text: $sdescr)
            TextField("\(deadline)", text: $sdeadline)
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
    
    func applyChanges() {
        if(title != stitle) {
            db.collection("tasks_feed").document(self.notifier.globalTasksData.globalTasks[self.notifier.taskForEditing].id).updateData(["title": stitle])
        }
        if(descr != sdescr) {
            db.collection("tasks_feed").document(self.notifier.globalTasksData.globalTasks[self.notifier.taskForEditing].id).updateData(["descr": sdescr])
        }
        if(deadline != sdeadline) {
            db.collection("tasks_feed").document(self.notifier.globalTasksData.globalTasks[self.notifier.taskForEditing].id).updateData(["deadline": sdeadline])
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
