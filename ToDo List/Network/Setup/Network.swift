//
//  Network.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 19.11.2024.
//

import Foundation

final class Network: NetworkProtocol, NetworkRequestProtocol {
    static let shared: NetworkProtocol = Network()
    private init() {}
}
