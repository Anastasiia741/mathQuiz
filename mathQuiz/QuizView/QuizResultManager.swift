//  QuizResultManager.swift
//  mathQuiz
//  Created by Анастасия Набатова on 16/8/24.

import Foundation

class QuizResultManager {
    static let shared = QuizResultManager()
    private let resultsKey = "quizResults"
    
    func saveResult(_ result: QuizResult) {
        var results = fetchResults()
        results.append(result)
        if let encoded = try? JSONEncoder().encode(results) {
            UserDefaults.standard.set(encoded, forKey: resultsKey)
        }
    }
    
    func fetchResults() -> [QuizResult] {
        if let data = UserDefaults.standard.data(forKey: resultsKey),
           let results = try? JSONDecoder().decode([QuizResult].self, from: data) {
            return results
        }
        return []
    }
}
