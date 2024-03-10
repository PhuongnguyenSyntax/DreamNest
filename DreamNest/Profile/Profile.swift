//
//  Profile.swift
//  DreamNest
//
//  Created by Flama Henkel on 27.02.24.
//

import SwiftUI
import FirebaseFirestore

struct Profile: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            if let user = viewModel.currentUser {
                List {
                    Section {
                        HStack {
                            Text(user.initials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 70, height: 70)
                                .background(Color(.systemGray3))
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            VStack(alignment: .leading, spacing: 5) {
                                Text(user.fullname)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.top, 4)
                                Text(user.email)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    Section("Rückblick"){
                        NavigationLink(destination: MyBookingsView()) {
                            SettingRowView(imageName: "globe.asia.australia",
                                           title: "My Booking",
                                           tintColor: Color(.dark))
                        }
                        
                    }
                    Section("Gutschein"){
                        SettingRowView(imageName: "giftcard",
                                       title: "Voucher",
                                       tintColor: Color(.dark))
                    }
                    Section("Konto") {
                        Button {
                            viewModel.signOut()
                        } label: {
                            SettingRowView(imageName: "arrow.left.circle.fill",
                                           title: "Log out",
                                           tintColor: .dark)
                        }
                        Button {
                            viewModel.deleteAccount()
                        } label: {
                            SettingRowView(imageName: "xmark.circle.fill",
                                           title: "Delete Account",
                                           tintColor: .red)
                        }
                    }
                }
                .navigationTitle("Profile")
            }
        }
    }
}

#Preview {
    Profile()
        .environmentObject(AuthViewModel())
}

