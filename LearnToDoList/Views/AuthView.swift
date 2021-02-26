//
//  AuthView.swift
//  LearnToDoList
//
//  Created by Оля on 08.02.2021.
//

import UIKit
import SnapKit

class AuthView: UIView {
    // MARK: Closures
    var action: ((Profile) -> Void)?
    
    // MARK: Variables
    private let imageSize = CGSize(width: 150, height: 150)
    private let edjeInsets = UIEdgeInsets(all: 20)
    
    // MARK: GUI VAriables
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
       return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var textField: UITextField = {
       let textfield = UITextField()
        textfield.placeholder = "Enter User name"
        textfield.backgroundColor = .white
        textfield.clearButtonMode = .whileEditing
        
        return textfield
    }()
    
    private lazy var textFieldPassword: UITextField = {
       let textfield = UITextField()
        textfield.placeholder = "Enter Password"
        textfield.backgroundColor = .white
        textfield.clearButtonMode = .whileEditing

        return textfield
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        return button
    }()

    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        self.backgroundColor = .gray
        
        self.addSubviews([self.imageView, self.titleLabel, self.textField, self.continueButton, self.textFieldPassword])
        
        self.constraints()
    }
    
    
    // MARK: Constraints
    private func constraints() {
        self.imageView.snp.updateConstraints { (make) in
            make.centerX.equalToSuperview()
            make.size.equalTo(self.imageSize)
            make.top.equalToSuperview().inset(self.edjeInsets.top)
        }
        
        self.titleLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.imageView.snp.bottom).offset(20)
            make.left.right.greaterThanOrEqualToSuperview().inset(self.edjeInsets)
            make.centerX.equalToSuperview()
        }
        
        self.textField.snp.updateConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(self.edjeInsets)
            make.height.equalTo(50)        }
        
        self.continueButton.snp.updateConstraints { (make) in
            make.top.equalTo(self.textFieldPassword.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        self.textFieldPassword.snp.updateConstraints { (make) in
            make.top.equalTo(self.textField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    // MARK: Methods
    func setImage(with imageName: String) {
        self.imageView.image = UIImage(named: imageName)
        
        self.setNeedsUpdateConstraints()
    }
    
    func setTitle(with text: String) {
        self.titleLabel.text = text
        
        self.setNeedsUpdateConstraints()
    }

    // MARK: Actiom
    @objc private func buttonPressed() {
        guard let username = self.textField.text, !username.isEmpty,
              let password = self.textFieldPassword.text, !password.isEmpty
        else { return }
        var profile = Profile(username: username, password: password, age: nil, profileImage: "foto", sex: nil)
        profile.profileImage = "foto"
        self.action?(profile)
    }
}

// user default

