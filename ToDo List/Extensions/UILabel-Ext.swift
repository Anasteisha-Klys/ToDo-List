//
//  UILabel-Ext.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 17.11.2024.
//

import UIKit

extension UILabel {
    convenience init(text: String?, textColor: UIColor? = nil, font: UIFont? = nil, textAlignment: NSTextAlignment? = nil, numberOfLines: Int? = nil) {
        self.init()
        self.text = text
        self.backgroundColor = .clear
        
        if let textColor = textColor {
            self.textColor = textColor
        }
        
        if let font = font {
            self.font = font
        }
        
        if let textAlignment = textAlignment {
            self.textAlignment = textAlignment
        }
        
        if let numberOfLines = numberOfLines {
            self.numberOfLines = numberOfLines
        }
        
    }
}
