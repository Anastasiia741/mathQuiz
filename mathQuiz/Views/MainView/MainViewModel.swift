//  MainViewModel.swift
//  mathQuiz
//  Created by Анастасия Набатова on 9/4/24.

import Foundation

final class MainViewModel: ObservableObject {
    let quizViewModel = QuizViewModel(theme: "")
    @Published var name: String = ""
    @Published var selectedTopic: String?
    @Published var themes: [String] = []
    @Published var totalCorrectAnswers = 0
    @Published var totalScore = 0
    
    init() {
        loadThemes()
        loadGameHistory()
    }
    
    func loadThemes() {
        themes = QuizViewModel.uniqueThemes
    }
    
    func saveUserData() {
        UserDefaults.standard.set(name, forKey: Accesses.name)
        UserDefaults.standard.set(selectedTopic, forKey: Accesses.topic)
    }
    
    func loadUserData() {
        name = UserDefaults.standard.string(forKey: Accesses.name) ?? ""
        selectedTopic = UserDefaults.standard.string(forKey: Accesses.topic)
    }
    
    func loadGameHistory() {
        let results = quizViewModel.fetchResults()
        totalCorrectAnswers = results.reduce(0) { $0 + $1.correctAnswers }
        totalScore = results.reduce(0) { $0 + $1.score }
    }
}
