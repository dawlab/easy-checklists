//
//  ViewController.swift
//  ToDoList
//
//  Created by Dawid Łabno on 16/11/2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var itemsArray = [Task]()
    let customView = CustomView()
    
    let dataFilePath = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask)
        .first?.appendingPathComponent("Items.plist")
    
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
        loadItems()
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
            make.width.equalTo(380)
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.width.equalTo(410)
            make.height.equalTo(700)
            make.top.equalTo(textField.snp.bottom)
            make.centerX.equalToSuperview()
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
    }
    
    @objc func tapCompletedButton(sender: UIButton) {
        if let superview = sender.superview, let cell = superview.superview as? CustomTableViewCell {
            if let indexPath = tableView.indexPath(for: cell) {
                if itemsArray[indexPath.row].done == false {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                }
                itemsArray[indexPath.row].done = !itemsArray[indexPath.row].done
                saveItems()
            }
        }
    }
    
    @objc func tapDeleteButton(sender: UIButton) {
        if let superview = sender.superview, let cell = superview.superview as? CustomTableViewCell {
            if let indexPath = tableView.indexPath(for: cell) {
                itemsArray.remove(at: indexPath.row)
                saveItems()
            }
        }
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
            make.width.equalTo(380)
            make.height.equalTo(700)
            make.top.equalTo(customView.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.placeholder = "Type task title here.."
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something!"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let task = textField.text {
            let newTask = Task()
            newTask.title = task
            itemsArray.append(newTask)
            saveItems()
        } else {
            print("Type something")
        }
        textField.text = ""
        
        customView.isHidden = true
        
        tableView.snp.removeConstraints()
        
        tableView.snp.makeConstraints { make in
            make.width.equalTo(380)
            make.height.equalTo(700)
            make.top.equalTo(textField.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
    // Max length UITextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let MAX_LENGTH = 48
        let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        return updatedString.count <= MAX_LENGTH
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemsArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemsArray = try decoder.decode([Task].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
    }
}
