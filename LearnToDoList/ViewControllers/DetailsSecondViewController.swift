//
//  DetailsSecondViewController.swift
//  LearnToDoList
//
//  Created by Оля on 17.02.2021.
//

import UIKit
import SnapKit

class DetailsSecondViewController: UIViewController {
    // Enumeration:
    enum DetailsType {
        case create
        case edit
    }
    
    // MARK: Closures
    var saveAction: ((_ note: Note?) -> Void)?
    
    // MARK: Properties
    private var edgeInsetsForView = UIEdgeInsets(all: 20) {
        didSet {
            self.view.setNeedsUpdateConstraints()
        }
    }
    private var type: DetailsType
    private var modelAdded: Note?
    
   
    // MARK: GUI Variables
    private var scrollViewDetailes: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    private var mainViewDetailes: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        
    return view
    }()
    
    private var textFieldDetailes: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Title"
        textField.backgroundColor = .white
        
        return textField
    }()
    
    private var descriptionTextView: UITextView = {
        let description = UITextView()
        description.textColor = .black
        description.backgroundColor = .white
        
        return description
    }()
   
    private var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.setTitle("save", for: .normal)
        button.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: Initialization
    init(type: DetailsType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Navigation Bar
    
    private func setupNavigationBarDetails() {
        self.navigationItem.title = "Detailes2"
    }
    
    // MARK: Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.scrollViewDetailes)
        
        self.scrollViewDetailes.addSubview(self.mainViewDetailes)
        self.mainViewDetailes.addSubviews([self.descriptionTextView,
                                           self.textFieldDetailes,
                                           self.saveButton])
        self.setupConstraintsToController()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.setupNavigationBarDetails()
    }
    
    //  MARK: Constraints
    func setupConstraintsToController() {
        self.scrollViewDetailes.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.mainViewDetailes.snp.makeConstraints { (make) in
            make.size.edges.equalToSuperview()
        }
        
        self.textFieldDetailes.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(20)
            make.right.greaterThanOrEqualToSuperview().inset(self.edgeInsetsForView)
            make.height.equalTo(50)
        }
        
        self.descriptionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(self.textFieldDetailes.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(20)
            make.right.greaterThanOrEqualToSuperview().inset(self.edgeInsetsForView)
            make.height.equalTo(150)
        }
        
        self.saveButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.descriptionTextView.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(self.edgeInsetsForView)
            make.height.equalTo(50)
        }
        
    }
    
    // MARK: Setter
    func setNote(with modelAdded: Note) {
        self.modelAdded = modelAdded
        
        if let modelAdded = self.modelAdded {
            self.textFieldDetailes.text = modelAdded.title
            self.descriptionTextView.text = modelAdded.description
        }
        self.view.setNeedsUpdateConstraints()
    }
    
    // MARK: Actions
    @objc func saveButtonAction() {
        self.modelAdded?.title = self.textFieldDetailes.text ?? "Title"
        self.modelAdded?.description = self.descriptionTextView.text ?? "Description"
        self.saveAction?(modelAdded)
        
        self.dismiss(animated: true)
    }
}
