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
        
        if let edit = edit {
            StorageManager.shared.editing {
                edit.title = title
            }
            delegate?.popViewController()
        } else {
            StorageManager.shared.add(Note(title: title))
            delegate?.popViewController()
        }
    }
}
