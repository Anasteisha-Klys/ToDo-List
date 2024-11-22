//
//  Api.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 19.11.2024.
//

import Foundation

enum Api {
    case getNote
    
    var method: String {
        switch self {
        case .getNote: return Method.get.string
        }
    }
    
    var path: String {
        switch self {
        case .getNote: return "https://dummyjson.com/todos"
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .getNote: return ["Content-Type": "application/json"]
        }
    }
}
