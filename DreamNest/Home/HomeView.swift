//
//  HomeView.swift
//  DreamNest
//
//  Created by Flama Henkel on 27.02.24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var currentIndex = 0
    private let bannerImages = ["japan", "rabat", "berlin", "paris"]
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    @StateObject private var viewModel = HomeViewModel()
    @StateObject private var listRoomViewModel = ListRoomViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                // Header with avatar and search bar
                HStack {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    
                    NavigationLink(destination: SearchView(viewModel: listRoomViewModel)) {
                        HStack {
                            Text("Search...")
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.dark, lineWidth: 1)
                        )
                    }
                }
                .padding()
                
                // Banner
                TabView(selection: $currentIndex) {
                    ForEach(0..<bannerImages.count, id: \.self) { index in
                        Image(bannerImages[index])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: 220)
                        
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 220)
                .onReceive(timer, perform: { _ in
                    withAnimation {
                        currentIndex = (currentIndex + 1) % bannerImages.count
                    }
                })
                
                // Custom Indicators
                HStack(spacing: 8) {
                    ForEach(0..<bannerImages.count, id: \.self) { index in
                        Circle()
                            .fill(currentIndex == index ? Color.dark : Color.gray)
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.top, 5)
            }
            // Recommend List
            Text("Recommended Rooms")
                .fontWeight(.heavy)
                .foregroundColor(.dark)
                .padding()
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.recommendedRooms, id: \.self) { room in
                        NavigationLink(destination: DetailRoomView(room: room, viewModel: DetailRoomViewModel())) {
                            RoomItemView(room: room)
                        }
                        
                    }
                }
                .padding(.horizontal)
            }
            .onAppear{
                viewModel.loadRecommendedRooms()
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
