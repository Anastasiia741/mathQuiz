//  GameHistoryViewModel.swift
//  mathQuiz
//  Created by Анастасия Набатова on 14/8/24.

import Foundation

final class GameHistoryViewModel: ObservableObject {
    @Published var gameResults: [QuizResult] = []
    var groupedResults: [(date: String, results: [QuizResult])] = []
    
    init(){
        loadGameResults()
    }
    
    func loadGameResults() {
        gameResults = fetchResults()
        groupResultsByDate()
    }
    
    private func groupResultsByDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        let groupedDictionary = Dictionary(grouping: gameResults) { result in
            dateFormatter.string(from: result.date)
        }
        groupedResults = groupedDictionary.map { (key: String, value: [QuizResult]) -> (date: String, results: [QuizResult]) in
            let sortedResults = value.sorted { $0.date > $1.date }
            return (date: key, results: sortedResults)
        }
        groupedResults.sort { $0.date > $1.date }
    }
    
    func fetchResults() -> [QuizResult] {
        if let data = UserDefaults.standard.data(forKey: Accesses.keyHistory),
           let results = try? JSONDecoder().decode([QuizResult].self, from: data) {
            return results
        }
        return []
    }
    
    func saveNewResults() {
        if let encoded = try? JSONEncoder().encode(gameResults) {
            UserDefaults.standard.set(encoded, forKey: Accesses.keyHistory)
        }
    }
    
    func removeResult(at indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        var resultsInSection = groupedResults[section].results
        resultsInSection.remove(at: row)
        if resultsInSection.isEmpty {
            groupedResults.remove(at: section)
        } else {
            groupedResults[section].results = resultsInSection
        }
        gameResults = groupedResults.flatMap { $0.results }
        saveNewResults()
    }
}
