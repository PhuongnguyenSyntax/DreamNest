//
//  RoomCartView.swift
//  DreamNest
//
//  Created by Flama Henkel on 03.03.24.
//

import SwiftUI

struct RoomCartView: View {
    
    let roomModel: RoomItem
    @State private var isFavorite: Bool = false
    @ObservedObject var viewModel = DetailRoomViewModel()
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: roomModel.thumbnail_url ?? "")) { image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fill)
            .frame(width: 120, height: 100)
            .cornerRadius(10)
            .clipped()
            
            VStack(alignment: .leading) {
                Text(roomModel.name ?? "")
                    .font(.headline)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                Text("\(roomModel.street ?? "")")
                    .font(.subheadline)
                    .lineLimit(2)
                    .truncationMode(.tail)
                Text("")
                
                HStack {
                    VStack {
                        Text("Price")
                        Text("\(roomModel.price.map(String.init) ?? "N/A")$")
                    }
                    .font(.subheadline)
                    .foregroundColor(.green)
                    
                    Spacer()
                    VStack {
                        Text("Rating")
                        HStack {
                            Text("\(roomModel.review_scores_rating ?? 1000) ")
                            Image(systemName: "star")
                        }
                    }
                    .font(.subheadline)
                    .foregroundColor(.blue)
                }
            }
            Spacer()
            
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundColor(isFavorite ? .green : .gray)
                .onTapGesture {
                    Task {
                        if viewModel.checkItemExitInFavoriteList(id: roomModel.id) {
                            isFavorite = false
                            viewModel.removeItemFromFavoriteList(id: roomModel.id)
                        } else {
                            isFavorite = true
                            viewModel.addItemToFavoriteList(item: roomModel)
                        }
                    }
                }
                .padding(.trailing, 10)
                .padding(.bottom, 70)
        }
        .onAppear {
            isFavorite = viewModel.checkItemExitInFavoriteList(id: roomModel.id)
        }
    }
}


#Preview {
    
    RoomCartView(roomModel:
                    RoomItem(id: "1",
                             listing_url: "https://a0.muscache.com/im/pictures/c10b4aa3-50cc-4b3f-91fa-386c629c3816.jpg?aki_policy=small",
                             name: "Hanoi",
                             summary: "dep",
                             space: "tot",
                             description: "rat to to rong",
                             house_rules: "khong ve truoc 10 h",
                             thumbnail_url: "https://a0.muscache.com/im/pictures/c10b4aa3-50cc-4b3f-91fa-386c629c3816.jpg?aki_policy=small",
                             xl_picture_url: "https://a0.muscache.com/im/pictures/c10b4aa3-50cc-4b3f-91fa-386c629c3816.jpg?aki_policy=x_large",
                             amenities: ["may say","tivi","tulanh"],
                             price: 114,
                             latitude: "40.79965375911271",
                             longitude: "-73.9683357098039",
                             street: "123 hang buom",
                             review_scores_rating: 99,
                             host_name: "flama", host_since: "18.5.2022",
                             host_picture_url: "https://a0.muscache.com/im/users/13046423/profile_pic/1394604314/original.jpg?aki_policy=profile_x_medium",
                             features: ["Host ist gut", "Host Identity Verified", "Is Location Exact"]))
}
