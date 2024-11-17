//
//  Assembler.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 17.11.2024.
//

import Foundation

final class Assembler {
    private init(){}
    static let shared = Assembler()
    
    func setupMainViewController() -> MainViewController {
        let presenter = MainPresenter()
        let vc = MainViewController(presenter: presenter)
        presenter.delegate = vc 
        return vc
    }
}
