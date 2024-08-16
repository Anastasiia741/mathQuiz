//  QuizViewModel.swift
//  mathQuiz
//  Created by Анастасия Набатова on 10/4/24.

import SwiftUI
import AVFoundation

class QuizViewModel: ObservableObject {
    @Published var model: Quiz
    @State var selectedTheme: String?
    var data: [QuizModel]
    var progress: Double {
        let totalQuestions = Double(data.count)
        let currentQuestionIndex = Double(model.currentQuestionIndex)
        return max(0, min(currentQuestionIndex / totalQuestions, 1))
    }
    var currentQuestionIndexText: String {
        if model.quizCompleted {
            return "\(data.count)/\(data.count)"
        } else {
            return "\(model.currentQuestionIndex + 1)/\(data.count)"
        }
    }
    static var currentIndex = 0
    var correctAnswers = 0
    var incorrectAnswers = 0
    
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
        
        if let index = model.quizModel.optionsList.firstIndex(where: { $0.optionId == selectedOption.optionId }) {
            if selectedOption.optionId == model.quizModel.answer {
                correctAnswers += 1
                model.quizModel.optionsList[index].isMatched = true
                model.quizModel.optionsList[index].isSelected = true
                SoundManager.instance.playSound(sound: .winner)
            } else {
                incorrectAnswers += 1
                model.quizModel.optionsList[index].isSelected = true
                SoundManager.instance.playSound(sound: .nope)
            }
        }
        
        self.saveGameResult()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if QuizViewModel.currentIndex < QuizViewModel.quizData.count - 1 {
                QuizViewModel.currentIndex += 1
                self.model = QuizViewModel.createQuizModel(i: QuizViewModel.currentIndex, data: self.data)
            } else {
                self.model.quizCompleted = true
                self.model.quizWinningStatus = self.calculateScore() > 50
                
            }
        }
    }
    
    func calculateScore() -> Int {
        return (correctAnswers * 100) / data.count
    }
    
    func saveAnswerResult(isCorrect: Bool) {
    }
    
    func saveGameResult() {
        let result = QuizResult(
            date: Date(),
            theme: selectedTheme ?? "Unknown",
            totalQuestions: data.count,
            totalAnswers: correctAnswers + incorrectAnswers,
            correctAnswers: correctAnswers,
            incorrectAnswers: incorrectAnswers,
            score: calculateScore()
        )
        saveResult(result)
    }
    
    func saveResult(_ result: QuizResult) {
        var results = fetchResults()
        
        if !results.contains(where: { $0.date == result.date && $0.theme == result.theme }) {
            results.append(result)
        }
        
        if let encoded = try? JSONEncoder().encode(results) {
            UserDefaults.standard.set(encoded, forKey: Accesses.keyHistory)
        }
    }
    
    func fetchResults() -> [QuizResult] {
        if let data = UserDefaults.standard.data(forKey: Accesses.keyHistory),
           let results = try? JSONDecoder().decode([QuizResult].self, from: data) {
            return results
        }
        return []
    }
    
    func restartGame() {
        QuizViewModel.currentIndex = 0
        model = QuizViewModel.createQuizModel(i: QuizViewModel.currentIndex, data: self.data)
    }
}
