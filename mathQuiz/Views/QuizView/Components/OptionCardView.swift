//  OptionCardView.swift
//  mathQuiz
//  Created by Анастасия Набатова on 23/5/24.

import SwiftUI

struct OptionCardView : View {
    
    var quizOption: QuizOption
    var body: some View {
        VStack {
            if (quizOption.isMatched) && (quizOption.isSelected) {
                OptionStatusImageView(imageName: Images.checkmark, color: .green)
            } else if (!(quizOption.isMatched) && (quizOption.isSelected)) {
                OptionStatusImageView(imageName: Images.xmark, color: .red)
            } else {
                OptionView(quizOption: quizOption)
            }
        }
        .font(.custom("Arial Rounded MT", size: 16))
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity, minHeight: 50)
        .background(setBackgroundColor())
        .cornerRadius(25)
        .shadow(color: .nameView, radius: 2, x: 0, y: 2)
    }
    
    func setBackgroundColor() -> AnyView {
        if (quizOption.isMatched) && (quizOption.isSelected) {
            return AnyView(Colors.yellowButton)
        } else if (!(quizOption.isMatched) && (quizOption.isSelected)) {
            return AnyView(Colors.redButton)
        } else {
            return AnyView(LinearGradient(gradient: Gradient(colors: [Colors.blueButton, Colors.topicButtom]), startPoint: .bottom, endPoint: .top))
        }
    }
}

struct OptionView: View {
    var quizOption: QuizOption
    var body: some View {
        TextView(text: quizOption.option, size: 20, style: .bold, colorStyle: .white)
            .shadow(color: Colors.nameView, radius: 2, x: 0, y: 2)
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
