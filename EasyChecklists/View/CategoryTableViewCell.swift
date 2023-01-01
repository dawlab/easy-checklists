//
//  CategoryTableViewCell.swift
//  EasyChecklists
//
//  Created by Dawid Łabno on 23/12/2022.
//

import UIKit
import SnapKit

class CategoryTableViewCell: UITableViewCell {
    static let identifier = "CategoryTableViewCell"
    
    let taskTitle: UILabel = {
        let taskTitle = UILabel()

        return taskTitle
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    private func layout() {
        contentView.addSubview(taskTitle)
        
        taskTitle.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(250)
            make.left.equalTo(safeAreaLayoutGuide.snp.right).offset(-20)
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
