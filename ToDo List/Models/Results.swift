//
//  Results.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 19.11.2024.
//

import Foundation

enum Results<Success> {
    case success(Success)
    case failure(NetworkError)
}
