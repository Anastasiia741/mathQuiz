//  GameHistoryCell.swift
//  mathQuiz
//  Created by Анастасия Набатова on 14/8/24.

import UIKit
import SnapKit

class GameHistoryCell: UITableViewCell {
    static let reuseId = Accesses.gameHistoryCell
    private let containerView = Views()
    private let resultView = Labels(style: .scope)
    private let topicView = Labels(style: .result)
    private let questionsView = Labels(style: .result)
    private let scopeLabel = Labels(style: .result)
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topicView, questionsView, scopeLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GameHistoryCell {
    func configure(with result: QuizResult) {
        let score = Int(result.score)
        resultView.text = "\(Int(result.score))%"
        topicView.text = result.theme
        questionsView.text = "Questions \(result.correctAnswers)/\(result.totalQuestions)"
        scopeLabel.text = "Scope \(result.score) %"
        
        let backgroundColor: UIColor
        switch score {
        case 0...50:
            backgroundColor = Colors.redScope
        case 51...70:
            backgroundColor = Colors.yellowScope
        case 71...100:
            backgroundColor = Colors.greenScope
        default:
            backgroundColor = UIColor.gray
        }
        resultView.backgroundColor = backgroundColor
    }
}

extension GameHistoryCell {
    
    func setupUI() {
        contentView.backgroundColor = UIColor(named: Colors.quizViewBackgroundUIKit)
        contentView.addSubview(containerView)
        containerView.addSubview(resultView)
        containerView.addSubview(infoStackView)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(10)
            make.left.equalTo(contentView).inset(20)
            make.right.equalTo(contentView).inset(20)
        }
        
        resultView.snp.makeConstraints { make in
            make.left.top.equalTo(containerView).inset(16)
            make.width.height.equalTo(50)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.left.equalTo(resultView.snp.right).offset(16)
            make.top.bottom.equalTo(containerView).inset(10)
            make.right.equalTo(containerView).inset(0)
        }
    }
}
