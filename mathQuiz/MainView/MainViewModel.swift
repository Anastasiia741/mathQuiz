//  MainViewModel.swift
//  mathQuiz
//  Created by Анастасия Набатова on 9/4/24.

import Foundation

class MainViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var selectedTheme: String?
    @Published var themes: [String] = []

    init() {
        loadThemes()
    }
    
    func loadThemes() {
        themes = QuizViewModel.uniqueThemes
    }
    
    func saveUserData() {
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(selectedTheme, forKey: "topic")
    }
    
    func loadUserData() {
        name = UserDefaults.standard.string(forKey: "name") ?? ""
        selectedTheme = UserDefaults.standard.string(forKey: "topic")
    }
}
