//
//  Data.swift
//  EasyChecklists
//
//  Created by Dawid Łabno on 01/01/2023.
//

import Foundation
import RealmSwift

class Data: Object {
    var title: String = ""
    var done: Bool = false
}
