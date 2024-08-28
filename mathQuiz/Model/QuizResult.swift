//  QuizResult.swift
//  mathQuiz
//  Created by Анастасия Набатова on 16/8/24.

import Foundation

struct QuizResult: Codable {
    let date: Date
    let theme: String
    var totalQuestions: Int
    let totalAnswers: Int
    var correctAnswers: Int
    let incorrectAnswers: Int
    var score: Int
}
