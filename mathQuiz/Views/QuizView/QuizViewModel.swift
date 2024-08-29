//  QuizViewModel.swift
//  mathQuiz
//  Created by Анастасия Набатова on 10/4/24.

import SwiftUI
import AVFoundation

final class QuizViewModel: ObservableObject {
    
    @Published var model: Quiz
    @State var selectedTheme: String?
    private var data: [QuizModel]
    var themeDescription: String {
        model.quizModel.description ?? "No description"
    }
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
    var correctAnswers = 0
    var incorrectAnswers = 0
    static var currentIndex = 0
    
    init(theme: String) {
        self.data = QuizViewModel.quizData.filter { $0.theme == theme }
        self.selectedTheme = theme
        self.model = QuizViewModel.createQuizModel(i: QuizViewModel.currentIndex, data: self.data)
    }
}

extension QuizViewModel {
    
    static func createQuizModel(i: Int, data: [QuizModel]) -> Quiz {
        guard !data.isEmpty else {
            return Quiz(id: UUID(), currentQuestionIndex: i, quizModel: QuizModel(theme: "", question: "", answer: "", optionsList: []), quizCompleted: true, quizWinningStatus: false)
        }
        if i < data.count {
            return Quiz(id: UUID(), currentQuestionIndex: i, quizModel: data[i], quizCompleted: false)
        } else {
            return Quiz(id: UUID(), currentQuestionIndex: i, quizModel: data.last!, quizCompleted: true, quizWinningStatus: false)
        }
    }
    
    func verifyAnswer(selectedOption: QuizOption) {
        if let index = model.quizModel.optionsList.firstIndex(where: { $0.optionId == selectedOption.optionId }) {
            
            guard !model.quizModel.optionsList[index].isSelected else {
                return
            }
            
            for i in model.quizModel.optionsList.indices {
                model.quizModel.optionsList[i].isMatched = false
                model.quizModel.optionsList[i].isSelected = false
            }
            
            if selectedOption.optionId == model.quizModel.answer {
                correctAnswers += 1
                model.quizModel.optionsList[index].isMatched = true
                SoundManager.instance.playSound(sound: .winner)
            } else {
                incorrectAnswers += 1
                SoundManager.instance.playSound(sound: .nope)
            }
            
            model.quizModel.optionsList[index].isSelected = true
            
            if model.currentQuestionIndex == data.count - 1 {
                self.saveGameResult()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if QuizViewModel.currentIndex < QuizViewModel.quizData.count - 1 {
                    QuizViewModel.currentIndex += 1
                    self.model = QuizViewModel.createQuizModel(i: QuizViewModel.currentIndex, data: self.data)
                } else {
                    self.model.quizCompleted = true
                    self.model.quizWinningStatus = self.calculateScore() > 50
                    self.saveGameResult()
                }
            }
        }
    }
    
    func restartGame() {
        QuizViewModel.currentIndex = 0
        correctAnswers = 0
        incorrectAnswers = 0
        model = QuizViewModel.createQuizModel(i: QuizViewModel.currentIndex, data: self.data)
    }
}

extension QuizViewModel {
    
    func calculateScore() -> Int {
        return (correctAnswers * 100) / data.count
    }
    
    func fetchResults() -> [QuizResult] {
        if let data = UserDefaults.standard.data(forKey: Accesses.keyHistory),
           let results = try? JSONDecoder().decode([QuizResult].self, from: data) {
            return results
        }
        return []
    }
    
    private func saveGameResult() {
        let result = QuizResult(
            id: model.id,
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
    
    private func saveResult(_ result: QuizResult) {
        var results = fetchResults()
        if !results.contains(where: { $0.date == result.date && $0.theme == result.theme && $0.id == result.id}) {
            results.append(result)
        }
        if let encoded = try? JSONEncoder().encode(results) {
            UserDefaults.standard.set(encoded, forKey: Accesses.keyHistory)
        }
    }
}
