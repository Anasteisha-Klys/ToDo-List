//
//  TodosData.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 19.11.2024.
//

import Foundation

struct TodosData: Codable {
    let todos: [Todo]?
}

// MARK: - Todo
struct Todo: Codable {
    let id: Int?
    let todo: String?
    let completed: Bool?
}
