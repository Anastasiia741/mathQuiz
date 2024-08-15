//  GameHistoryCell.swift
//  mathQuiz
//  Created by Анастасия Набатова on 14/8/24.

import UIKit
import SnapKit

class GameHistoryCell: UITableViewCell {
    
    static let reuseId = "GameHistoryCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(named: "GameHistoryBackground")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let resultView: UILabel = {
        let label = UILabel()
        label.text = "88%"
        label.textAlignment = .center
        label.backgroundColor = .yellow
        label.textColor = UIColor(named: "NameView")
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let topicView: UILabel = {
        let label = UILabel()
        label.text = "Fractions all questions"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(named: "NameView")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let questionsView: UILabel = {
        let label = UILabel()
        label.text = "questions 4/8"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(named: "NameView")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scopeLabel: UILabel = {
        let label = UILabel()
        label.text = "scope 0"
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = UIColor(named: "NameView")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
    func setupUI() {
        contentView.backgroundColor = UIColor(named: "QuizViewBackground")
        contentView.addSubview(containerView)
        containerView.addSubview(resultView)
        containerView.addSubview(infoStackView)
        infoStackView.addSubview(topicView)
        infoStackView.addSubview(questionsView)
        infoStackView.addSubview(scopeLabel)
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
