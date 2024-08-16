//  QuizResult.swift
//  mathQuiz
//  Created by Анастасия Набатова on 16/8/24.

import Foundation

struct QuizResult: Codable {
    let date: Date
    let theme: String
    let totalQuestions: Int
    let totalAnswers: Int
    let correctAnswers: Int
    let incorrectAnswers: Int
    let score: Int
}
