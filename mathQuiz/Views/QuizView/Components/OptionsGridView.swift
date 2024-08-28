//  OptionsGridView.swift
//  mathQuiz
//  Created by Анастасия Набатова on 10/4/24.

import SwiftUI

struct OptionsGridView: View {
    var viewModel = QuizViewModel(theme: "")
    @State private var quizRecord =  QuizViewModel.quizData[0]
    
    var columns: [GridItem] = [GridItem(.flexible(), spacing: 20)]
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.model.quizModel.optionsList) { quizOption in
                    OptionCardView(quizOption: quizOption)
                        .onTapGesture {
                            viewModel.verifyAnswer(selectedOption: quizOption)
                        }
                }
            }.padding(.horizontal)
        }
    }
}

