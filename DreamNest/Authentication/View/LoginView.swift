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
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("logo1")
                    .resizable()
                    .padding(.vertical, 32)
                VStack(spacing: 24) {
                    InputView(text: $email,
                              title: "Email Address",
                              placeholder: "Please enter your Email address",
                              isSecureField: false)
                    .autocapitalization(.none)
                    
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Please enter your Password",
                              isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                HStack {
                    Spacer()
                    Button {
                        // action
                    } label: {
                        Text("Forgot password ?")
                            .foregroundColor(.dark)
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .padding(.trailing)
                    .padding(.vertical)
                }
                
                Button {
                    Task {
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("Login")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: 360, height: 40)
                    
                }
                .background(Color(.dark))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
                .padding(.bottom, 40)
                
                BottomView(googleAction: {}, facebookAction: {}, appleAction: {})
                
                Spacer()
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack {
                        Text("Don't have an account yet?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                    .foregroundColor(.dark)
                }
            }
        }
    }
}

// MARK: - AuthenticationFormProtocol

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 6
    }
}

#Preview {
    LoginView()
}

