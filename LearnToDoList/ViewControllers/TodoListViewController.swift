//
//  SecondViewController.swift
//  LearnToDoList
//
//  Created by Оля on 08.02.2021.
//

import UIKit
import SnapKit

class  TodoListViewController: UIViewController {
    // MARK: Variables
    private var model: [Note] = []
    
    // MARK: GUI Variables
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        // Type 1
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TodoListTCellTableViewCell.self, forCellReuseIdentifier: TodoListTCellTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
       return tableView
    }()

    // MARK: Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Type 2
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
        
        self.view.addSubview(self.tableView)
        self.setupTableViewConstraints()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.setupNavigationBar()
    }
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        }
    
    // MARK Navigation Bar
    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(title: "Add",
                                        style: .plain,
                                        target: self,
                                        action: #selector(self.addButtonAction))
        
        
        let newButton = UIBarButtonItem(title: "New",
                                        style: .plain,
                                        target: self,
                                        action: #selector(self.newActionInButton))
        self.navigationItem.rightBarButtonItems = [addButton, newButton, self.editButtonItem].reversed()
    }
    
    // MARK: Methods
    func set(with profile: Profile) {
        self.navigationItem.title = "TODOLIST for \(profile.username)"
    }
    
    private func openEditViewController(with model: Note, and path: IndexPath) {
        let vc = DetailedViewController(type: .edit)
        vc.set(with: model)
        vc.closeAction = { [weak self] model in
            guard let self = self, let model = model else { return }
            self.model[path.row] = model
            self.tableView.reloadRows(at: [path], with: .automatic)
        }
        self.navigationController?.present(vc, animated: true, completion: nil)
        
    }
    
    private func openCreateViewController(with model: Note) {
        let vc = DetailsSecondViewController(type: .create)
        vc.setNote(with: model)
        vc.saveAction = { [weak self] model in
            guard let self = self, let model = model else {
                return
            }
          
        }
        self.navigationController?.present(vc, animated: true, completion: nil)
       
    }
    
    // MARK: Actions
    @objc private func addButtonAction() {
        self.tableView.performBatchUpdates {
            let newNote = Note(title: "New note",
                               description: "Note desctiption",
                               priority: .high,
                               date: Date())
            self.model.insert(newNote, at: 0)
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        } completion: { (success) in
            Swift.debugPrint("success add")
        }
    }
    
    @objc private func newActionInButton() {
        self.tableView.performBatchUpdates {
            let newNote = Note(title: "New Note",
                               description: "Note description",
                               priority: .low,
                               date: Date())
            self.model.insert(newNote, at: 0)
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        } completion: { (success) in
            Swift.debugPrint(success)
        }
        
        let vc = DetailsSecondViewController(type: .create)
        vc.saveAction = { [weak self] modelAdded in
            guard let self = self, let modelAdded = modelAdded else { return }
            
        }
        self.navigationController?.pushViewController(vc, animated: true)
   }
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: TodoListTCellTableViewCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? TodoListTCellTableViewCell {
            cell.set(title: self.model[indexPath.row].title,
                     description: self.model[indexPath.row].description,
                     date: Date())
            cell.setPriority(color: .red)
            cell.selectionStyle = .none
        }
        
        return cell
    }
    
    // Tap on cell to show information
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Swift.debugPrint(self.model[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    // Basic swipe gestures to open
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
//        switch editingStyle {
//        case .delete:
//            Swift.debugPrint("Delete")
//
//            self.tableView.performBatchUpdates({
//                self.model.remove(at: indexPath.row)
//                self.tableView.deleteRows(at: [indexPath], with: .automatic)
//            }, completion: { (isSuccess) in
//                Swift.debugPrint(isSuccess ? "Raw was deleted" : "Couldn't delete this row")
//            })
//
//        case.insert:
//            Swift.debugPrint("Try to insert calls")
//        default:
//            break
//
//        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Remove action
        let remove = UIContextualAction(style: .normal,
                                        title: "Remove") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            self.tableView.performBatchUpdates({
                self.model.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }, completion: { (isSuccess) in
                Swift.debugPrint(isSuccess ? "Raw was deleted" : "Couldn't delete this row")
                completionHandler(isSuccess)
            })
        }
        remove.backgroundColor = .systemRed
        
        //Edit action
        let edit = UIContextualAction(style: .normal,
                                      title: "Edit") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            self.openEditViewController(with: self.model[indexPath.row], and: indexPath)
            
            completionHandler(true)
        }
        edit.backgroundColor = .systemOrange
        return UISwipeActionsConfiguration(actions: [remove, edit])
    }
    
    // Move cells
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        self.tableView.setEditing(!self.tableView.isEditing, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self.model.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        
        print("\(sourceIndexPath.row) -> \(destinationIndexPath.row)")
        // TODO: save your model
        //self.tableView.reloadData()
    }
    
    
}
