//
//  RoomItem.swift
//  DreamNest
//
//  Created by Flama Henkel on 01.03.24.
//

import Foundation

struct RoomItemList: Codable {
    let total_count: Int
    let results: [RoomItem]
}



struct RoomItem: Identifiable, Codable, Hashable {
        let id: String
        let listing_url: String?
        let name: String?
        let summary: String?
        let space: String?
        let description: String?
        let house_rules: String?
        let thumbnail_url: String?
        let xl_picture_url: String?
        let amenities: [String]?
        let price: Int?
        let latitude: String?
        let longitude: String?
        let street: String?
        let review_scores_rating: Int?
        
        
        //Host detail
        let host_name: String
        let host_since: String
        let host_picture_url: String
        let features: [String]?
    
}


