//
//  TabBarViewController.swift
//  EasyChecklists
//
//  Created by Dawid Łabno on 13/12/2022.
//

import UIKit
import L10n_swift

final class TabBarViewController: UITabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let checklistsTab = UINavigationController(rootViewController: CategoryViewController())
    
        let checklistsTabItem = UITabBarItem(title: L10n.allChecklistsTabBarLabel,
                                             image: UIImage(systemName: L10n.checklistsIcon),
                                             selectedImage: UIImage(systemName: L10n.checkListsIconSelected))
        
        checklistsTab.tabBarItem = checklistsTabItem
        
        let settingsTab = UINavigationController(rootViewController: SettingsViewController())
        
        let settingsTabItem = UITabBarItem(title: L10n.settingsTabBarLabel,
                                           image: UIImage(systemName: L10n.settingsIcon),
                                           selectedImage: UIImage(systemName: L10n.settingsIconSelected))
        
        settingsTab.tabBarItem = settingsTabItem
        
        viewControllers = [checklistsTab, settingsTab]
    }
}
