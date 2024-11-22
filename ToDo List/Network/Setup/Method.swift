//
//  Method.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 19.11.2024.
//

import Foundation

enum Method: String {
    case get
    case post
    case put
    case delete
    
    var string: String { return rawValue.lowercased() }
}
