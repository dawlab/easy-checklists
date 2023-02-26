//
//  IconsCollectionViewCell.swift
//  EasyChecklists
//
//  Created by Dawid Łabno on 04/01/2023.
//

import UIKit
import SnapKit

final class IconsCollectionViewCell: UICollectionViewCell {
    let imgView: UIImageView = {
        let imgView = UIImageView()
        
        imgView.tintColor = .systemGray
        
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemGray6
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(imgView)
        
        imgView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
        }
    }
}
