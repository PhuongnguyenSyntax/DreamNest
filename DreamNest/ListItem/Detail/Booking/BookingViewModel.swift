//
//  BookingViewModel.swift
//  DreamNest
//
//  Created by Flama Henkel on 09.03.24.
//

import Foundation
import FirebaseFirestore

class BookingViewModel: ObservableObject {
    @Published var bookings: [BookingInfo] = []
    
    init() {
        fetchBookings()
    }
    
    func fetchBookings() {
        let userId = FirebaseManager.shared.userId
        Firestore.firestore().collection("bookings")
            .whereField("userId", isEqualTo: userId ?? "")
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                    return
                }
                
                self.bookings = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: BookingInfo.self)
                } ?? []
            }
    }
    
    func addBooking(_ bookingInfo: BookingInfo, completion: @escaping (Bool) -> Void ) {
        
        do {
            _ = try FirebaseManager.shared.fireStore.collection("bookings").addDocument(from: bookingInfo) { error in
                if let error = error {
                    print("Error writing booking to Firestore: \(error)")
                    completion(false)
                } else {
                    completion(true)
                }
            }
        } catch let error {
            print("Error writing booking to Firestore: \(error)")
            completion(false)
        }
    }
    
    
    func updateBooking(_ bookingInfo: BookingInfo) {
        guard let bookingId = bookingInfo.id else { return }
        
        do {
            try FirebaseManager.shared.fireStore.collection("bookings").document(bookingId).setData(from: bookingInfo)
        } catch let error {
            print("Error updating booking: \(error)")
        }
    }
    
    
    func deleteBooking(_ bookingInfo: BookingInfo) {
        guard let bookingId = bookingInfo.id else { return }
        
        FirebaseManager.shared.fireStore.collection("bookings").document(bookingId).delete() { error in
            if let error = error {
                print("Error removing booking: \(error)")
            } else {
                print("Delete succeeded")
            }
        }
    }
    
}
