//  mathQuizApp.swift
//  mathQuiz
//  Created by Анастасия Набатова on 9/4/24.

import SwiftUI

@main
struct MathQuizApp: App {
    @StateObject private var viewModel = MainViewModel()
    var coordinator: MainCoordinator

    init() {
        let navigationController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navigationController)
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: viewModel, coordinator: coordinator)
                .environmentObject(viewModel)
                .onAppear {
                    coordinator.start()
                }
            
        }
    }
}
