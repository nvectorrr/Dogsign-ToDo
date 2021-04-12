//
//  ContentPlanTab.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 12.04.2021.
//

import SwiftUI

struct ContentPlanTab : View {
    var body: some View {
        HStack {
            NavigationView {
                VStack {
                    List {
                        NavigationLink(destination: ContentPlanView(week: 1)) {
                            Text("Week 1")
                        }
                        NavigationLink(destination: ContentPlanView(week: 2)) {
                            Text("Week 2")
                        }
                        NavigationLink(destination: ContentPlanView(week: 3)) {
                            Text("Week 3")
                        }
                        NavigationLink(destination: ContentPlanView(week: 4)) {
                            Text("Week 4")
                        }
                    }
                    .listStyle(SidebarListStyle())
                }
                .padding(.vertical, 10)
            }
        }
        .onAppear() {

        }
    }
}
