//
//  CustomView.swift
//  EasyChecklists
//
//  Created by Dawid Łabno on 13/12/2022.
//

import UIKit
import SnapKit

final class CustomView: UIView {
    let customTextField: UITextField = {
        let customTextField = UITextField()
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.white
        ]
        
        customTextField.attributedPlaceholder = NSAttributedString(string: "Type task title above.",
                                                                   attributes: textAttributes)
        customTextField.borderStyle = .none
        customTextField.adjustsFontSizeToFitWidth = true
        
        return customTextField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(customTextField)
        
        customTextField.snp.makeConstraints { make in
            make.width.equalTo(380)
            make.height.equalTo(30)
        }
    }
}
