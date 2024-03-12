//
//  BookingInfo.swift
//  DreamNest
//
//  Created by Flama Henkel on 09.03.24.
//

import Foundation
import FirebaseFirestoreSwift

struct BookingInfo: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var street: String
    var price: Int
    var userId: String
    var startDate: Date
    var endDate: Date
    var adultCount: Int
    var childrenCount: Int
    var hasPets: Int
    var promoCode: String?
    var totalAmount: Int    
    var bookingDate: Date
}
