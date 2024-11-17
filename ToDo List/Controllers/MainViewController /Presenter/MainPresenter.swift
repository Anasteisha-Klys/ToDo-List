//
//  MainPresenter.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 17.11.2024.
//

import Foundation

protocol MainPresenterDelegate: AnyObject {
    
}

final class MainPresenter {
    weak var delegate: MainPresenterDelegate?
}
