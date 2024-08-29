//  Question.swift
//  mathQuiz
//  Created by Анастасия Набатова on 10/4/24.

import Foundation
import SwiftUI

struct Quiz {
    let id: UUID
    var currentQuestionIndex: Int
    var quizModel: QuizModel
    var quizCompleted: Bool = false
    var quizWinningStatus: Bool = false
}

struct QuizModel {
    var theme: String
    var question: String
    var answer: String
    var description: String?
    var optionsList: [QuizOption]
}

struct QuizOption : Identifiable {
    var id: Int
    var optionId: String
    var option: String
    var color: Color
    var isSelected : Bool = false
    var isMatched : Bool = false
}

