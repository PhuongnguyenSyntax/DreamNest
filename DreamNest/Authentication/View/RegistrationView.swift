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
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Image("logo2")
                .resizable()
                .scaledToFit()
                .padding(.vertical, 32)
            
            VStack(spacing:24) {
                InputView(text: $email,
                          title: "Email Address",
                          placeholder: "Please enter your email address")
                .autocapitalization(.none)
                
                InputView(text: $fullname,
                          title: "Name",
                          placeholder: "Please enter your name")
                InputView(text: $password,
                          title: "Password",
                          placeholder: "Please enter your password",
                          isSecureField: true)
                HStack {
                    InputView(text: $confirmPassword,
                              title: "Confirm Password",
                              placeholder: "Please confirm your password",
                              isSecureField: true)
                    Spacer()
                    if  !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                        } else {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button {
                Task {
                    try await viewModel.createUser(withEmail: email,
                                                    password: password,
                                                    fullname: fullname)
                }
            } label: {
                HStack {
                    Text("Sign up")
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
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an Account?")
                    Text("Login")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
                .foregroundColor(.dark)
            }
        }
    }
}

// MARK: - AuthenticationFormProtocol

extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 6
        && confirmPassword == password
        && !fullname.isEmpty

    }
}

#Preview {
    RegistrationView()
}

