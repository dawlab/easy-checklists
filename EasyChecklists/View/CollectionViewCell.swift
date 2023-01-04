//
//  CollectionViewCell.swift
//  EasyChecklists
//
//  Created by Dawid Łabno on 27/12/2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    
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
    
    private func layout() {
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
            make.left.equalTo(contentView.snp.left).offset(10)
        }
        
        contentView.addSubview(categoryName)
        
        categoryName.snp.makeConstraints { make in
            make.top.equalTo(rectangle.snp.bottom)
            make.bottom.equalTo(contentView.snp.bottom)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-10)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
//        contentView.backgroundColor = .systemGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func prepareForReuse() {
//        super
//            .prepareForReuse()
////        taskTitle.text = nil
//    }
}
