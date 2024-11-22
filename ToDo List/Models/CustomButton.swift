//
//  CustomButton.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 18.11.2024.
//

import UIKit

final class CustomButton: UIView {
    private let label = UILabel(text: nil, textColor: .custom.black, font: UIFont.systemFont(ofSize: 17, weight: .semibold), textAlignment: .left, numberOfLines: 0)
    private let button = UIButton()

    init() {
        super.init(frame: .infinite)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let lineView = UIView()
        lineView.backgroundColor = .custom.grayLighter
        
        let baseView = UIView()
        baseView.backgroundColor = .custom.lightGray.withAlphaComponent(0.8)
        baseView.addSubviews(label, button)
        
        let stackViewForBase = UIStackView(axis: .vertical, spacing: 0, alignment: .fill, distribution: .equalSpacing, arrangedSubviews: baseView, lineView)
        
        addSubviews(stackViewForBase)
        stackViewForBase.fullConstraint()

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 11),
            label.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -11),

            button.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 14),
            button.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8),
            button.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -14),
            
            lineView.heightAnchor.constraint(equalToConstant: 0.3)
        ])
    }

    func addTarget(_ target: Any?, action: Selector) {
        button.addTarget(target, action: action, for: .touchUpInside)
    }

    func setupTextLabel(dateText: String, font: UIFont? = nil, textColor: UIColor? = nil) {
        label.text = dateText
        label.font = font
        label.textColor = textColor
    }

    func setupImageOnButton(image: String) {
        button.setImage(UIImage(named: image), for: .normal)
    }
}
