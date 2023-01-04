//
//  ViewController.swift
//  ToDoList
//
//  Created by Dawid Łabno on 16/11/2022.
//

import UIKit
import SnapKit
import CoreData

class ItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var itemsArray = [Task]()
    var selectedCategory: Checklist? {
        didSet {
//            loadItems()
        }
    }
    let customView = CustomView()
    var changedTextField: UITextField?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type task title here.."
        textField.clearsOnBeginEditing = true
        textField.borderStyle = .roundedRect
        textField.adjustsFontSizeToFitWidth = true
        textField.delegate = self
        return textField
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self,
                           forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    private lazy var box: UIView = {
        let box = UIView()
        return box
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = selectedCategory?.name
        navigationItem.backButtonTitle = "Back"
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(tapDeleteListButton(sender: )))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(tapEditButton(sender: )))

        layout()
    }

    private func layout() {
        view.addSubview(box)

        box.snp.makeConstraints { make -> Void in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

        view.addSubview(textField)

        textField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(5)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-5)
        }

        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(12)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         itemsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        tableView.rowHeight = 50
        cell.taskTitle.text = itemsArray[indexPath.row].title
        cell.taskTitle.numberOfLines = 0
        cell.taskTitle.lineBreakMode = NSLineBreakMode.byWordWrapping

        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        cell.selectedBackgroundView = backgroundView

        if itemsArray[indexPath.row].done == true {
            cell.completed.isSelected = true
            cell.taskTitle.textColor = .gray
        } else {
            cell.completed.isSelected = false
            cell.taskTitle.textColor = .black
        }

        cell.completed.addTarget(self, action: #selector((tapCompletedButton(sender:))), for: .touchUpInside)

        cell.delete.addTarget(self, action: #selector((tapDeleteButton(sender:))), for: .touchUpInside)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        let selectedItem = itemsArray[indexPath.row].title
        let alert = UIAlertController(title: "Edit", message: "Edit item", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Update",
                                      style: UIAlertAction.Style.default,
                                      handler: {_ in
            let updatedItem = self.changedTextField?.text
            self.itemsArray[indexPath.row].title = updatedItem!
//            self.saveItems()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))

        alert.addTextField { textField in
            self.changedTextField = textField
            self.changedTextField?.placeholder = "Please update item"
            self.changedTextField?.text = selectedItem

        }

        self.present(alert, animated: true, completion: nil)
    }

    @objc func tapCompletedButton(sender: UIButton) {
        if let superview = sender.superview, let cell = superview.superview as? CustomTableViewCell {
            if let indexPath = tableView.indexPath(for: cell) {
                if itemsArray[indexPath.row].done == false {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                }
                itemsArray[indexPath.row].done = !itemsArray[indexPath.row].done
//                saveItems()
            }
        }
    }

    @objc func tapDeleteButton(sender: UIButton) {
        if let superview = sender.superview, let cell = superview.superview as? CustomTableViewCell {
            if let indexPath = tableView.indexPath(for: cell) {
//                context.delete(itemsArray[indexPath.row])
                itemsArray.remove(at: indexPath.row)
//                saveItems()
            }
        }
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObjTemp = itemsArray[sourceIndexPath.row]
        itemsArray.remove(at: sourceIndexPath.row)
        itemsArray.insert(movedObjTemp, at: destinationIndexPath.row)
//        saveItems()
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

    @objc func tapEditButton(sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        sender.title = (tableView.isEditing) ? "Done" : "Edit"
    }

    @objc func tapDeleteListButton(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Usuń",
                                      message: "Czy chcesz usunąć wszystkie elementy na tej liście?",
                                      preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Tak, usuwam",
                                      style: UIAlertAction.Style.default,
                                      handler: {_ in
            self.itemsArray.removeAll()
//            self.saveItems()
        }))
        alert.addAction(UIAlertAction(title: "Anuluj", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
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
        textField.placeholder = "Type task title here.."
        textField.endEditing(true)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool { true }

    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField.text != "" {
//            if let task = textField.text {
//                let newTask = Task(context: context)
//                newTask.title = task
//                newTask.done = false
//                newTask.parentCategory = selectedCategory
//                itemsArray.append(newTask)
//                saveItems()
//            }
//        }
        textField.text = ""

        customView.isHidden = true

        tableView.snp.removeConstraints()

        tableView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.top.equalTo(textField.snp.bottom).offset(12)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }
    }

    // Max length UITextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let MAX_LENGTH = 48
        let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        return updatedString.count <= MAX_LENGTH
    }

//    func saveItems() {
//        do {
//            try context.save()
//        } catch {
//            print("Error saving context, \(error)")
//        }
//        tableView.reloadData()
//    }
//
//    func loadItems(with request: NSFetchRequest<Task> = Task.fetchRequest()) {
//        let predicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//        request.predicate = predicate
//
//        do {
//          itemsArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context, \(error)")
//        }
//    }

    func reloadData() {
        tableView.reloadData()
    }
}
