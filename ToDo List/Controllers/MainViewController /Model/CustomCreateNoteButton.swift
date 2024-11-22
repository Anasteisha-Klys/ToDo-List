//
//  CustomCreateNoteButton.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 20.11.2024.
//

import UIKit

final class CustomCreateNoteButton: UIView {
    private let addButton = UIButton()
    private let label = UILabel(text: nil, textColor: .custom.white, font: UIFont(name: SFProFont.regular.font, size: 11), textAlignment: .left, numberOfLines: 0)
    
    init() {
        super.init(frame: .infinite)
        setupView()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let footerView = UIView()
        footerView.backgroundColor = .custom.gray
        addSubviews(footerView)
        footerView.addSubviews(label, addButton)
        
        NSLayoutConstraint.activate([
            footerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 83),
            
            label.centerYAnchor.constraint(equalTo: footerView.centerYAnchor, constant: -10),
            label.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            
            addButton.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 13),
            addButton.leadingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -22),
            addButton.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -36),
        ])
    }
    
    private func setupButton() {
        addButton.setImage(UIImage(systemName: "square.and.pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28)), for: .normal)
        addButton.tintColor = .custom.main
    }
    
    func addTarget(target: Any?, action: Selector) {
        addButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func addTextLabel(text: String) {
        label.text = "\(text) Задач"
    }
}
