//
//  ApiRoomRepository.swift
//  DreamNest
//
//  Created by Flama Henkel on 01.03.24.
//

import Foundation

class ApiRoomRepository {
   
    func searchRoom() async throws -> RoomItemList {
        guard let url = URL(string: "https://public.opendatasoft.com/api/explore/v2.1/catalog/datasets/airbnb-listings/records?limit=50&refine=city%3A%22New%20York%22&refine=room_type%3A%22Entire%20home%2Fapt%22") else {
            throw AppError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(RoomItemList.self, from: data)
    }
}
