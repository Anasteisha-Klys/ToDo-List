//
//  StorageMenager.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 19.11.2024.
//

import CoreData
import Foundation

class StorageManager {
    static let shared: StorageManager = StorageManager()
    
    private let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "ToDo_List")
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    func get<Model: NSManagedObject>() -> [Model] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Model>(entityName: String(describing: Model.self))
        
        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            print("Failed to fetch objects: \(error)")
            return []
        }
    }
    
    func add(_ object: NSManagedObject) {
        let context = persistentContainer.viewContext
        context.insert(object)
        
        saveContext()
    }
    
    func editing<Result>(_ block: (() throws -> Result)) {
        let context = persistentContainer.viewContext
        context.performAndWait {
            do {
                try block()
                saveContext()
            } catch {
                print("Failed to edit: \(error)")
            }
        }
    }
    
    func delete(_ object: NSManagedObject) {
        let context = persistentContainer.viewContext
        context.delete(object)
        
        saveContext()
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
    
    func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func accessData() -> [Note] {
        let context = getContext()
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        var notes: [Note] = []
        do {
            notes = try context.fetch(fetchRequest)
            if notes.isEmpty {
                return []
            } else {
                return notes
            }
        } catch {
            print("Error fetching tasks: \(error)")
        }
        return notes 
    }
}

