//  Views.swift
//  mathQuiz
//  Created by Анастасия Набатова on 16/8/24.

import UIKit

final class Views: UIView {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor(named: "GameHistoryBackground")
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

