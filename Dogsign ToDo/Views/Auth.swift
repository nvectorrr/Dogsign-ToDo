//
//  Auth.swift
//  Dogsign ToDo
//
//  Created by Виктор  Найденович  on 02.04.2021.
//

import SwiftUI

struct Auth : View  {
    @StateObject var viewModel = UserDataModel()
    @State var login = ""
    @State var pass = ""
    @State var uncorrectLabel = false
    
    var body : some View {
        if viewModel.isAuth == 1 {
            WelcomeView()
        } else if viewModel.isAuth == 2 {
            VStack {
                Divider()
                if uncorrectLabel {
                    Text("Uncorrect login or password!")
                }
                TextField("Login", text: $login)
                    .padding(.horizontal, 30)
                TextField("Password", text: $pass)
                    .padding(.horizontal, 30)
                Button(action: loginButtonAction) {
                    Text("Login")
                }
                .padding(.all, 10)
                Divider()
            }
            .frame(width: 450, height: 350)
        } else {
            VStack {
                Divider()
                Text("Please, wait a minute...")
                Divider()
            }
            .frame(width: 450, height: 350)
        }
    }
    
    func loginButtonAction() {
        if !viewModel.loginAction(login: login, pass: pass) {
            login = ""
            pass = ""
            uncorrectLabel = true
        }
    }
}

struct Auth_Previews : PreviewProvider {
    static var previews : some View {
        Auth()
    }
}
