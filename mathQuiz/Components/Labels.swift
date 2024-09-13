//  Labels.swift
//  mathQuiz
//  Created by Анастасия Набатова on 16/8/24.

import UIKit

enum TitleType {
    case scope, result, history
}

final class Labels: UILabel {
    
    init(style: TitleType) {
        super.init(frame: .zero)
        commonInit(style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(_ style: TitleType) {
        switch style {
        case .scope:
            self.text = "88%"
            self.textAlignment = .center
            self.backgroundColor = .yellow
            self.textColor = UIColor(named: "nameView")
            self.layer.cornerRadius = 12
            self.layer.masksToBounds = true
            self.translatesAutoresizingMaskIntoConstraints = false
        case .result:
            self.text = "Fractions all questions"
            self.textAlignment = .left
            self.font = .systemFont(ofSize: 12)
            self.textColor = UIColor(named: "nameView")
            self.translatesAutoresizingMaskIntoConstraints = false
        case .history:
            self.text = "Games history"
            self.textAlignment = .left
            self.textColor = UIColor(named: "nameView")
            self.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
