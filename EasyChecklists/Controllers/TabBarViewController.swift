//
//  TabBarViewController.swift
//  EasyChecklists
//
//  Created by Dawid Łabno on 13/12/2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let checklistsTab = UINavigationController(rootViewController: ItemsViewController())
    
        let checklistsTabItem = UITabBarItem(title: "All checklists", image: UIImage(systemName: "checklist"), selectedImage: UIImage(systemName: "checklist.checked"))
        
        checklistsTab.tabBarItem = checklistsTabItem
        
        let settingsTab = UINavigationController(rootViewController: SettingsViewController())
        
        let settingsTabItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
        
        settingsTab.tabBarItem = settingsTabItem
        
        viewControllers = [checklistsTab, settingsTab]
    }
}
