//
//  DropdownTaskCreator.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 31.03.2021.
//

import SwiftUI

struct DropdownTaskCreator : View {
    var title : String
    var option1 : String
    var option2 : String
    var option3 : String
    
    @State var expand = false
    @State var newTask = ""
    @State var newDescr = ""
    @State var newDeadline = ""
    
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
        db.collection("global_tasks").addDocument(data: ["title" : newTask, "descr" : newDescr, "deadline" : newDeadline, "isFinished" : false, "createdDate" : currDateToTimestamp()]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        self.newTask = ""
        self.expand.toggle()
    }
}

struct DropdownTaskCreator_Previews: PreviewProvider {
    static var previews: some View {
        DropdownTaskCreator(title: "Label", option1: "Red", option2: "Yellow", option3: "Green")
    }
}
