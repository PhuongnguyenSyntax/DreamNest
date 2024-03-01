//
//  RegistrationView.swift
//  DreamNest
//
//  Created by Flama Henkel on 27.02.24.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Image("logo2")
                .resizable()
                .scaledToFit()
                .frame(width: .infinity, height: 180)
                .padding(.vertical, 32)
            
            VStack(spacing:24) {
                InputView(text: $email,
                          title: "Email Adresse",
                          placeholder: "Bitte geben Sie Ihre Email Adresse ein")
                .autocapitalization(.none)
                
                InputView(text: $fullname,
                          title: "Name",
                          placeholder: "Bitte geben Sie Ihren Name ein")
                InputView(text: $password,
                          title: "Passwort",
                          placeholder: "Bitte geben Sie Ihr Passwort ein",
                          isSecureField: true)
                InputView(text: $confirmPassword,
                          title: "Passwort wiederholen",
                          placeholder: "Bitte wiederholen Ihr Passwort",
                          isSecureField: true)
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button {
                print("Sign User up..")
            } label: {
                HStack {
                    Text("Reistrieren")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 40)
            }
            .background(Color(.dark))
            .cornerRadius(10)
            .padding(.top, 24)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Haben Sie bereits ein Konto?")
                    Text("Login")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
                .foregroundColor(.dark)
            }
        }
    }
}

#Preview {
    RegistrationView()
}
