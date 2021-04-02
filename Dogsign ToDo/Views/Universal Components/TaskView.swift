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
    var description : String
    var notifier : ActionNotifier
    @State var isChecked : Bool
    
    var body: some View {
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
                //Text("Assigned to: " + person)
                  //  .font(.system(size: 14))
                Text(description)
                    .font(.system(size: 14))
            }
            
            Button(action: editTaskController) {
                Image(systemName: "gearshape")
                    .resizable()
                    .frame(width: 15, height: 15)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.all, 15)
        .background(Color(NSColor.darkGray))
        .cornerRadius(18.0)
    }
    
    func checkboxController() {
        if isChecked == true {
            isChecked = false
        } else {
            isChecked = true
        }
        self.notifier.recievedNotificationFromCell(cellId: self.id)
    }
    
    func editTaskController() {
        self.notifier.recievedEditingNotificationFromCell(cellId: self.id)
    }
}

/*
struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(title: "lol", person: "Marina Sokolova", description: "lorem ipsum dorem alalald kurwa rot twou", isChecked: false)
    }
}
*/
