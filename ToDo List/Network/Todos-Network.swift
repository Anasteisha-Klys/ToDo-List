//
//  Todos-Network.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 19.11.2024.
//

import Foundation

extension Network {
    
    func getNotes(completion: @escaping (Results<TodosData>) -> Void) {
        pushData(api: .getNote, type: TodosData.self, completion: completion)
    }
}
