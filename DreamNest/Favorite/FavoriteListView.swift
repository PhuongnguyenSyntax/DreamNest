//
//  FavoriteListView.swift
//  DreamNest
//
//  Created by Flama Henkel on 27.02.24.
//

import SwiftUI

struct FavoriteListView: View {
    
    @ObservedObject var viewModel = FavoriteListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.favoriteRooms.isEmpty {
                    Text("You haven't saved any favorite Item yet. Please save your favorite Item.")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.blue)
                        .padding()
                        .multilineTextAlignment(.center)
                    Spacer()
                    
                } else {
                    List(viewModel.favoriteRooms) { room in
                        NavigationLink(destination: DetailRoomView(room: room, viewModel: DetailRoomViewModel())) {
                            RoomCartView(roomModel: room)
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
        }
      
        .onAppear{
            viewModel.fetchFavorites()
        }
    }
}

#Preview {
    FavoriteListView()
}

