//  ReusableText.swift
//  mathQuiz
//  Created by Анастасия Набатова on 10/4/24.

import SwiftUI
import AVFoundation

enum FontStyle {
    case regular, bold
    
    var fontName: String {
        switch self {
        case .regular:
            return "Arial Rounded MT"
        case .bold:
            return "Arial Rounded MT Bold"
        }
    }
}

enum colorStyle {
    case black, gray, white, green
    
    var color: Color {
        switch self {
        case .black:
            return .nameView
        case .gray:
            return .gray
        case .white:
            return .white
        case .green:
            return .greenScope
        }
    }
}

struct TextView: View {
    var text: String
    var size: CGFloat
    var style: FontStyle
    var colorStyle: colorStyle
    
    var body: some View {
        Text(text)
            .font(.custom(style.fontName, size: size))
            .foregroundColor(colorStyle.color)
    }
}

