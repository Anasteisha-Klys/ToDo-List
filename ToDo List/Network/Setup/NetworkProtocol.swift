//
//  NetworkProtocol.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 19.11.2024.
//

import Foundation

protocol NetworkProtocol {
    func getNotes(completion: @escaping (Results<TodosData>) -> Void)
}
