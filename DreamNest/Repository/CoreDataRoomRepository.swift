//
//  CoreDataRoomRepository.swift
//  DreamNest
//
//  Created by Flama Henkel on 05.03.24.
//

import Foundation
import CoreData

class CoreDataRoomRepository {
    
    func addFavoriteRoom(_ room: RoomItem) {
        let favorite = FavoriteRoomItem(context: PersistentStore.shared.context)
        favorite.id = room.id
        favorite.name = room.name
        favorite.price = Int32(room.price ?? 0)
        favorite.thumbnail_url = room.thumbnail_url
        favorite.street = room.street
        favorite.review_scores_rating = Int32(room.review_scores_rating ?? 0)
        
        PersistentStore.shared.saveChanges()
    }
    
    func removeFavorite(_ room: RoomItem) {
        let fetchRequest = FavoriteRoomItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", room.id)
        do {
            let results = try PersistentStore.shared.context.fetch(fetchRequest)
            for result in results {
                PersistentStore.shared.context.delete(result)
            }
            PersistentStore.shared.saveChanges()
        } catch {
            print(error)
        }
    }
    
    
    func fetchFavoriteRooms() -> [RoomItem] {
        let fetchRequest: NSFetchRequest<FavoriteRoomItem> = FavoriteRoomItem.fetchRequest()
        do {
            let fetchedResults = try PersistentStore.shared.context.fetch(fetchRequest)
            let roomItems = fetchedResults.compactMap { (favoriteItem) -> RoomItem? in
                guard let id = favoriteItem.id,
                      let name = favoriteItem.name,
                      let thumbnailURL = favoriteItem.thumbnail_url else {
                    return nil
                }
                return RoomItem(
                    id: id,
                    listing_url: nil,
                    name: name,
                    summary: nil,
                    space: nil,
                    description: nil,
                    house_rules: nil,
                    thumbnail_url: thumbnailURL,
                    xl_picture_url: nil,
                    amenities: nil,
                    price: Int(favoriteItem.price),
                    latitude: nil,
                    longitude: nil,
                    street: favoriteItem.street,
                    review_scores_rating: Int(favoriteItem.review_scores_rating),
                    host_name: "",
                    host_since: "",
                    host_picture_url: "",
                    features: nil
                )
            }
            return roomItems
        } catch {
            print("Error fetching favorite rooms: \(error)")
            return []
        }
    }
    
    
    func findRoomItemById(_ id: String) -> RoomItem? {
        let fetchRequest: NSFetchRequest<FavoriteRoomItem> = FavoriteRoomItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        
        do {
            let fetchedResults = try PersistentStore.shared.context.fetch(fetchRequest)
            if let favoriteItem = fetchedResults.first {
                // Assuming the rest of the properties are optional or have default values
                return RoomItem(
                    id: favoriteItem.id ?? "",
                    listing_url: nil,
                    name: favoriteItem.name,
                    summary: nil,
                    space: nil,
                    description: nil,
                    house_rules: nil,
                    thumbnail_url: favoriteItem.thumbnail_url,
                    xl_picture_url: nil,
                    amenities: nil,
                    price: favoriteItem.price != 0 ? Int(favoriteItem.price) : nil,
                    latitude: nil,
                    longitude: nil,
                    street: favoriteItem.street,
                    review_scores_rating: favoriteItem.review_scores_rating != 0 ? Int(favoriteItem.review_scores_rating) : nil,
                    host_name: "",
                    host_since: "",
                    host_picture_url: "",
                    features: nil
                )
            } else {
                // No matching item found
                return nil
            }
        } catch {
            print("Error fetching room with id \(id): \(error)")
            return nil
        }
    }
}
