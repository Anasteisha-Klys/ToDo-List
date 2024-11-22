//
//  MainPresenter.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 17.11.2024.
//

import Foundation


protocol MainPresenterDelegate: AnyObject {
    func updateVC()
    func pushEditViewController(edit: Note?)
}

final class MainPresenter {
    weak var delegate: MainPresenterDelegate?
    var notes: [Note] = []
    var filteredNotes: [Note] = []
    var isSearching: Bool = false
    
    func loadNotes() {
        let checkNotes = StorageManager.shared.accessData()
        
        if checkNotes.isEmpty {
            fetchNotesFromAPI()
        } else {
            notes = StorageManager.shared.get()
            print(notes)
            reloadTable()
        }
    }
    
    func fetchNotesFromAPI() {
        Network.shared.getNotes { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let todosData):
                self.saveNotesToCoreData(todosData: todosData)
            case .failure(let error):
                print("Error fetching notes: \(error)")
            }
        }
    }
    
    private func saveNotesToCoreData(todosData: TodosData) {
        guard let todos = todosData.todos else {
            print("No todos available")
            return
        }
        
        let context = StorageManager.shared.getContext()
        
        for todo in todos {
            let note = Note(context: context)
            note.id = Int64(todo.id ?? 0)
            note.title = todo.todo
            note.completed = todo.completed ?? false 
        }
        
        StorageManager.shared.saveContext()
    
        loadNotes()
    }
    
    func updateCD() {
        notes = StorageManager.shared.get()
        delegate?.updateVC()
    }
    
    func reloadTable() {
        delegate?.updateVC()
    }
    
    func addAndEditNote() {
        delegate?.pushEditViewController(edit: nil)
    }
    
    func filterNotesForSearch(text: String) {
        isSearching = true
        filteredNotes = notes.filter { note in
            note.title?.lowercased().contains(text.lowercased()) ?? false
        }
    }
    
    func cleanFilterNotes() {
        isSearching = false 
        filteredNotes.removeAll()
    }
    
    func didSelectEditCell(note: Note) {
        delegate?.pushEditViewController(edit: note)
    }
    
    func editingNote(edit: Note) {
        delegate?.pushEditViewController(edit: edit)
    }
    
    func deleteNote(note: Note) {
        StorageManager.shared.delete(note)
    }
}
