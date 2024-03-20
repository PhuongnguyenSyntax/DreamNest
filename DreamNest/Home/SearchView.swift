//
//  SearchView.swift
//  DreamNest
//
//  Created by Flama Henkel on 20.03.24.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var viewModel: ListRoomViewModel
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack(root: {
            List(filteredRooms) { item in
                NavigationLink(destination: DetailRoomView(room: item, viewModel: DetailRoomViewModel())) {
                    Text(item.name ?? "")
                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchText, prompt: Text("Search for any place name"))
        })
        .onAppear {
            viewModel.load()
        }
    }
    
    var filteredRooms: [RoomItem] {
        viewModel.rooms.filter {
            searchText.isEmpty || $0.name?.localizedCaseInsensitiveContains(searchText) ?? false
        }
    }
}

#Preview {
    SearchView(viewModel: ListRoomViewModel())
}

