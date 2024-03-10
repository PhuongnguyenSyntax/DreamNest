//
//  PersistentStore.swift
//  DreamNest
//
//  Created by Flama Henkel on 05.03.24.
//

import Foundation
import CoreData

class PersistentStore {
    
    static let shared = PersistentStore()
    
    private let container: NSPersistentContainer
    
    var context: NSManagedObjectContext { self.container.viewContext }
    
    init() {
        self.container = NSPersistentContainer(name: "FavoriteRoom")

        container.viewContext.automaticallyMergesChangesFromParent = true
        
        self.container.loadPersistentStores { _, error in
            if let error {
                fatalError("Error occured white loading data base: \(error.localizedDescription)")
            }
        }
    }
    
    func saveChanges() {
        guard self.context.hasChanges else { return }
      
        do {
            try self.context.save()
        } catch {
            print("Couldn't safe changes!")
        }
    }
}
