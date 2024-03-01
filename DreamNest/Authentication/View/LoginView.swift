//
//  LoginView.swift
//  DreamNest
//
//  Created by Flama Henkel on 26.02.24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("logo1")
                    .resizable()
                    .frame(width: .infinity, height: 180)
                    .padding(.vertical, 32)
                VStack(spacing: 24) {
                    InputView(text: $email,
                              title: "Email Adresse",
                              placeholder: "Bitte geben Sie Ihre Email Adresse ein",
                              isSecureField: false)
                    .autocapitalization(.none)
                    
                    InputView(text: $password,
                              title: "Passwort",
                              placeholder: "Bitte geben Sie Ihre Passwort ein",
                              isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                HStack {
                    Spacer()
                    Button {
                        // action
                    } label: {
                        Text("Passwort vergessen?")
                            .foregroundColor(.dark)
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .padding(.trailing)
                    .padding(.vertical)
                }
                
                Button {
                    print("Log User in..")
                } label: {
                    HStack {
                        Text("Einloggen")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 40)
                    
                }
                .background(Color(.dark))
                .cornerRadius(10)
                .padding(.top, 24)
                
                Text("Oder weiter mit")
                    .foregroundColor(.dark)
                    .font(.system(size: 14, weight: .semibold))
                    .padding(.top, 14)
                
                BottomView(googleAction: {}, facebookAction: {}, appleAction: {})
                
                Spacer()
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack {
                        Text("Haben Sie noch kein Konto?")
                        Text("Registrieren")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                    .foregroundColor(.dark)
                }
            }
        }
    }
}

#Preview {
    LoginView()
}

