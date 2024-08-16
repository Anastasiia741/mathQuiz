//  StackViews.swift
//  mathQuiz
//  Created by Анастасия Набатова on 16/8/24.

import UIKit

final class StackViews: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.axis = .vertical
        self.spacing = 8
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
