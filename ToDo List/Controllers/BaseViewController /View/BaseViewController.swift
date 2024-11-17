//
//  BaseViewController.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 17.11.2024.
//

import UIKit

class BaseViewController: UIViewController {
    init() { super.init(nibName: nil, bundle: nil)}
    required init?(coder: NSCoder) { super.init(coder: coder)}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .custom.black
    }
}
