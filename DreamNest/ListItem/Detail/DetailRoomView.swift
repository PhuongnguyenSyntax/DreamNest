//
//  DetailRoomView.swift
//  DreamNest
//
//  Created by Flama Henkel on 03.03.24.
//

import SwiftUI
import MapKit

struct DetailRoomView: View {
    
    let room: RoomItem
    @State private var isFavorite: Bool = false
    @ObservedObject var viewModel: DetailRoomViewModel
    @State private var showBookingView = false
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                ScrollView {
                    VStack(alignment: .leading) {
                    
                        ImageSection(urlString: room.xl_picture_url)
                        
                        Text(room.street ?? "No Address")
                            .font(.headline)
                            .padding(.leading, 15)
                        
                        Text("Rating: \(room.review_scores_rating ?? 1)")
                            .padding(.leading, 15)
                            .foregroundColor(.yellow)
                        Divider()
                        
                        
                        if let price = room.price {
                            Text("Price: \(price.formatted(.currency(code: "USD"))) per Night")
                                .foregroundColor(.green)
                                .padding(.leading, 15)
                        }
                        Divider()
                        
                        VStack(alignment: .leading) {
                            Text("Facilities")
                                .fontWeight(.bold)
                            if let amenities = room.amenities {
                                ForEach(amenities, id: \.self) { amenity in
                                    Text(amenity)
                                }
                            }
                        }
                        .padding(.leading, 15)
                        Divider()
                        
                        
                        Text("Summary:")
                            .fontWeight(.bold)
                            .padding(.leading, 15)
                        Text("\(room.summary ?? "Nothing else")")
                            .padding(.leading, 15)
                        Divider()
                        
                        Text("Description")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.leading, 15)
                        Text("\(room.description ?? "")")
                            .padding(.leading, 15)
                        Divider()
                        
                        
                        Text("House Rules:")
                            .fontWeight(.bold)
                            .padding(.leading, 15)
                        Text("\(room.house_rules ?? "")")
                            .padding(.leading, 15)
                        Divider()
                        
                        
                        Text("Location")
                            .padding(.leading, 15)
                            .fontWeight(.bold)
                        
                        if let lat = room.latitude, let lon = room.longitude {
                            Map() {
                                Marker(room.name ?? "", systemImage: "house.lodge.circle.fill", coordinate: CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lon)!))
                                    .tint(.blue)
                            }
                            .frame(width: proxy.frame(in: .local).width, height: 300, alignment: .center)
                        }
                        
                        //Host Info
                        HStack {
                            AsyncImage(url: URL(string: room.host_picture_url)) { image in
                                image.resizable()
                                
                            } placeholder: {
                               Image(systemName: "photo")
                            }
                            .frame(width: 75, height: 75)
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text("Host: \(room.host_name)")
                                    .font(.headline)
                                Text("Since: \(room.host_since)")
                            }
                            
                        }
                        .padding()
                        .padding(.leading, 15)
                        
                        
                        VStack(alignment: .leading) {
                            if let features = room.features {
                                ForEach(features, id: \.self) { feature in
                                    Text(feature)
                                }
                            }
                        }
                        .padding(.leading, 15)
                       
                        Text("")
                        Text("")
                        Text("")
                        Text("")
                        Text("")
                        Text("")
                        
                    }
                }
                
                
            }
          
            
            
            VStack {
                Spacer()
                Button("Booking") {
                    showBookingView = true
                }
                .font(.system(size: 18, weight: .bold))
                .frame(width: 300)
                .padding()
                .background(.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .sheet(isPresented: $showBookingView){
                    BookingView(showBookingView: $showBookingView, name: room.name ?? "", street: room.street ?? "", price: room.price ?? 1)
                }
                
                
            }
        }
        .onAppear {
            isFavorite = viewModel.checkItemExitInFavoriteList(id: room.id)
        }
        .navigationTitle(room.name ?? "Room Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Task {
                        isFavorite.toggle()
                        if isFavorite {
                            viewModel.addItemToFavoriteList(item: room)
                        } else {
                            viewModel.removeItemFromFavoriteList(id: room.id)
                        }
                    }
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .green : .gray)
                }
            }
        }
        
       
        
    }
}

struct ImageSection: View {
    
    let urlString: String?
    var body: some View {
        if let urlString = urlString, let url = URL(string: urlString) {
            AsyncImage(url: url) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fill)
            .frame(height: 250)
            .clipped()
        }
    }
}

#Preview {
    
    DetailRoomView(room: RoomItem(id: "1",
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
                                  features: ["Host ist gut", "Host Identity Verified", "Is Location Exact"]), viewModel: DetailRoomViewModel())
}
