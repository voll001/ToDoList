//
//  ViewController.swift
//  LearnToDoList
//
//  Created by Оля on 08.02.2021.
//

import UIKit
import SnapKit

class AuthViewController: UIViewController {
    // MARK:
    private let edjeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    // MARK: GIU Variables
    private lazy var mainView: AuthView = {
        let view = AuthView()
        view.setTitle(with: "My best greetings")
        view.continueButton.setTitle("Continue", for: .normal)
        view.action = { [weak self] (profile) in
            self?.openToDoList(for: profile)
        }
        
        return view
    }()
    
    // MARK: Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        self.view.addSubview(self.mainView)
        self.mainView.setImage(with: "foto")
        
        self.constraints()
        
    }
    
    // MARK: Constraints
    private func constraints() {
        self.mainView.snp.updateConstraints() { (make) in
            make.left.right.greaterThanOrEqualToSuperview().inset(self.edjeInsets)
            make.center.equalToSuperview()
            
        }
    }

    // MARK: Methods
    private func openToDoList(for profile: Profile) {
        let vc = TodoListViewController()
        vc.set(with: profile)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

