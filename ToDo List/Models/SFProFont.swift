//
//  SFProFont.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 17.11.2024.
//

import Foundation

enum SFProFont: CaseIterable {
    case thin
    case light
    case regular
    case medium
    case semiBold
    case bold
    case extraBold
    case black
    
    var font: String {
        switch self {
        case .thin: return "SFPro-Thin"
        case .light: return "SFPro-Light"
        case .regular: return "SFPro-Regular"
        case .medium: return "SFPro-Medium"
        case .semiBold: return "SFPro-SemiBold"
        case .bold: return "SFPro-Bold"
        case .extraBold: return "SFPro-ExtraBold"
        case .black: return "SFPro-Black"
        }
    }
}
