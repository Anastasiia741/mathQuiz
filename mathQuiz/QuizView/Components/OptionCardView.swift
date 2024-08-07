//  OptionCardView.swift
//  mathQuiz
//  Created by Анастасия Набатова on 23/5/24.

import SwiftUI

struct OptionCardView : View {
    var quizOption: QuizOption
    var body: some View {
        VStack {
            if (quizOption.isMatched) && (quizOption.isSelected) {
                OptionStatusImageView(imageName: "checkmark", color: .green)
            } else if (!(quizOption.isMatched) && (quizOption.isSelected)) {
                OptionStatusImageView(imageName: "xmark", color: .red)
            } else {
                OptionView(quizOption: quizOption)
            }
        }
        .font(.custom("Arial Rounded MT Bold", size: 16))
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity, minHeight: 50)
        .background(LinearGradient(gradient: Gradient(colors: [Colors.blueButton, Colors.quizViewBackground]), startPoint: .bottom, endPoint: .top))
        .background(setBackgroundColor())
        .cornerRadius(25)
        .shadow(color: Colors.nameView, radius: 2, x: 0, y: 2)
    }
    
    func setBackgroundColor() -> AnyView {
        if (quizOption.isMatched) && (quizOption.isSelected) {
            return AnyView(Color.green)
        } else if (!(quizOption.isMatched) && (quizOption.isSelected)) {
            return AnyView(Color.red)
        } else {
            return AnyView(LinearGradient(gradient: Gradient(colors: [Colors.blueButton, Colors.quizViewBackground]), startPoint: .bottom, endPoint: .top))
        }
    }
}

struct OptionView: View {
    var quizOption: QuizOption
    var body: some View {
        Text(quizOption.option)
            .frame(width: 150, height: 38)
            .font(.system(size: 20, weight: .bold, design: .rounded))
    }
}

struct OptionStatusImageView: View {
    var imageName: String
    var color: Color
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 24, height: 24)
            .foregroundColor(color)
    }
}
