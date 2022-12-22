//
//  CustomView.swift
//  EasyChecklists
//
//  Created by Dawid Łabno on 13/12/2022.
//

import UIKit
import SnapKit

class CustomView: UIView {
    let customTextField: UITextField = {
        let customTextField = UITextField()
        customTextField.attributedPlaceholder = NSAttributedString(string: "Type task title above.", attributes: [
            .font: UIFont.systemFont(ofSize: 14)
        ])
        customTextField.borderStyle = .none
        customTextField.adjustsFontSizeToFitWidth = true
        return customTextField
    }()
    
    private func layout() {
        
        addSubview(customTextField)
        
        customTextField.snp.makeConstraints { make in
            make.width.equalTo(380)
            make.height.equalTo(30)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
