//
//  MyBookingsView.swift
//  DreamNest
//
//  Created by Flama Henkel on 10.03.24.
//

import SwiftUI

struct MyBookingsView: View {
    @StateObject var viewModel = BookingViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.bookings) { booking in
                BookingRowView(booking: booking)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            viewModel.deleteBooking(booking)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
            .navigationTitle("My Bookings")
            .onAppear {
                viewModel.fetchBookings()
            }
        }
    }
}

#Preview {
    MyBookingsView()
}
