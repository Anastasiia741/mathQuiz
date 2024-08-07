//  ReusableText.swift
//  mathQuiz
//  Created by Анастасия Набатова on 10/4/24.

import SwiftUI

struct ReusableText: View {
    var text: String
    var size: CGFloat
    
    var body: some View {
        Text(text)
            .font(.custom("Arial Rounded MT", size: CGFloat(size)))
    }
}



