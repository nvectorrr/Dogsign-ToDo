//
//  Auth.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 02.04.2021.
//

import SwiftUI

struct Auth : View  {
    @StateObject var viewModel = UserDataModel()
    
    var body : some View {
        if viewModel.isAuth {
            WelcomeView()
        } else {
            VStack {
                Divider()
                Text("Please, wait a minute...")
                Divider()
            }
            .frame(width: 450, height: 350)
        }
    }
     
}

struct Auth_Previews : PreviewProvider {
    static var previews : some View {
        Auth()
    }
}
