//
//  HomeViewModel.swift
//  DreamNest
//
//  Created by Flama Henkel on 05.03.24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var recommendedRooms: [RoomItem] = []
    private let apiRoomRepository = ApiRoomRepository()

    @MainActor
    func loadRecommendedRooms() {
        Task {
            do {
                let roomList = try await apiRoomRepository.searchRoom()
                let validRooms = roomList.results.filter { $0.thumbnail_url != nil }
                self.recommendedRooms = Array(validRooms.shuffled().prefix(10))
            } catch {
                print(error)
            }
        }
    }
}
