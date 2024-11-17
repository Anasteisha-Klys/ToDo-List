//
//  MainTableViewCell.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 17.11.2024.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    private let checkmarkButton = UIButton()
    private let nameNoteLabel = UILabel(text: "hello", textColor: .custom.white, font: UIFont(name: SFProFont.medium.font, size: 16), textAlignment: .left, numberOfLines: 0)
    private let miniNoteLabel = UILabel(text: "sjdkcsbbskbcsbcshbchkb", textColor: .custom.white, font: UIFont(name: SFProFont.bold.font, size: 12), textAlignment: .left, numberOfLines: 0)
    private let dateLabel = UILabel(text: "22/06/23", textColor: .custom.white, font: UIFont(name: SFProFont.regular.font, size: 12), textAlignment: .left, numberOfLines: 0)
    
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
        let generalStackView = UIStackView(axis: .horizontal, spacing: 8, alignment: .fill, distribution: .fillProportionally, arrangedSubviews: stackViewButton, stackViewNote)
        
        let baseView = UIView()
        contentView.addSubviews(baseView)
        baseView.fullConstraint()
        baseView.addSubviews(generalStackView, lineView)
        
        NSLayoutConstraint.activate([
            generalStackView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 12),
            generalStackView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 20),
            generalStackView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -20),
            
            lineView.topAnchor.constraint(equalTo: generalStackView.bottomAnchor, constant: 12),
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
    }
    
    @objc private func changeButton(_ sender: UIButton) {
        checkmarkButton.isSelected.toggle()
        updateButtonImage()
    }
}
