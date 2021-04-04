//
//  DropdownTaskCreator.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 31.03.2021.
//

import SwiftUI

struct DropdownTaskCreator : View {
    var notifier : ActionNotifier
    
    @State var expand = false
    @State var newTask = ""
    @State var newDescr = ""
    @State var newDeadline = ""
    @State var newAssignedProj = ""
    @State var newAssignedTo = ""
    @State var newAssignedToName = ""
    @State var newImportant = -1
    
    var body: some View {
        VStack(spacing: 10) {
            if expand {
                VStack {
                    HStack {
                        TextField("New task", text: $newTask)
                        Button(action: {
                                self.expand.toggle()
                                self.newTask = ""
                        }) {
                            Label("Cancel", systemImage: "minus")
                        }
                    }
                    
                    TextField("Description", text: $newDescr)
                    TextField("Deadline", text: $newDeadline)
                    TextField("Assigned project", text: $newAssignedProj)
                    
                    Menu {
                        ForEach(0 ..< usersData.count) {i in
                            Button (action: {newAssignedTo = usersData[i].login; newAssignedToName = usersData[i].name}) {
                                Text(usersData[i].name)
                            }
                        }
                    } label: {
                        Text("Assigned user: \(newAssignedToName)")
                    }
                    
                    Menu {
                        Button(action: {newImportant = 3}) {
                            Text("Red")
                        }
                        Button(action: {newImportant = 2}) {
                            Text("Blue")
                        }
                        Button(action: {newImportant = 1}) {
                            Text("Green")
                        }
                        Button(action: {newImportant = 0}) {
                            Text("Gray")
                        }
                    } label: {
                        switch newImportant {
                        case 0: Text("Priority: Gray")
                        case 1: Text("Priority: Green")
                        case 2: Text("Priority: Blue")
                        case 3: Text("Priority: Red")
                        default: Text("Priority: Not selected")
                        }
                    }
                    
                    Button(action: addNewGlobalTask) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            } else {
                HStack {
                    TextField("New task", text: $newTask)
                    Button(action: {self.expand.toggle()}) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
        .padding(10)
        .cornerRadius(15)
        .animation(.spring())
    }
    
    func addNewGlobalTask() {
        db.collection(tasksPath).addDocument(data: ["title" : newTask, "descr" : newDescr, "deadline" : newDeadline, "isFinished" : 0, "createdDate" : currDateToTimestamp(), "assigned_user" : newAssignedTo, "taskRelatedData" : "none", "assigned_project" : newAssignedProj, "important" : newImportant]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        self.newTask = ""
        self.newDescr = ""
        self.newDeadline = ""
        self.newAssignedProj = ""
        self.newAssignedTo = ""
        self.newAssignedToName = ""
        self.newImportant = -1
        self.expand.toggle()
        self.notifier.reloadData()
    }
}

/*
struct DropdownTaskCreator_Previews: PreviewProvider {
    static var previews: some View {
        DropdownTaskCreator(notifier: self, title: "Label", option1: "Red", option2: "Yellow", option3: "Green")
    }
}
 */
