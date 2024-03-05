//
//  ContentView.swift
//  DreamNest
//
//  Created by Flama Henkel on 26.02.24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }

            ListRoomView()
                .tabItem {
                Image(systemName: "list.bullet")
                Text("List")
            }

            FavoriteListView()
                .tabItem {
                Image(systemName: "heart.fill")
                Text("Favorite")
            }

            Profile()
                .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
        }
        .accentColor(.dark)
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
