//
//  CustomTableViewCell.swift
//  TestCustomCells
//
//  Created by Dawid Łabno on 26/11/2022.
//

import UIKit
import SnapKit

final class CustomTableViewCell: UITableViewCell {
    let completed: UIButton = {
        let completed = UIButton()
        
        completed.setImage(getImage(named: "circle"), for: .normal)
        completed.setImage(getImage(named: "checkmark.circle.fill"), for: .selected)
        
        return completed
    }()
    
    let taskTitle: UILabel = {
        let taskTitle = UILabel()
        taskTitle.font = .boldSystemFont(ofSize: 16)
        return taskTitle
    }()
    
    let deleteButton: UIButton = {
        let delete = UIButton()
        
        delete.setImage(getImage(named: "multiply.circle")?.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .normal)
        delete.setImage(getImage(named: "multiply.circle.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .selected)
        
        return delete
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        taskTitle.text = nil
    }
    
    private func setupLayout() {
        contentView.addSubview(completed)
        
        completed.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.left.equalTo(contentView).offset(-20)
        }
        
        contentView.addSubview(taskTitle)
        
        taskTitle.snp.makeConstraints { make in
            make.height.equalTo(completed)
            make.width.equalTo(250)
            make.left.equalTo(completed.snp.right).offset(-20)
        }
        
        contentView.addSubview(deleteButton)
        
        deleteButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.right.equalTo(contentView).offset(20)
        }
    }
    
    private static func getImage(named systemName: String) -> UIImage? {
        UIImage(systemName: systemName,
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 20.0))
    }
}
