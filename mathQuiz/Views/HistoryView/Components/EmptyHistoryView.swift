//  PlaceholderView.swift
//  mathQuiz
//  Created by Анастасия Набатова on 20/8/24.

import UIKit

final class EmptyHistoryView: UIView {
    
    private let placeholderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "cat")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial Rounded MT", size: 18)
        label.textColor = UIColor(named: "NameView")
        label.text = "There are no games yet"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Let's get started", for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial Rounded MT", size: 18)
        button.setTitleColor(UIColor(named: "NameView"), for: .normal)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(named: "BlueButton")
        button.layer.shadowColor = UIColor(named: "NameView")?.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 3
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    var buttonAction: (() -> Void)?
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        backgroundColor = UIColor(named: Colors.nameViewUIKit)
        addSubview(placeholderView)
        placeholderView.addSubview(imageView)
        placeholderView.addSubview(label)
        placeholderView.addSubview(button)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        setupConstraints()
    }
    
    func setupConstraints() {
        
        placeholderView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(placeholderView)
            make.bottom.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
    }
    
    @objc private func buttonTapped() {
        buttonAction?()
    }
}
