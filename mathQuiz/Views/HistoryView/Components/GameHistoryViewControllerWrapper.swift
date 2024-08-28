//  GameHistoryViewControllerWrapper.swift
//  mathQuiz
//  Created by Анастасия Набатова on 16/8/24.

import SwiftUI

struct GameHistoryViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> GameHistoryView {
        return GameHistoryView()
    }
    
    func updateUIViewController(_ uiViewController: GameHistoryView, context: Context) {
    }
}
