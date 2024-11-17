//
//  UIStackView-Ext..swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 17.11.2024.
//

import UIKit

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis, spacing: CGFloat, alignment: UIStackView.Alignment, distribution: UIStackView.Distribution, arrangedSubviews: UIView...) {
        self.init()
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
        self.backgroundColor = .clear
        
        for view in arrangedSubviews {
            self.addArrangedSubview(view)
        }
    }
    
    convenience init(axis: NSLayoutConstraint.Axis, spacing: CGFloat, alignment: UIStackView.Alignment, distribution: UIStackView.Distribution, arrangedSubviews: [UIView]) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
        self.backgroundColor = .clear

    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach({
            addArrangedSubview($0)
        })
    }
}
