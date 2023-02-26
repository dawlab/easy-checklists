//
//  SettingsViewController.swift
//  EasyChecklists
//
//  Created by Dawid Łabno on 13/12/2022.
//

import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    private lazy var box: UIView = {
        let box = UIView()
        box.backgroundColor = .systemGray6
        return box
    }()
    
    private lazy var desc: UILabel = {
        let desc = UILabel()
        desc.numberOfLines = 0
        desc.lineBreakMode = .byWordWrapping
        desc.font.withSize(18)
        desc.sizeToFit()
        desc.text = L10n.aboutChecklists
        return desc
    }()
    
    private func setupLayout() {
        view.addSubview(box)
        
        box.snp.makeConstraints { make -> Void in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(desc)
        
        desc.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(10)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-10)
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
        navigationItem.title = L10n.settingsViewTitle
        setupLayout()
    }
}
