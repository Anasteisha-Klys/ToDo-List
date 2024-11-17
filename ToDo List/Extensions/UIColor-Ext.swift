//
//  UIColor-Ext.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 17.11.2024.
//

import UIKit

extension UIColor {
    
    class var custom: CustomColor.Type { return CustomColor.self}
    
    class CustomColor {
        class var white: UIColor { return UIColor(named: "White") ?? .white }
        class var black: UIColor { return UIColor(named: "Black") ?? .black }
        class var red: UIColor { return UIColor(named: "Red") ?? .red }
        class var main: UIColor { return UIColor(named: "Main") ?? .yellow }
        class var gray: UIColor { return UIColor(named: "Gray") ?? .gray }
        class var lightGray: UIColor { return UIColor(named: "LightGray") ?? .gray }
        class var grayLighter: UIColor { return UIColor(named: "GrayLighter") ?? .gray }
    }
}
