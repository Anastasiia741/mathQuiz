//  ImageView.swift
//  mathQuiz
//  Created by Анастасия Набатова on 28/8/24.

import SwiftUI

struct ImageView: View {
    var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 25)
            .foregroundColor(.nameView)
    }
}
