//
//  EditPresenter.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 18.11.2024.
//

import Foundation

protocol EditPresenterDelegate: AnyObject {
    func popViewController()
}

final class EditPresenter {
    weak var delegate: EditPresenterDelegate?
    private (set) var edit: Note?
    private var timer: Timer?
    
    init(edit: Note? = nil) {
        self.edit = edit
    }
    
    func saveNote(title: String?) {
        guard let title = title else { return }
        
        DispatchQueue.global(qos: .background).async {
            if let edit = self.edit {
                StorageManager.shared.editing {
                    edit.title = title
                }
            } else {
                let context = StorageManager.shared.getContext()
                let newNote = Note(context: context)
                newNote.id = Int64(Date().timeIntervalSince1970)
                newNote.title = title
                newNote.completed = false
                
                StorageManager.shared.add(newNote)
                
            }
            
            DispatchQueue.main.async {
                self.delegate?.popViewController()
            }
        }
    }
}
