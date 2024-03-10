//
//  BookingRowView.swift
//  DreamNest
//
//  Created by Flama Henkel on 10.03.24.
//

import SwiftUI

struct BookingRowView: View {
    
    let booking: BookingInfo
    
    var formattedBookingDate: String {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
        formatter.timeStyle = .medium

            return formatter.string(from: booking.bookingDate)
        }
    
    var body: some View {
        HStack {
            Image(systemName: "doc")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading) {
                
                Text(booking.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.dark)
                    .lineLimit(1)
                Text(booking.street)
                    .font(.system(size: 14))
                    .foregroundColor(.dark)
                    .lineLimit(1)
                Text("Date: \(booking.startDate.formatted(date: .abbreviated, time: .omitted)) - \(booking.endDate.formatted(date: .abbreviated, time: .omitted))")
                    .font(.system(size: 14))
                    .foregroundColor(.primaryBlue)
                Text("Total: \(booking.totalAmount.formatted(.currency(code: "USD")))")
                    .font(.system(size: 16))
                    .foregroundColor(.primaryBlue)
                Text("Booking Date:")
                    .font(.system(size: 14))
                Text(" \(formattedBookingDate)")
                    .font(.system(size: 14))
                
            }
        }
    }
}

#Preview {
    
    BookingRowView(booking: BookingInfo(name: "Hanoi", street: "123 acb", price: 99, userId: "123", startDate: Date(), endDate: Date(), adultCount: 2, childrenCount: 1, hasPets: 0, totalAmount: 100, bookingDate: Date()))
}
