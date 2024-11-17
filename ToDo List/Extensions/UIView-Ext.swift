//
//  UIView-Ext.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 17.11.2024.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func fullConstraint(top: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0, bottom: CGFloat = 0) {
        guard let superview = self.superview else { return }
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailing),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottom),
        ])
    }
    
    var cornerRadius: CGFloat {
        get { return layer.cornerRadius}
        set {
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
    }
}
