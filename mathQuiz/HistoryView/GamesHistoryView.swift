//  GameHistoryView.swift
//  mathQuiz
//  Created by Анастасия Набатова on 14/8/24.

import UIKit
import SwiftUI
import SnapKit

enum GameSection: Int, CaseIterable {
    case  data, data1, data2
}

final class GameHistoryView: UIViewController{
    private var titleLabel: UILabel = {
        let lable = UILabel()
        lable.text = "Games history"
        lable.textAlignment = .left
        lable.textColor = UIColor(named: "NameView")
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(GameHistoryCell.self, forCellReuseIdentifier: GameHistoryCell.reuseId)
        return tableView
    }()
    
    private let sectionTitles = ["24 January 2024", "2 February 2024", "13 March 2024"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
}


extension GameHistoryView: UITableViewDelegate, UITableViewDataSource {
    
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "QuizViewBackground")
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor(named: "QuizViewBackground")
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = GameSection(rawValue: section)
        switch section {
        case .data:
            return 3
        case .data1:
            return 2
        case .data2:
            return 1
        case nil:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameHistoryCell.reuseId, for: indexPath) as! GameHistoryCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

struct GameHistoryViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> GameHistoryView {
        return GameHistoryView()
    }
    
    func updateUIViewController(_ uiViewController: GameHistoryView, context: Context) {
    }
}
