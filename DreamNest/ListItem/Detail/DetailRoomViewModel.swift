//
//  DetailRoomViewModel.swift
//  DreamNest
//
//  Created by Flama Henkel on 01.03.24.
//

import Foundation

class DetailRoomViewModel: ObservableObject {
    private let repository = CoreDataRoomRepository()
    
    public func addItemToFavoriteList(item: RoomItem) {
        repository.addFavoriteRoom(item)
    }
    
    public func checkItemExitInFavoriteList(id: String) -> Bool {
        if (repository.findRoomItemById(id) != nil) == true {
            return true
        } else {
            return false
        }
    }
    
    public func removeItemFromFavoriteList(id: String) {
        if let roomItem = repository.findRoomItemById(id) {
            repository.removeFavorite(roomItem)
        } else {
            print("Room item with ID \(id) not found in favorites.")
        }
    }
}
