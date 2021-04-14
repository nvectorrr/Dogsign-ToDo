//
//  ContentPlanView.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 12.04.2021.
//

import SwiftUI

struct ContentPlanView: View {
    @ObservedObject var contentPlan = ContentPlanDataModel()
    
    let week : Int
    
    var body: some View {
        VStack {
            DropdownContentPlanItemCreator()
            switch week {
            case 1:
                List (contentPlan.week_1) { item in
                    ContentPlanItem(id: item.id, title: item.title, description: item.description, deadline: item.deadline, relatedData: item.relatedData, week: item.week, isChecked: intToBool(num: item.isFinished))
                }
                .onAppear {
                    self.contentPlan.fetchData()
                }
            case 2:
                List (contentPlan.week_2) { item in
                    ContentPlanItem(id: item.id, title: item.title, description: item.description, deadline: item.deadline, relatedData: item.relatedData, week: item.week, isChecked: intToBool(num: item.isFinished))
                }
                .onAppear {
                    self.contentPlan.fetchData()
                }
            case 3:
                List (contentPlan.week_3) { item in
                    ContentPlanItem(id: item.id, title: item.title, description: item.description, deadline: item.deadline, relatedData: item.relatedData, week: item.week, isChecked: intToBool(num: item.isFinished))
                }
                .onAppear {
                    self.contentPlan.fetchData()
                }
            case 4:
                List (contentPlan.week_4) { item in
                    ContentPlanItem(id: item.id, title: item.title, description: item.description, deadline: item.deadline, relatedData: item.relatedData, week: item.week, isChecked: intToBool(num: item.isFinished))
                }
                .onAppear {
                    self.contentPlan.fetchData()
                }
            default:
                Text("Unknown error...")
            }
        }
    }
}

struct ContentPlanItem : View {
    var id : String
    var title : String
    var description : String
    var deadline : String
    var relatedData : String
    var week : Int
    
    @State var isChecked : Bool
    
    var body : some View {
            HStack {
                Button(action: checkboxController) {
                    Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .buttonStyle(PlainButtonStyle())
                
                VStack (alignment: .leading) {
                    Text(title)
                        .font(.system(size: 20))
                    Text("Deadline: \(deadline)")
                        .font(.system(size: 14))
                    Text("Description: \(description)")
                        .font(.system(size: 14))
                    Text("Related data: \(relatedData)")
                        .font(.system(size: 14))
                    if relatedData != "none" {
                        Link("Open related data", destination: urlProtocol(link: relatedData))
                    }
                }
                .padding(.horizontal, 20)
                
                Button(action: deleteContentPlanItem) {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 15, height: 15)
                }
                .buttonStyle(PlainButtonStyle())
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 15)
        .background(Color(NSColor.darkGray))
        .cornerRadius(18.0)
    }
    
    func checkboxController() {
        if isChecked == true {
            isChecked = false
        } else {
            isChecked = true
        }
        
        db.collection(contentPlanPath).document(id).updateData(["isFinished" : boolToInt(value: isChecked)])
    }
    
    func deleteContentPlanItem() {
        db.collection(contentPlanPath).document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}

struct DropdownContentPlanItemCreator : View {
    @State var expand = false
    @State var newTask = ""
    @State var newDescr = ""
    @State var newDeadline = ""
    @State var newRelatedData = "none"
    @State var newWeek = -1
    
    var body : some View {
        VStack(spacing: 10) {
            if expand {
                VStack {
                    HStack {
                        TextField("New task", text: $newTask)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: {
                                self.expand.toggle()
                                self.newTask = ""
                        }) {
                            Label("Cancel", systemImage: "minus")
                        }
                    }
                    
                    TextField("Deadline", text: $newDeadline)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Description", text: $newDescr)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Related data", text: $newRelatedData)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Menu {
                        Button(action: {newWeek = 1}) {
                            Text("Week 1")
                        }
                        Button(action: {newWeek = 2}) {
                            Text("Week 2")
                        }
                        Button(action: {newWeek = 3}) {
                            Text("Week 3")
                        }
                        Button(action: {newWeek = 4}) {
                            Text("Week 4")
                        }
                    } label: {
                        switch newWeek {
                        case 1: Text("Week: 1")
                        case 2: Text("Week: 2")
                        case 3: Text("Week: 3")
                        case 4: Text("Week: 4")
                        default: Text("Week: ")
                        }
                    }
                    
                    Button(action: addNewContentPlanItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            } else {
                HStack {
                    TextField("New task", text: $newTask)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {self.expand.toggle()}) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
        .padding(.horizontal, 10)
        .cornerRadius(15)
        .animation(.spring())
    }
    
    func addNewContentPlanItem() {
        db.collection(contentPlanPath).addDocument(data: ["title" : newTask, "descr" : newDescr, "deadline" : newDeadline, "isFinished" : 0, "createdDate" : currDateToTimestamp(), "relatedData" : newRelatedData, "week" : newWeek]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        self.newTask = ""
        self.newDescr = ""
        self.newDeadline = ""
        self.newRelatedData = "none"
        self.newWeek = -1
        self.expand.toggle()
    }
}
