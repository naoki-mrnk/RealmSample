//
//  Items.swift
//  RealmSample
//
//  Created by cmStudent on 2021/07/06.
//

import Foundation
import RealmSwift

class Items:Object {
    @objc dynamic var id: String = NSUUID().uuidString
    @objc dynamic var itemName: String = ""
    @objc dynamic var createAt = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
