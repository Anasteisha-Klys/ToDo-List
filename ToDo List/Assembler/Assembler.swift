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
    
    func setupEditViewController(delegate: EditViewControllerDelegate, edit: Note? = nil) -> EditViewController {
        let presenter = EditPresenter(edit: edit)
        let vc = EditViewController(presenter: presenter, delegate: delegate)
        presenter.delegate = vc
        return vc 
    }
}
