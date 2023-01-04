//
//  Category.swift
//  EasyChecklists
//
//  Created by Dawid Łabno on 02/01/2023.
//

import Foundation
import RealmSwift
import UIKit

class Checklist: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = "UIColor.systemBlue"
    @objc dynamic var icon: String = "box"
    let tasks = List<Task>()
    
}
