//  MainViewModel.swift
//  mathQuiz
//  Created by Анастасия Набатова on 9/4/24.

import Foundation

class MainViewModel: ObservableObject {
    let historyViewModel = GameHistoryViewModel()
    
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
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(selectedTopic, forKey: "topic")
    }
    
    func loadUserData() {
        name = UserDefaults.standard.string(forKey: "name") ?? ""
        selectedTopic = UserDefaults.standard.string(forKey: "topic")
    }
    
    func loadGameHistory() {
        let results = historyViewModel.fetchResults()
        
        totalCorrectAnswers = results.reduce(0) { $0 + $1.correctAnswers }
        totalScore = results.reduce(0) { $0 + $1.score }
    }
}
