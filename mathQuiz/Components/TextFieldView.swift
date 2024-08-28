//  TextFieldView.swift
//  mathQuiz
//  Created by Анастасия Набатова on 28/8/24.

import SwiftUI

struct TextFieldView: View {
    @Binding var name: String
    
    var body: some View {
        TextField(name.isEmpty ? "Enter Your Name" : name, text: $name )
            .font(.custom("Arial Rounded MT Bold", size: 20))
            .foregroundColor(.nameView)
            .multilineTextAlignment(.center)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: .nameView, radius: 5, x: 0, y: 2)
            .padding(.horizontal , 20)
    }
}
