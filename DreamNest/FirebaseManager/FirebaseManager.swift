//
//  FirebaseManager.swift
//  DreamNest
//
//  Created by Flama Henkel on 09.03.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FirebaseManager {
    static let shared = FirebaseManager()
    
    let authenticator = Auth.auth()
    let fireStore = Firestore.firestore()
    
    var userId: String? {
        authenticator.currentUser?.uid
    }
}
