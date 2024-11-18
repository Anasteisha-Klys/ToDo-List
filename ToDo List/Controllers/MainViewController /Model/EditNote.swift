//
//  EditNote.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 17.11.2024.
//

import UIKit

final class EditNote: UIView {
    private let nameNoteLabel = UILabel(text: "hello", textColor: .custom.white, font: UIFont(name: SFProFont.medium.font, size: 16), textAlignment: .left, numberOfLines: 0)
    private let miniNoteLabel = UILabel(text: "sjdkcsbbskbcsbcshbchkb", textColor: .custom.white, font: UIFont(name: SFProFont.bold.font, size: 12), textAlignment: .left, numberOfLines: 0)
    private let dateLabel = UILabel(text: "22/06/23", textColor: .custom.white, font: UIFont(name: SFProFont.regular.font, size: 12), textAlignment: .left, numberOfLines: 0)
    private let editNoteButton = CustomButton()
    private let sharedButton = CustomButton()
    private let deleteButton = CustomButton()
    
    init() {
        super.init(frame: .infinite)
        setupView()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        
        let stackViewNote = UIStackView(axis: .vertical, spacing: 6, alignment: .fill, distribution: .equalSpacing, arrangedSubviews: nameNoteLabel, miniNoteLabel, dateLabel)
        
        let stackViewForButton = UIStackView(axis: .vertical, spacing: 0, alignment: .fill, distribution: .equalSpacing, arrangedSubviews: editNoteButton, sharedButton, deleteButton)
        stackViewForButton.cornerRadius = 12
        
        let baseViewForGeneral = UIView()
        baseViewForGeneral.backgroundColor = .custom.gray
        baseViewForGeneral.cornerRadius = 12
        baseViewForGeneral.addSubviews(stackViewNote)
        
        let baseView = UIView()
        addSubviews(baseView)
        baseView.fullConstraint()
        baseView.addSubviews(baseViewForGeneral, stackViewForButton)
        
        NSLayoutConstraint.activate([
            baseViewForGeneral.topAnchor.constraint(equalTo: baseView.topAnchor),
            baseViewForGeneral.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
            baseViewForGeneral.trailingAnchor.constraint(equalTo: baseView.trailingAnchor),
            
            stackViewForButton.topAnchor.constraint(equalTo: baseViewForGeneral.bottomAnchor, constant: 16),
            stackViewForButton.leadingAnchor.constraint(equalTo: baseViewForGeneral.leadingAnchor, constant: 33),
            stackViewForButton.trailingAnchor.constraint(equalTo: baseViewForGeneral.trailingAnchor, constant: -33),
            stackViewForButton.bottomAnchor.constraint(equalTo: baseView.bottomAnchor),
            
            stackViewNote.topAnchor.constraint(equalTo: baseViewForGeneral.topAnchor, constant: 12),
            stackViewNote.leadingAnchor.constraint(equalTo: baseViewForGeneral.leadingAnchor, constant: 16),
            stackViewNote.trailingAnchor.constraint(equalTo: baseViewForGeneral.trailingAnchor, constant: -16),
            stackViewNote.bottomAnchor.constraint(equalTo: baseViewForGeneral.bottomAnchor, constant: -12)
        ])
    }
    
    private func setupButton() {
        editNoteButton.setupTextLabel(dateText: "Редактировать", font: UIFont.systemFont(ofSize: 16, weight: .regular), textColor: .custom.black)
        editNoteButton.setupImageOnButton(image: "edit")
        
        sharedButton.setupTextLabel(dateText: "Поделиться", font: UIFont.systemFont(ofSize: 16, weight: .regular), textColor: .custom.black)
        sharedButton.setupImageOnButton(image: "export")

        deleteButton.setupTextLabel(dateText: "Удалить", font: UIFont.systemFont(ofSize: 16, weight: .regular), textColor: .custom.red)
        deleteButton.setupImageOnButton(image: "trash")
    }
    
    func addTargetEdit(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        editNoteButton.addTarget(target, action: action, for: controlEvents)
        let gesture = UITapGestureRecognizer(target: target, action: action)
        editNoteButton.addGestureRecognizer(gesture)
    }
    
    func addTargetShared(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        sharedButton.addTarget(target, action: action, for: controlEvents)
        let gesture = UITapGestureRecognizer(target: target, action: action)
        sharedButton.addGestureRecognizer(gesture)
    }

    func addTargetDelete(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        deleteButton.addTarget(target, action: action, for: controlEvents)
        let gesture = UITapGestureRecognizer(target: target, action: action)
        deleteButton.addGestureRecognizer(gesture)
    }
}
