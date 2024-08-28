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
            TextView(text: viewModel.model.quizWinningStatus ?
                         "THAT'S A WRAP" :
                            "GAME OVER",
                     size: 30, style: .regular, colorStyle: .black)
                .padding()
            VStack(spacing: 10) {
                TextView(text: "Correct Answers: \(viewModel.correctAnswers)", size: 20, style: .regular, colorStyle: .black)
                TextView(text: "Incorrect Answers: \(viewModel.incorrectAnswers)", size: 18, style: .regular, colorStyle: .black)
                TextView(text: "Score: \(viewModel.calculateScore())%", size: 18, style: .regular, colorStyle: .black)
            }
            .padding()
            TextView(text: viewModel.model.quizWinningStatus
                         ? "Thank you for playing!!"
                         : "Better luck next time",
                     size: 30, style: .regular, colorStyle: .black)
                .padding()
            Button {
                viewModel.restartGame()
            } label: {
                HStack {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
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
