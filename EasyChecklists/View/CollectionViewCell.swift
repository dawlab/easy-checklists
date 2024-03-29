//
//  CollectionViewCell.swift
//  EasyChecklists
//
//  Created by Dawid Łabno on 27/12/2022.
//
import UIKit
import SnapKit

final class CollectionViewCell: UICollectionViewCell {
    var rectangle: UIView = {
        var rectangle = UIView()
        
        rectangle.layer.cornerRadius = 15
        rectangle.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        rectangle.backgroundColor = UIColor.systemBlue
        
        return rectangle
    }()
    
    let secondRectangle: UIView = {
        let secondRectangle = UIView()
        
        secondRectangle.layer.cornerRadius = 50
        secondRectangle.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        secondRectangle.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        
        return secondRectangle
    }()
    
    let imgView: UIImageView = {
        let imgView = UIImageView()
        
        imgView.tintColor = .systemGray5
        
        return imgView
    }()
    
    let categoryName: UILabel = {
        let categoryName = UILabel()
        
        categoryName.font = .boldSystemFont(ofSize: 16)
        categoryName.adjustsFontSizeToFitWidth = true
        categoryName.numberOfLines = 0
        categoryName.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        return categoryName
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        contentView.backgroundColor = .systemGray6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(rectangle)
        
        rectangle.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(contentView.snp.bottom).offset(-40)
        }
        
        contentView.addSubview(secondRectangle)
        
        secondRectangle.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right).offset(-90)
            make.bottom.equalTo(contentView.snp.bottom).offset(-40)
        }
        
        contentView.addSubview(imgView)
        
        imgView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(35)
            make.left.equalTo(contentView.snp.left).offset(16)
        }
        
        contentView.addSubview(categoryName)
        
        categoryName.snp.makeConstraints { make in
            make.top.equalTo(rectangle.snp.bottom)
            make.bottom.equalTo(contentView.snp.bottom)
            make.left.equalTo(contentView.snp.left).offset(5)
            make.right.equalTo(contentView.snp.right).offset(-10)
        }
    }
}
