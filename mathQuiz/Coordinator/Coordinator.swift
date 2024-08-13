//  Coordinator.swift
//  mathQuiz
//  Created by Анастасия Набатова on 9/8/24.

import SwiftUI

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator { get set }
}
