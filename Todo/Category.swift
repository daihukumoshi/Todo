//
//  Category.swift
//  Todo
//
//  Created by 三木　杏夏 on 2023/09/10.
//

import Foundation
import RealmSwift

class Category: Object{
    @Persisted var title: String = ""
    @Persisted var id : String = NSUUID().uuidString
}
