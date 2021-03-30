//
//  TaskView.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 30.03.2021.
//

import SwiftUI

struct TaskView: View {
    var title : String
    var person : String
    var description : String
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
                Text("Assigned to: " + person)
                    .font(.system(size: 14))
                Text(description)
                    .font(.system(size: 14))
            }
        }
        .padding(.all, 15)
    }
    
    func checkboxController() {
        if isChecked == true {
            isChecked = false
        } else {
            isChecked = true
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(title: "lol", person: "Marina Sokolova", description: "lorem ipsum dorem alalald kurwa rot twou", isChecked: false)
    }
}
