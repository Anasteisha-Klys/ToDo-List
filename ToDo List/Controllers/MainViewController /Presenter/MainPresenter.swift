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
    var row: Int = 0
    
    func loadNotes() {
        DispatchQueue.global(qos: .background).async {
            StorageManager.shared.loadNotes { [weak self] todos in
                guard let self = self else { return }
                
                if let todos = todos {
                    self.notes = todos.map { todo in
                        let note = Note(context: StorageManager.shared.getContext())
                        note.id = Int64(todo.id ?? 0)
                        note.title = todo.todo
                        note.completed = todo.completed ?? false 
                        return note
                    }
                    self.reloadTable()
                } else {
                    self.fetchNotesFromAPI()
                }
            }
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
        DispatchQueue.global(qos: .background).async {
            guard let todos = todosData.todos else {
                print("No todos available")
                return
            }
            
            StorageManager.shared.saveNotes(todos: todos)
            
            DispatchQueue.main.async {
                self.loadNotes() 
            }
        }
    }
    
    func updateCD() {
        DispatchQueue.global(qos: .background).async {
            self.notes = StorageManager.shared.get()
            DispatchQueue.main.async {
                self.delegate?.updateVC()
            }
        }
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.delegate?.updateVC()
        }
    }
    
    func addAndEditNote() {
        DispatchQueue.main.async {
            self.delegate?.pushEditViewController(edit: nil)
        }
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
        DispatchQueue.main.async {
            self.delegate?.pushEditViewController(edit: note)
        }
    }
    
    func editingNote(edit: Note) {
        DispatchQueue.main.async {
            self.delegate?.pushEditViewController(edit: edit)
        }
    }
    
    func deleteNote(note: Note) {
        DispatchQueue.global(qos: .background).async {
            StorageManager.shared.delete(note)
        }
    }
}
