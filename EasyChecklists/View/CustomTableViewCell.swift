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
    
    public let completed: UIButton = {
        let completed = UIButton()
        completed.setImage(UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20.0)), for: .normal)
        
        completed.setImage(UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20.0)), for: .selected)
        
        return completed
    }()
    
    let taskTitle: UILabel = {
        let taskTitle = UILabel()
        taskTitle.font = .boldSystemFont(ofSize: 16)
        return taskTitle
    }()
    
    let delete: UIButton = {
        let delete = UIButton()
        
        delete.setImage(UIImage(systemName: "multiply.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20.0))?.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .normal)
        
        delete.setImage(UIImage(systemName: "multiply.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20.0))?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .selected)
        
        return delete
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        layout()
    }
    
    private func layout() {
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
        
        contentView.addSubview(delete)
        
        delete.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.right.equalTo(contentView).offset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super
            .prepareForReuse()
        taskTitle.text = nil
    }
}
