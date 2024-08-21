//  GameHistoryView.swift
//  mathQuiz
//  Created by Анастасия Набатова on 14/8/24.

import UIKit
import SwiftUI

enum GameSection: Int, CaseIterable {
    case  data, data1, data2
}

final class GameHistoryView: UIViewController{
    private var viewModel = GameHistoryViewModel()
    private var titleLabel = Labels(style: .history)
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
    
    private lazy var placeholderView: PlaceholderView = {
        let view = PlaceholderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.buttonAction = { [weak self] in
            self?.closeScreen()
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        updateView()
    }
}

private extension GameHistoryView {
    
    func setupUI() {
        view.backgroundColor = UIColor(named: Colors.quizViewBackgroundUIKit)
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(placeholderView)
        tableView.backgroundColor = UIColor(named: Colors.quizViewBackgroundUIKit)
        tableView.reloadData()
        updateView()
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        placeholderView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func updateView() {
        let hasGameHistory = !viewModel.groupedResults.isEmpty
        tableView.isHidden = !hasGameHistory
        placeholderView.isHidden = hasGameHistory
    }
    
    @objc private func closeScreen() {
        dismiss(animated: true, completion: nil)
    }
}

extension GameHistoryView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        updateView()
        return viewModel.groupedResults.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.groupedResults[section].date
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.groupedResults[section].results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameHistoryCell.reuseId, for: indexPath) as! GameHistoryCell
        let quizResult = viewModel.groupedResults[indexPath.section].results[indexPath.row]
        cell.selectionStyle = .none
        cell.configure(with: quizResult)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            
            let alert = UIAlertController(title: "", message: "Are you sure you want to delete this entry?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
                completionHandler(false)
            })
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
                self.viewModel.removeResult(at: indexPath)
                self.updateView()
                tableView.reloadData()
                completionHandler(true)
            })
            self.present(alert, animated: true, completion: nil)
        }
        
        let trashIcon = UIImage(systemName: "trash")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        deleteAction.image = trashIcon
        deleteAction.backgroundColor = UIColor(named: Colors.quizViewBackgroundUIKit)?.withAlphaComponent(0.5)
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        tableView.reloadData()
        return configuration
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


