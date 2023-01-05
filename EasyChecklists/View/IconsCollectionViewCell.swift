//
//  IconsCollectionViewCell.swift
//  EasyChecklists
//
//  Created by Dawid Łabno on 04/01/2023.
//

import UIKit

class IconsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "IconsCollectionViewCell"
    
    let imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.tintColor = .systemGray
        return imgView
    }()
    
    private func layout() {
        contentView.addSubview(imgView)
        
        imgView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray6
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
