//
//  DreamNestApp.swift
//  DreamNest
//
//  Created by Flama Henkel on 26.02.24.
//

import SwiftUI
import Firebase


@main
struct DreamNestApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            if viewModel.userSession != nil {
                ContentView()
                    .environmentObject(viewModel)
            } else {
                LoginView()
                    .environmentObject(viewModel)
            }
                         
        }
    }
}
