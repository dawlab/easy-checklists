//
//  ViewController.swift
//  ToDoList
//
//  Created by Dawid Łabno on 16/11/2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
        
    var itemsArray = [
        "Call the bank",
        "Make a shopping list",
        "Clean up in the room",
        "Buy dog food",
        "Register to a doctor",
        "Plan your weekend",
        "Make a list of books to read",
        "Make a list of movies to watch",
        "Order supplements",
        "Do a workout",
        "Buy a gift for Mom"
    ]

    let defaults = UserDefaults.standard
    
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type task title here.."
        textField.clearsOnBeginEditing = true
        textField.borderStyle = .roundedRect
        textField.adjustsFontSizeToFitWidth = true
        
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var taskList: UITableView = {
        let taskList = UITableView()
        taskList.delegate = self
        taskList.dataSource = self
        
        return taskList
    }()
    
    private lazy var box: UIView = {
        let box = UIView()
        
        return box
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if defaults.array(forKey: "taskList")?.isEmpty == false {
            itemsArray = defaults.array(forKey: "taskList") as! [String]
        }
        
        layout()
    }
    
    private func layout() {
        
        view.addSubview(box)
        box.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            }

        view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.width.equalTo(380)
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(taskList)
        taskList.snp.makeConstraints { (make) in
            make.width.equalTo(400)
            make.height.equalTo(700)
            
            make.top.equalTo(textField.snp.bottom)
            

        }
        
    }
    
    //MARK - TavleView DataSource Methods
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "TaskCell")
                
        let itemTitle = itemsArray.reversed()[indexPath.row]
        
        cell.textLabel?.text = itemTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            itemsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            defaults.set(itemsArray, forKey: "taskList")
            
            tableView.endUpdates()
        }
    }
    
    
    func addNewTask(taskName: String) {
        itemsArray.append(taskName)
        
        defaults.set(itemsArray, forKey: "taskList")
        
        taskList.reloadData()
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
            addNewTask(taskName: task)
        } else {
            print("Type something")
        }
        
        textField.text = ""
    }
    
    
    

}
