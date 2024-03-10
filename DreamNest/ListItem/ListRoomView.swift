//
//  ListRoomView.swift
//  DreamNest
//
//  Created by Flama Henkel on 01.03.24.
//

import SwiftUI

struct ListRoomView: View {
    @StateObject private var viewModel = ListRoomViewModel()
    @StateObject var detailViewModel = DetailRoomViewModel()

    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            List(viewModel.filteredRooms) { room in
                NavigationLink(destination: DetailRoomView(room: room, viewModel: DetailRoomViewModel())) {
                    RoomCartView(roomModel: room)
                    .frame(maxWidth: .infinity)
                }
            }
            .listRowInsets(EdgeInsets())
            .searchable(text: $searchText, prompt: "Search by name")
            .onChange(of: searchText) {
                viewModel.searchRooms(with: searchText)
            }
        }
        .onAppear {
            viewModel.load()
        }
    }
}


#Preview {
    ListRoomView()
}
