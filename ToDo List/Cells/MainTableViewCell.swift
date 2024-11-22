//
//  MainTableViewCell.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 17.11.2024.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    private let checkmarkButton = UIButton()
    private let nameNoteLabel = UILabel(text: nil, font: UIFont(name: SFProFont.medium.font, size: 16), textAlignment: .left, numberOfLines: 0)
    private let miniNoteLabel = UILabel(text: nil, font: UIFont(name: SFProFont.bold.font, size: 12), textAlignment: .left, numberOfLines: 0)
    private let dateLabel = UILabel(text: nil, textColor: .custom.grayLighter, font: UIFont(name: SFProFont.regular.font, size: 12), textAlignment: .left, numberOfLines: 0)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        
        let lineView = UIView()
        lineView.backgroundColor = .custom.grayLighter
        
        let stackViewNote = UIStackView(axis: .vertical, spacing: 6, alignment: .fill, distribution: .equalSpacing, arrangedSubviews: nameNoteLabel, miniNoteLabel, dateLabel)
        let stackViewButton = UIStackView(axis: .vertical, spacing: 10, alignment: .fill, distribution: .equalSpacing, arrangedSubviews: checkmarkButton, UIView(), UIView())
        let generalView = UIView()
        generalView.addSubviews(stackViewButton, stackViewNote)
        
        let baseView = UIView()
        contentView.addSubviews(baseView)
        baseView.fullConstraint()
        baseView.addSubviews(generalView, lineView)
        
        let gesture = UILongPressGestureRecognizer()
        addGestureRecognizer(gesture)
        
        NSLayoutConstraint.activate([
            stackViewButton.topAnchor.constraint(equalTo: generalView.topAnchor, constant: 12),
            stackViewButton.leadingAnchor.constraint(equalTo: generalView.leadingAnchor, constant: 20),
            stackViewButton.bottomAnchor.constraint(equalTo: generalView.bottomAnchor, constant: -12),
            
            stackViewNote.topAnchor.constraint(equalTo: generalView.topAnchor, constant: 12),
            stackViewNote.leadingAnchor.constraint(greaterThanOrEqualTo: stackViewButton.trailingAnchor, constant: 8),
            stackViewNote.trailingAnchor.constraint(equalTo: generalView.trailingAnchor, constant: -20),
            stackViewNote.bottomAnchor.constraint(equalTo: generalView.bottomAnchor, constant: -12),
            
            generalView.topAnchor.constraint(equalTo: baseView.topAnchor),
            generalView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
            generalView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor),
            
            lineView.topAnchor.constraint(equalTo: generalView.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 20),
            lineView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -20),
            lineView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -2),
            lineView.heightAnchor.constraint(equalToConstant: 0.2)
        ])
    }
    
    private func setupButton() {
        updateButtonImage()
        checkmarkButton.addTarget(self, action: #selector(changeButton(_:)), for: .touchUpInside)
    }
    
    private func updateButtonImage() {
        let imageForButton = checkmarkButton.isSelected ? "checkmark.circle" : "circle"
        checkmarkButton.setImage(UIImage(systemName: imageForButton, withConfiguration: UIImage.SymbolConfiguration(pointSize: 24)), for: .normal)
        checkmarkButton.tintColor = checkmarkButton.isSelected ? UIColor.custom.main : UIColor.custom.grayLighter
        updateNameNoteLabelText()
    }
    
    private func updateNameNoteLabelText() {
        nameNoteLabel.textColor = checkmarkButton.isSelected ? UIColor.custom.grayLighter : UIColor.custom.white
        miniNoteLabel.textColor = checkmarkButton.isSelected ? UIColor.custom.grayLighter : UIColor.custom.white
        if checkmarkButton.isSelected {
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: nameNoteLabel.text ?? "")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributeString.length))
            nameNoteLabel.attributedText = attributeString
        } else {
            nameNoteLabel.attributedText = NSAttributedString(string: nameNoteLabel.text ?? "")
        }
    }
    
    @objc private func changeButton(_ sender: UIButton) {
        checkmarkButton.isSelected.toggle()
        updateButtonImage()
    }
    
    func setupCell(notes: Note) {
        nameNoteLabel.text = notes.title
        checkmarkButton.isSelected = notes.completed
        updateButtonImage()
    }
}

extension MainTableViewCell {
    func addLongGesture(target: Any, action: Selector) {
        guard let array = gestureRecognizers, let gesture = array.first else { return }
        gesture.addTarget(target, action: action)
    }
}
