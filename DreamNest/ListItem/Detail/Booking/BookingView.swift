//
//  BookingView.swift
//  DreamNest
//
//  Created by Flama Henkel on 08.03.24.
//

import SwiftUI

struct BookingView: View {
    
    let name: String
    let street: String
    let price: Int
    
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var adultCount = 1
    @State private var childrenCount = 0
    @State private var hasPets = 0
    @State private var promoCode = ""
    @State private var totalAmount = "0"
    
    @StateObject private var bookingViewModel = BookingViewModel()
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var bookingSuccess = false
    
    private var numberOfNights : Int {
        Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
    }
    
    private var calculatedTotalAmount : Int {
        let total = numberOfNights*price
        return total
    }
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                HStack {
                    Spacer()
                    Text(name)
                        .font(.title)
                        .foregroundColor(.dark)
                        .padding()
                    Spacer()
                }
                Text("Adress: \(street)")
                    .font(.headline)
                    .padding(.leading, 15)
                    .foregroundColor(.dark)
                
                Text("Price per Night: \(price.formatted(.currency(code: "USD")))")
                    .font(.headline)
                    .padding(.leading, 15)
                    .foregroundColor(.green)
                
                
                DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    .padding([.leading, .trailing], 15)
                
                DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                    .padding([.leading, .trailing], 15)
                
                Stepper("Adults: \(adultCount)", value: $adultCount, in: 1...10)
                    .padding([.leading, .trailing], 15)
                Text("(7 years and older)")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.leading, 15)
                
                
                Stepper("Children: \(childrenCount)", value: $childrenCount, in: 0...10)
                    .padding([.leading, .trailing], 15)
                Text("(Under 7 years)")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.leading, 15)
                
                Stepper("Pets: \(hasPets)", value: $hasPets, in: 0...3)
                    .padding([.leading, .trailing], 15)
                Text("Promotion")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding(.leading, 15)
                TextField("Promotion Code", text: $promoCode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing], 15)
                
                Text("Total Amount: \(calculatedTotalAmount)")
                    .font(.headline)
                    .padding()
                
                Button("Payment") {
                    let newBooking = BookingInfo(
                        name: name,
                        street: street,
                        price: price,
                        userId: FirebaseManager.shared.userId ?? "",
                        startDate: startDate,
                        endDate: endDate,
                        adultCount: adultCount,
                        childrenCount: childrenCount,
                        hasPets: hasPets,
                        promoCode: promoCode.isEmpty ? nil : promoCode,
                        totalAmount: calculatedTotalAmount
                    )
                    
                    bookingViewModel.addBooking(newBooking) { success in
                        if success {
                            alertMessage = "Your booking was successful. Please check in your bookings list."
                            bookingSuccess = true
                        } else {
                            alertMessage = "There was an error with your booking. Please try again."
                            bookingSuccess = false
                        }
                        showAlert = true
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(bookingSuccess ? "Booking Successful" : "Booking Failed"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .onChange(of: startDate) {
            totalAmount = calculatedTotalAmount.formatted(.currency(code: "USD"))
        }
        .onChange(of: endDate ) {
            totalAmount = calculatedTotalAmount.formatted(.currency(code: "USD"))
        }
        .navigationTitle("Booking")
        
        
    }
}

#Preview {
    BookingView(name: "Hanoi Hotel", street: "Bahnhofstr. 123", price: 99)
}
