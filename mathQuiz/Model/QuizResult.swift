//  QuizResult.swift
//  mathQuiz
//  Created by Анастасия Набатова on 16/8/24.

import Foundation

struct QuizResult: Codable {
    let id: UUID
    let date: Date
    let theme: String
    var totalQuestions: Int
    var totalAnswers: Int
    var correctAnswers: Int
    var incorrectAnswers: Int
    var score: Int
}
