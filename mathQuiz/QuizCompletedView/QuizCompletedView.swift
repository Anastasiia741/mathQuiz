//  QuizCompletedView.swift
//  mathQuiz
//  Created by Анастасия Набатова on 10/4/24.

import SwiftUI

struct QuizCompletedView: View {
    var viewModel: QuizViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "gamecontroller.fill")
                .foregroundColor(Color.yellow)
                .font(.system(size: 60))
                .padding()
            ReusableText(text: viewModel.model.quizWinningStatus ?
                         "THAT'S A WRAP" :
                            "GAME OVER",
                         size: 30)
                .padding()
            ReusableText(text: viewModel.model.quizWinningStatus
                         ? "Thank you for playing!!"
                         : "Better luck next time",
                         size: 30)
                .padding()
            Button {
                viewModel.restartGame()
            } label: {
                HStack {
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                        .padding()
                    Text("Play Again")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                }
            }.frame(width: 300, height: 60, alignment: .center)
                .background(.purple.opacity(0.7))
                .cornerRadius(30)
                .padding()
        }
    }
}
