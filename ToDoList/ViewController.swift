//
//  ViewController.swift
//  ToDoList
//
//  Created by Dawid Łabno on 16/11/2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var itemsArray = ["Learn Swift", "Buy a milk", "Send a message"]
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }
    
    private func layout() {
        
        view.addSubview(textField)
        textField.snp.makeConstraints { (maker) in
            maker.width.equalTo(380)
            maker.height.equalTo(50)
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview().offset(-320)
        }
        
        view.addSubview(taskList)
        taskList.snp.makeConstraints { (maker) in
            maker.width.equalTo(400)
            maker.height.equalTo(500)
            maker.top.equalTo(textField.snp.bottom).offset(20)
            maker.bottom.equalToSuperview()
            maker.centerX.equalToSuperview()

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
    
    func fetchTask(taskName: String) {
        itemsArray.append(taskName)
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
            fetchTask(taskName: task)
        } else {
            print("Type something")
        }
        
        textField.text = ""
    }
    
    
    

}
