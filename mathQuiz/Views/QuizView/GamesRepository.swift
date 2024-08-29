//  GamesRepository.swift
//  mathQuiz
//  Created by Анастасия Набатова on 29/8/24.

import Foundation

protocol GameRepository {
    
    func save(_ games: [QuizResult])
    func retrieve() -> [QuizResult]
    
    
}

final class GamesRepository: GameRepository {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func save(_ games: [QuizResult]) {
        do {
            let data = try encoder.encode(games)
            UserDefaults.standard.set(data, forKey: Accesses.keyHistory)
        } catch {
            print(error)
        }
    }
    
    func retrieve() -> [QuizResult] {
        guard let data = UserDefaults.standard.data(forKey: Accesses.keyHistory) else { return [] }
        do {
            let array = try decoder.decode(Array<QuizResult>.self, from: data)
            return array
        } catch {
            print(error)
        }
        return []
    }
    
}
