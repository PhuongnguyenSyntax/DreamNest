//
//  FavoriteListViewModel.swift
//  DreamNest
//
//  Created by Flama Henkel on 05.03.24.
//

import Foundation
class FavoriteListViewModel: ObservableObject {
    
    @Published var favoriteRooms: [RoomItem] = []
    private var repository = CoreDataRoomRepository()
    
    init() {
     fetchFavorites()
    }   
    func fetchFavorites() {
        favoriteRooms = repository.fetchFavoriteRooms()
    }
    func removeFavorite(_ room: RoomItem) {
        repository.removeFavorite(room)
        fetchFavorites()
    }
}
