//
//  Data.swift
//  EasyChecklists
//
//  Created by Dawid Łabno on 01/01/2023.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
}
