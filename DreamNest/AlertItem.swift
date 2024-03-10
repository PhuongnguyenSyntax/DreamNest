//
//  AlertItem.swift
//  DreamNest
//
//  Created by Flama Henkel on 01.03.24.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let invalidData = AlertItem(title: Text("Serve Error"),
                                       message: Text("The data received from the server was invalid. Please contact support."),
                                       dismissButton: .default(Text("OK")))
    static let invalidResponse = AlertItem(title: Text("Serve Error"),
                                       message: Text("Invalid response from the serve. Please try again or contact support."),
                                       dismissButton: .default(Text("OK")))
    static let invalidURL = AlertItem(title: Text("Serve Error"),
                                       message: Text("There was an issue connecting to the server. If this persists, Please contact support."),
                                       dismissButton: .default(Text("OK")))
    static let unableToComplete = AlertItem(title: Text("Serve Error"),
                                       message: Text("Unable to complete ypur request at this time. Please check your internet connection."),
                                       dismissButton: .default(Text("OK")))
}

