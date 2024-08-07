//  QuizView.swift
//  mathQuiz
//  Created by Анастасия Набатова on 9/4/24.

import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: QuizViewModel
    @State private var showAlert = false
    
    init(theme: String) {
        self.viewModel = QuizViewModel(theme: theme)
    }
    
    var body: some View {
        ZStack {
            Color("MainView")
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    ReusableText(text: "Topic: \(viewModel.selectedTheme ?? "")", size: 18)
                        .padding(.vertical)
                    ReusableText(text: "Question \(viewModel.model.currentQuestionIndex + 1)/\(viewModel.data.count)", size: 20)
                } .padding()
                 .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Colors.nameView.opacity(0.75))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white, lineWidth: 4)
                    )
                if viewModel.model.quizCompleted {
                    QuizCompletedView(viewModel: viewModel)
                } else {
                    VStack{
                        Spacer()
                        ReusableText(text: viewModel.model.quizModel.question, size: 24)
                        Spacer()
                    }
                }
                Spacer()
                if !viewModel.model.quizCompleted {
                    OptionsGridView(viewModel: viewModel)
                        .padding(.bottom, 20)
                }
            }
        }
        .onDisappear {
            showAlert = true
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Exit Quiz"),
                message: Text("Are you sure you want to exit the quiz?"),
                primaryButton: .default(Text("Yes")) {
                    self.viewModel.restartGame()
                },
                secondaryButton: .cancel()
            )
        }
    }
}

