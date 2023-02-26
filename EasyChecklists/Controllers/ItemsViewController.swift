//
//  ViewController.swift
//  ToDoList
//
//  Created by Dawid Łabno on 16/11/2022.
//

import UIKit
import SnapKit
import RealmSwift
import L10n_swift

final class ItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var checklistItems: Results<Task>?
    // swiftlint:disable:next force_try
    let realm = try! Realm()
    
    var selectedCategory: Checklist? {
        didSet {
            loadItems()
        }
    }
    
    let customView = CustomView()
    var changedTextField: UITextField?
    
    private let color = Color()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(
            string: L10n.addItemTextFieldPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        textField.backgroundColor = .white
        textField.clearsOnBeginEditing = true
        textField.borderStyle = .roundedRect
        textField.adjustsFontSizeToFitWidth = true
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(CustomTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray6
        
        return tableView
    }()
    
    private let box = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        navigationItem.title = selectedCategory?.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: L10n.itemsViewEditButton,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(tapEditButton(sender: )))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        if let colorName = selectedCategory?.color {
            box.backgroundColor = color.colors[colorName]
        } else {
            box.backgroundColor = .systemGray6
        }
        
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(box)
        
        box.snp.makeConstraints { make -> Void in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.top.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.snp.left).offset(5)
            make.right.equalTo(view.snp.right).offset(-5)
        }
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(12)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        checklistItems?.count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell: CustomTableViewCell = tableView.dequeue(cellForRowAt: indexPath)
        else {
            return UITableViewCell()
        }
        
        tableView.rowHeight = 50
        cell.taskTitle.text = checklistItems?[indexPath.row].title
        cell.taskTitle.numberOfLines = 0
        cell.taskTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        if let currentCategory = selectedCategory {
            cell.completed.tintColor = color.colors[currentCategory.color]
        }
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        cell.selectedBackgroundView = backgroundView
        
        if checklistItems?[indexPath.row].done == true {
            cell.completed.isSelected = true
            cell.taskTitle.textColor = .systemGray
        } else {
            cell.completed.isSelected = false
            if traitCollection.userInterfaceStyle == .light {
                cell.taskTitle.textColor = .black
            } else {
                cell.taskTitle.textColor = .white
            }
        }
        
        cell.completed.addTarget(self,
                                 action: #selector((tapCompletedButton(sender:))),
                                 for: .touchUpInside)
        
        cell.deleteButton.addTarget(self,
                              action: #selector((tapDeleteButton(sender:))),
                              for: .touchUpInside)
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath,
                              animated: true)
        
        let selectedItem = checklistItems?[indexPath.row].title
        let alert = UIAlertController(title: L10n.editItemAlertTitle,
                                      message: L10n.editItemAlertMessage,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: L10n.editItemUpdateButton,
                                      style: UIAlertAction.Style.default,
                                      handler: {_ in
            let updatedItem = self.changedTextField?.text
            do {
                try self.realm.write {
                    self.checklistItems?[indexPath.row].title = updatedItem!
                }
            } catch {
                print("Error saving done status \(error)")
            }
            self.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: L10n.editItemCancelButton,
                                      style: UIAlertAction.Style.default,
                                      handler: nil))
        
        alert.addTextField { textField in
            self.changedTextField = textField
            self.changedTextField?.placeholder = L10n.editItemTextFieldPlaceholder
            self.changedTextField?.text = selectedItem
            
        }
        
       present(alert, animated: true, completion: nil)
    }
    
    @objc func tapCompletedButton(sender: UIButton) {
        if let superview = sender.superview, let cell = superview.superview as? CustomTableViewCell {
            if let indexPath = tableView.indexPath(for: cell) {
                if checklistItems?[indexPath.row].done == false {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                }
                
                if let task = checklistItems?[indexPath.row] {
                    do {
                        try realm.write {
                            task.done = !task.done
                        }
                    } catch {
                        print("Error saving done status \(error)")
                    }
                }
                reloadData()
            }
        }
    }
    
    @objc func tapDeleteButton(sender: UIButton) {
        if let superview = sender.superview, let cell = superview.superview as? CustomTableViewCell {
            if let indexPath = tableView.indexPath(for: cell) {
                if let task = checklistItems?[indexPath.row] {
                    do {
                        try realm.write {
                            realm.delete(task)
                        }
                    } catch {
                        print("Error deleting an item \(error)")
                    }
                }
            }
            reloadData()
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        moveRowAt sourceIndexPath: IndexPath,
        to destinationIndexPath: IndexPath
    ) {
        if let currentCategory = selectedCategory {
            do {
                try realm.write {
                    currentCategory.tasks.move(from: sourceIndexPath.row, to: destinationIndexPath.row)
                }
            } catch {
                print("Error during reordering cells, \(error)")
            }
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        shouldIndentWhileEditingRowAt indexPath: IndexPath
    ) -> Bool {
         false
    }
    
    func tableView(
        _ tableView: UITableView,
        editingStyleForRowAt indexPath: IndexPath
    ) -> UITableViewCell.EditingStyle {
         .none
    }
    
    @objc func tapEditButton(sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        sender.title = (tableView.isEditing) ? L10n.tapToSaveCellsOrder : L10n.tapToReorderCellsButtonText
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
        
        view.addSubview(customView)
        
        customView.isHidden = false
        
        customView.snp.makeConstraints { make in
            make.width.equalTo(380)
            make.height.equalTo(30)
            make.top.equalTo(textField.snp.bottom)
            make.centerX.equalToSuperview().offset(5)
        }
        tableView.snp.removeConstraints()
        tableView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.top.equalTo(customView.snp.bottom).offset(5)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.placeholder = L10n.enterItemTitleMessage
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool { true }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.text != "" {
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newTask = Task()
                        newTask.title = textField.text!
                        newTask.done = false
                        currentCategory.tasks.append(newTask)
                    }
                } catch {
                    print("Error saving new item, \(error)")
                }
            }
        }
        
        textField.text = ""
        
        customView.isHidden = true
        
        tableView.snp.removeConstraints()
        
        tableView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.top.equalTo(textField.snp.bottom).offset(12)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }
        reloadData()
    }
    
    // Max length UITextField
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let MAX_LENGTH = 48
        let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        return updatedString.count <= MAX_LENGTH
    }
    
    func loadItems() {
        checklistItems = selectedCategory?.tasks.sorted(byKeyPath: "id")
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}
