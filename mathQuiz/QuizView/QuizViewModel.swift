//  QuizViewModel.swift
//  mathQuiz
//  Created by Анастасия Набатова on 10/4/24.

import SwiftUI

class QuizViewModel: ObservableObject {
    @Published var model: Quiz
    @State var selectedTheme: String?
    var data: [QuizModel]
    static var currentIndex = 0

    init(theme: String) {
        self.data = QuizViewModel.quizData.filter { $0.theme == theme }
        self.selectedTheme = theme
        self.model = QuizViewModel.createQuizModel(i: QuizViewModel.currentIndex, data: self.data)
    }

    static func createQuizModel(i: Int, data: [QuizModel]) -> Quiz {
        guard !data.isEmpty else {
            return Quiz(currentQuestionIndex: i, quizModel: QuizModel(theme: "", question: "", answer: "", optionsList: []), quizCompleted: true, quizWinningStatus: false)
        }
        if i < data.count {
            return Quiz(currentQuestionIndex: i, quizModel: data[i], quizCompleted: false)
        } else {
            return Quiz(currentQuestionIndex: i, quizModel: data.last!, quizCompleted: true, quizWinningStatus: false)
        }
    }
    
    func verifyAnswer(selectedOption: QuizOption) {
        for index in model.quizModel.optionsList.indices {
            model.quizModel.optionsList[index].isMatched = false
            model.quizModel.optionsList[index].isSelected = false
        }
        if let index = model.quizModel.optionsList.firstIndex(where: {$0.optionId == selectedOption.optionId}) {
            if selectedOption.optionId ==  model.quizModel.answer {
                model.quizModel.optionsList[index].isMatched = true
                model.quizModel.optionsList[index].isSelected = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if(QuizViewModel.currentIndex < QuizViewModel.quizData.count - 1) {
                       QuizViewModel.currentIndex += 1
                        self.model = QuizViewModel.createQuizModel(i: QuizViewModel.currentIndex, data: self.data)
                    }else {
                        self.model.quizCompleted = true
                        self.model.quizWinningStatus = true
                    }
                }
            } else {
                model.quizModel.optionsList[index].isMatched = false
                model.quizModel.optionsList[index].isSelected = true
            }
            
        }
    }
    
    func restartGame() {
        QuizViewModel.currentIndex = 0
        model = QuizViewModel.createQuizModel(i: QuizViewModel.currentIndex, data: self.data)
    }
}
