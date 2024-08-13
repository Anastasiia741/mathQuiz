//  MainCoordinator.swift
//  mathQuiz
//  Created by Анастасия Набатова on 9/8/24.

import SwiftUI

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?

    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = MainViewModel()
        let mainView = MainView(viewModel: viewModel, coordinator: MainCoordinator())
        let hostingController = UIHostingController(rootView: mainView.environmentObject(viewModel))
        navigationController?.setViewControllers([hostingController], animated: false)
    }
    
    func showHistory() {
        let historyView = HistoryView()
        let hostingController = UIHostingController(rootView: historyView)
        navigationController?.pushViewController(hostingController, animated: true)
    }
}
