//
//  TaskView.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 30.03.2021.
//

import SwiftUI

struct TaskView: View {
    var id : String
    var title : String
    var project : String
    var description : String
    var deadline : String
    var assignedUser : String
    var taskRelatedData : String
    var important : Int
    var localCrDate : Date
    var notifier : ActionNotifier
    var hideEditingMode : Bool
    
    @State var isChecked : Bool
    @State var showDetails = false
    
    var body: some View {
        VStack {
            HStack (spacing: 25) {
                Button(action: checkboxController) {
                    Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .buttonStyle(PlainButtonStyle())
                
                VStack (alignment: .leading) {
                    Text(title)
                        .font(.system(size: 20))
                    Text("Description: \(description)")
                        .font(.system(size: 14))
                    if showDetails {
                        Text("Deadline: \(deadline)")
                            .font(.system(size: 14))
                        Text("Assigned project: \(project)")
                            .font(.system(size: 14))
                        Text("Assigned user: \(defineUserViaLogin(log: assignedUser))")
                            .font(.system(size: 14))
                        Text("Related data: \(taskRelatedData)")
                            .font(.system(size: 14))
                        Link("Open Data", destination: urlProtocol(link: taskRelatedData))
                    }
                }
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(defineColor())
                    .frame(width: 5)
                
                if !hideEditingMode {
                    Button(action: editTaskController) {
                        Image(systemName: "gearshape")
                            .resizable()
                            .frame(width: 15, height: 15)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            
            if !showDetails {
                HStack {
                    Button(action: showDetailsAction) {
                        Image(systemName: "chevron.down")
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.vertical, 5)
            } else {
                HStack {
                    Button(action: showDetailsAction) {
                        Image(systemName: "chevron.up")
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.vertical, 5)
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.top, 15)
        .background(Color(NSColor.darkGray))
        .cornerRadius(18.0)
    }
    
    func showDetailsAction() {
        self.showDetails.toggle()
    }
    
    func urlProtocol(link: String) -> URL {
        if link.hasPrefix("https://") {
            return URL(string: link)!
        } else if link.hasPrefix("http://") {
            return URL(string: link)!
        } else {
            return URL(string: ("https://" + link))!
        }
    }
    
    func checkboxController() {
        if (currentUser.accessLevel < 2 || currentUser.login == assignedUser) {
            if isChecked == true {
                isChecked = false
            } else {
                isChecked = true
            }
            self.notifier.recievedNotificationFromCell(cellId: self.id)
        }
    }
    
    func editTaskController() {
        if (currentUser.accessLevel < 2 || currentUser.login == assignedUser) {
            self.notifier.recievedEditingNotificationFromCell(cellId: self.id)
        }
    }
    
    func defineColor() -> Color {
        switch important {
        case 0: return Color.gray
        case 1: return Color.green
        case 2: return Color.blue
        case 3: return Color.red
        default: return Color.white
        }
    }
}

/*
struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(title: "lol", person: "Marina Sokolova", description: "lorem ipsum dorem alalald kurwa rot twou", isChecked: false)
    }
}
*/
