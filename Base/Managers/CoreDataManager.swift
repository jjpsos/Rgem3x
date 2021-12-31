//
//  CoreDataManager.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 7/29/21.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    static let shared = CoreDataManager()
    
    private init() {
        
        persistentContainer = NSPersistentCloudKitContainer(name: "Rgem3xModel")
        persistentContainer.persistentStoreDescriptions.first!.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to initialize Core Data \(error)")
            }
        }
        
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        print(directories[0])
    }
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext 
    }
    
}


