//
//  DataController.swift
//  NBAstatz
//
//  Created by Yash Rao on 4/29/18.
//  Copyright © 2018 com.YashasRao99. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard (error == nil) else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }
    
    func saveContext() throws {
        if viewContext.hasChanges {
            try viewContext.save()
        }
    }
}
