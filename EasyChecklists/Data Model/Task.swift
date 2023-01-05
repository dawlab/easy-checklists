//
//  Task.swift
//  EasyChecklists
//
//  Created by Dawid Łabno on 02/01/2023.
//

import Foundation
import RealmSwift

class Task: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Checklist.self, property: "tasks")
}
