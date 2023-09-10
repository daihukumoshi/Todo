//
//  TodoItem.swift
//  Todo
//
//  Created by 三木　杏夏 on 2023/09/04.
//

import Foundation
import RealmSwift

class TodoItem: Object {
    @Persisted var title: String = ""
    @Persisted var id : String = NSUUID().uuidString
    @Persisted var category: Category?
}
