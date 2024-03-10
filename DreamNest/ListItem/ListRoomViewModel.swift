//
//  ListRoomViewModel.swift
//  DreamNest
//
//  Created by Flama Henkel on 01.03.24.
//

import Foundation

class ListRoomViewModel: ObservableObject {
    
    @Published var rooms: [RoomItem] = []
    @Published var filteredRooms: [RoomItem] = []
    
    private let apiRoomRepository : ApiRoomRepository
   
    
    init(){
        self.apiRoomRepository = ApiRoomRepository()
       
    }
    
    @MainActor
    func load() {
        Task {
            do {
                let roomList = try await self.apiRoomRepository.searchRoom()
                self.rooms = roomList.results
                self.filteredRooms = roomList.results
                
            } catch {
                print(error)
            }
        }
    }
    
    func searchRooms(with query: String) {
        if query.isEmpty {
            filteredRooms = rooms
        } else {
            filteredRooms = rooms.filter { $0.name?.lowercased().contains(query.lowercased()) ?? false }
        }
    }
}


