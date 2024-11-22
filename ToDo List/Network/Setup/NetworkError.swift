//
//  NetworkError.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 19.11.2024.
//

import Foundation

enum NetworkError: Error {
    case error(Error)
    case message(_ code: Int, _ message: String?)
    case notURL
    
    var description: String {
        switch self {
        case .error(let error): return error.localizedDescription
        case .notURL: return "URL адрес некорректный. \nError code: 450"
        case .message(let code, let message): 
            
            //message
            if let message = message {
                return message + ". \nError code: \(code)"
            }
            
            //not message
            var text = ""
            switch code {
            case 200: text = "Не удалось преобразовать модель данных"
                
            default:
                text = "Неизвестная ошибка"
            }
            
            text += ". \nError code: \(code)"
            
            return text
        }
    }
}
