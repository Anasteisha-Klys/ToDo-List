//
//  Note.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 19.11.2024.
//

import Foundation
import CoreData

@objc(Note)
class Note: NSManagedObject {
    @NSManaged var id: Int64
    @NSManaged var title: String?
    @NSManaged var completed: Bool
    
    convenience init(title: String?) {
        self.init()
        self.title = title
    }
}

extension Note {
    @nonobjc static func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }
}
