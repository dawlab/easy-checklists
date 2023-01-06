//
//  SettingsViewController.swift
//  EasyChecklists
//
//  Created by Dawid Łabno on 13/12/2022.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
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
        desc.text = """
        Checklists are a simple but effective tool that can help you to be more productive and efficient.
        
        They can help you to prioritize your work, and make it easier to delegate tasks to others.
        
        In addition, checklists can serve as a record of your progress and accomplishments, and can be used to identify areas for improvement.
        """
        return desc
    }()
    
    private func layout() {
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
        navigationItem.title = "Settings"
        layout()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
