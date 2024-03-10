//
//  RoomItemView.swift
//  DreamNest
//
//  Created by Flama Henkel on 05.03.24.
//

import SwiftUI

struct RoomItemView: View {
    let room: RoomItem
    
    var body: some View {
        VStack(alignment: .leading) {
            if let thumbnailURL = room.thumbnail_url, let url = URL(string: thumbnailURL) {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: .infinity, height: 200)
            }
            Text(room.name ?? "Unknown")
                .font(.headline)
                .lineLimit(1)
                .padding(.leading, 15)
            Text(room.street ?? "")
                .font(.subheadline)
                .lineLimit(1)
                .padding([.leading, .trailing], 15)
            HStack {
                Text("Price: \(room.price?.formatted() ?? "N/A") $")
                    .font(.subheadline)
                    .foregroundColor(.green)
                Spacer()
                Text("Rating: \(room.review_scores_rating ?? 0)")
                    .font(.subheadline)
                    .foregroundColor(.yellow)
            }
            
            .padding([.leading, .trailing, .bottom], 15)
         }
        .frame(maxWidth: .infinity)
        .cornerRadius(10)
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.dark, lineWidth: 1)
        )
    }
}

#Preview {
    RoomItemView(room: RoomItem(id: "1", listing_url: "https://a0.muscache.com/im/pictures/c10b4aa3-50cc-4b3f-91fa-386c629c3816.jpg?aki_policy=small", name: "Hanoi", summary: "dep", space: "tot", description: "rat to to rong", house_rules: "khong ve truoc 10 h", thumbnail_url: "https://a0.muscache.com/im/pictures/c10b4aa3-50cc-4b3f-91fa-386c629c3816.jpg?aki_policy=small", xl_picture_url: "https://a0.muscache.com/im/pictures/c10b4aa3-50cc-4b3f-91fa-386c629c3816.jpg?aki_policy=x_large",  amenities: ["may say","tivi","tulanh"], price: 114, latitude: "40.79965375911271", longitude: "-73.9683357098039", street: "123 hang buom", review_scores_rating: 99, host_name: "flama", host_since: "18.5.2022", host_picture_url: "https://a0.muscache.com/im/users/13046423/profile_pic/1394604314/original.jpg?aki_policy=profile_x_medium", features: ["Host ist gut", "Host Identity Verified", "Is Location Exact"]))
}
