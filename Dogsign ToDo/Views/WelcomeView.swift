//
//  WelcomeView.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 30.03.2021.
//

import SwiftUI

struct WelcomeView : View {
    private let tabs = ["Task List", "Projects", "Future Projects", "Content Plan", "Calendar"]
    @State private var selectedTab = 0
    var body : some View {
        /*TabView {
            TaskListTab()
                .tabItem { Label("Task List", systemImage: "list.dash") }
            ProjectsTab()
                .tabItem { Label("Projects", systemImage: "list.dash") }
        }
        .tabViewStyle(DefaultTabViewStyle())*/
        VStack {
            HStack {
                Spacer()
                Picker("", selection: $selectedTab) {
                    ForEach(tabs.indices) { i in
                        Text(self.tabs[i]).tag(i)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.top, 8)
                Spacer()
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
                .padding(.top, 8)
            }
            .padding(.horizontal, 100)
            Divider()
            GeometryReader { gp in
                VStack {
                    DefineChildView(title: self.tabs[self.selectedTab], index: self.selectedTab)
                }
            }
        }
    }
    
    func addItem() {
        
    }
}

struct DefineChildView : View {
    var title : String
    var index : Int
    
    var body : some View {
        switch title {
        case "Task List":
            TaskListTab()
        case "Projects":
            ProjectsTab()
        default:
            ErrorTab()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
