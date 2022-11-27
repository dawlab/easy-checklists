//
//  CustomTableViewCell.swift
//  TestCustomCells
//
//  Created by Dawid Łabno on 26/11/2022.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    static let identifier = "CustomTableViewCell"
    
    private let completed: UIButton = {
        let completed = UIButton()
        //completed.setBackgroundImage(UIImage(systemName: "circle"), for: UIControl.State.normal)
        completed.setImage(UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20.0)), for: .normal)
        completed.setImage(UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20.0)), for: .selected)
        completed.addTarget(self, action: #selector(completedButtonTapped), for: .touchUpInside)

        return completed
    }()
    
    private let taskTitle: UILabel = {
        let taskTitle = UILabel()
        taskTitle.text = "Example task"

        return taskTitle
    }()
    
    private let delete: UIButton = {
        let delete = UIButton()
        delete.setImage(UIImage(systemName: "multiply.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20.0))?.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .normal)
        delete.setImage(UIImage(systemName: "multiply.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20.0))?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .selected)
        delete.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)


        return delete
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    private func layout() {
        
        contentView.addSubview(completed)
    
        completed.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.left.equalTo(contentView).offset(-20)
        }
        
        contentView.addSubview(taskTitle)

        taskTitle.snp.makeConstraints { (make) in
            make.height.equalTo(completed)
            make.width.equalTo(contentView)
            make.left.equalTo(completed.snp.right).offset(-20)
        }

        contentView.addSubview(delete)
        
        delete.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.right.equalTo(contentView).offset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(text: String) {
        taskTitle.text = text
    }
    
    public func completedStatus(done: Bool) {
        if done == true {
            completed.isSelected = true
        } else {
            completed.isSelected = false
        }
    }
    
    @objc public func completedButtonTapped(done: Bool) {

        //completed.isSelected = !completed.isSelected


    }
    @objc public func deleteButtonTapped() {
        delete.isSelected = !delete.isSelected

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        taskTitle.text = nil
    }
}

